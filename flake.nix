{
  description = "A simple flake-based NixOS configuration.";

  inputs = {
    nixpkgs.url = "nixpkgs/master";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    flake-utils.url = "github:gytis-ivaskevicius/flake-utils-plus/staging";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    mozilla-overlay = {
      url = "github:mozilla/nixpkgs-mozilla";
      flake = false;
    };
  };

  outputs = inputs @ { self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.systemFlake {
      inherit self inputs;

      # Channel definitions
      channels.nixpkgs.input = nixpkgs;
      channelsConfig = {
        allowUnfree = true;
      };

      sharedOverlays = [
        inputs.nur.overlay
        inputs.emacs-overlay.overlay
        inputs.neovim-nightly-overlay.overlay
        (final: prev: import (inputs.mozilla-overlay) final prev)
      ];

      nixosModules = flake-utils.lib.modulesFromList [
        ./modules/config.nix
        ./modules/fonts.nix
        ./modules/security.nix
        ./modules/X11.nix
        ./modules/virtualization.nix
      ];

      # Default host configurations
      hostDefaults = {
        system = "x86_64-linux";
        # To avoid `infinite recursion` error in hardware-configuration.nix
        # due to taking `inputs` as an argument.
        specialArgs = { inherit flake-utils inputs; };
        modules = with self.nixosModules; [
          config
          fonts
          security
          X11

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.archbung = import ./nixpkgs;
          }
        ];
      };

      hosts = {
        heisenberg.modules = with self.nixosModules; [
          ./hosts/heisenberg
          virtualization
        ];
      };
    };
}
