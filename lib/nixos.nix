{ inputs, lib, pkgs, ... }:

with lib;
let system = "x86_64-linux";
in {
  mkHost = path: attrs @ { system ? system, ... }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        {
          nixpkgs.pkgs = nixpkgs;
          networking.hostName =
            builtins.mkDefault (builtins.removeSuffix ".nix" (baseNameOf path));
        }
        ./.
        (import path)
      ];
    };

  mapHost = dir: attrs @ { system ? system, ... }:
    mapModules dir (hostPath: mkHost hostPath attrs);
}
