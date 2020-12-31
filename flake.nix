{
  description = "A simple flake-based NixOS configuration.";

  inputs = {
    nixpkgs.url = "nixpkgs/master";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
    let
      inherit (lib) attrValues;
      system = "x86_64-linux";

      mkPkgs = pkgs: extraOverlays: import pkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = extraOverlays ++ (builtins.attrValues self.overlays);
      };

      pkgs = mkPkgs nixpkgs [ self.overlay ];

    in {
      overlays = mapModules ./overlays import;
      packages."${system}" = mapModules ./packages (p: pkgs.callPackage p {});
      nixosConfiguration = mapHost ./hosts { inherit system; };
      # nixosConfigurations = forAllHostNames (hostName:
      #   let
      #     system = "x86_64-linux";
      #     specialArgs = { inherit pkgs; };
      #     hm-nixos-as-super = { config, ... }: {
      #       options.home-manager.users = nixpkgs.lib.mkOption {
      #         type = nixpkgs.lib.types.attrsOf
      #           (nixpkgs.lib.types.submoduleWith {
      #             modules = [ ];
      #             specialArgs = specialArgs // { super = config; };
      #           });
      #       };
      #     };

      #     modules = [
      #       home-manager.nixosModules.home-manager
      #       hm-nixos-as-super
      #       (./hosts + "/${hostName}")
      #     ];

      #   in
      #   nixpkgs.lib.nixosSystem { inherit system modules specialArgs; });
    };
}
