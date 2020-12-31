{ inputs, config, lib, pkgs, ... }:

{
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
  };
  system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
  system.stateVersion = "20.09";

  # Use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_5_9;

  boot.loaders = {
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 10;
    systemd-boot.enable = lib.mkDefault true;
  };

  environment.systemPackages = with pkgs; [
    cached-nix-shell
    coreutils
    git
    neovim
  ];
}
