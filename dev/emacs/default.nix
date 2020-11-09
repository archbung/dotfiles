{ config, pkgs, ... }:

# FIXME: Modify doom-emacs to use emacsGit
let doom-emacs = pkgs.callPackage (builtins.fetchTarball "https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz")
    {
      doomPrivateDir = ./doom;
      emacsPackagesOverlay = self: super: {
        magit-delta = super.magit-delta.overrideAttrs (super: {
          buildInputs = super.buildInputs ++ [ pkgs.git ];
        });
      };
    };
in
{
  home = {
    packages = with pkgs; [
      ripgrep fd clang emacsGit
    ];

    sessionVariables = {
      DOOMDIR = "${config.home.homeDirectory}/.config/doom";
    };

    file.".config/doom".source = ./doom;
  };

  services.emacs.socketActivation.enable = true;
}
