{ config, pkgs, lib, inputs, ... }:

{
  programs.dconf.enable = true;  # for home-manager

  # User configurations
  users.users.archbung = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };
  environment.pathsToLink = [ "/share/zsh" ];

  # Locale configurations
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
    console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Networking
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # Sound configurations
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Nix configurations
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = "experimental-features = nix-command ca-references flakes";
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://cachix.cachix.org/"
      "https://nix-community.cachix.org"
    ];
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
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
      options = "--delete-older-than 7d";
    };
  };

  system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
  system.stateVersion = "21.05";

  # Bare necessities
  environment.systemPackages = with pkgs; [
    cached-nix-shell
    coreutils
    pulsemixer
  ];
}
