{
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "/nixpkgs";
  };

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs, home-manager }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; config = { allowUnfree = true; }; };
        hostNames = [ "heisenberg" "goedel" ];
        forAllHostNames = f: nixpkgs.lib.genAttrs hostNames (hostName: f hostName);
    in
    {
      nixosConfigurations = forAllHostNames
      ( hostName:
        let system = "x86_64-linux";
            specialArgs = { inherit pkgs; };
            hm-nixos-as-super = { config, ... }: {
              options.home-manager.users = nixpkgs.lib.mkOption {
                type = nixpkgs.lib.types.attrsOf (nixpkgs.lib.types.submoduleWith {
                  modules = [];
                  specialArgs = specialArgs // { super = config; };
                });
              };
            };

            modules = [
              home-manager.nixosModules.home-manager
              hm-nixos-as-super
              (./hosts + "/${hostName}")
            ];
        in
        nixpkgs.lib.nixosSystem { inherit system modules specialArgs; }
      );
    };
}
