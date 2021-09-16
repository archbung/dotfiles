{
  description = "A flake-based NixOS configuration.";

  inputs = {
    nixpkgs.url = "nixpkgs/master";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    flake-utils.url = "github:gytis-ivaskevicius/flake-utils-plus/staging";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.systemFlake {
      inherit self inputs;

      # Channel definitions
      channels.nixpkgs.input = nixpkgs;
      channelsConfig.allowUnfree = true;

      sharedOverlays = with inputs; [
        neovim-nightly-overlay.overlay
        emacs-overlay.overlay
      ];

      nixosModules = flake-utils.lib.modulesFromList [
        ./modules/common.nix
        ./modules/fonts.nix
        ./modules/network.nix
        ./modules/security.nix
        ./modules/sound.nix
        ./modules/X11.nix
        ./modules/virtualization.nix
      ];

      hostDefaults = {
        system = "x86_64-linux";
        specialArgs = { inherit flake-utils inputs; };
        modules = with self.nixosModules; [
          common
          fonts
          network
          security
          sound
          X11
          inputs.home-manager.nixosModules.home-manager {
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
