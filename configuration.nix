{ config, pkgs, lib, modulesPath, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];


  # Bare necessities
  environment.systemPackages = with pkgs; [
    cached-nix-shell
    coreutils

    pulsemixer  # for pulseaudio
  ];
  programs.dconf.enable = true;  # for home-manager


  # User configuration
  users.users.archbung = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  environment.pathsToLink = [ "/share/zsh" ];


  # Locale
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
    console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };


  # Networking
  networking = {
    hostName = "heisenberg";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.enp34s0.useDHCP = true;
    interfaces.wlo1.useDHCP = true;     
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };


  # Sound
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true; # for Steam
    package = pkgs.pulseaudioFull;    
  };


  # GUI
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e,ctrl:nocaps";
    libinput = {
      enable = true;
      mouse.naturalScrolling = true;
    };
    displayManager.startx.enable = true;
    xrandrHeads = [
      {
        output = "DVI-D-0";
        primary = true;
      }
      {
        output = "DisplayPort-0";
        monitorConfig =
        ''
        Option "RightOf" "DVI-D-0"
        '';
      }
    ];
  };


  # Virtualization
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };


  # Security
  security.protectKernelImage = true;
  boot.loader.systemd-boot.editor = false;


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
