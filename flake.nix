{
  description = "A simple flake-based NixOS configuration.";

  inputs = {
    nixpkgs.url = "nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    mozilla-overlay = {
      url = "github:mozilla/nixpkgs-mozilla";
      flake = false;
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }:
  {
    nixosConfigurations."heisenberg" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        (import ./hosts/heisenberg)
        {
          nixpkgs.overlays = with inputs; [
            emacs-overlay.overlay
            neovim-nightly-overlay.overlay
          ];
        }
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.archbung = import ./nixpkgs;
        }
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
