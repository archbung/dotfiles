{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./i18n.nix
    ./networking.nix
    ./security.nix
    ./sound.nix
    ./users.nix
    ./virtualization.nix
    ./X11.nix
  ];


  # Bare necessities
  environment.systemPackages = with pkgs; [
    cached-nix-shell
    coreutils
  ];

  programs.dconf.enable = true;  # for home-manager


  # Nix configurations
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    binaryCachePublicKeys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    registry = {
      nixos.flake = inputs.nixpkgs;
      nixpkgs.flake = inputs.nixpkgs;
    };
    useSandbox = true;
    autoOptimiseStore = true;
    trustedUsers = [ "root" "archbung" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
  system.stateVersion = "21.05";
}
