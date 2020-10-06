{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      stack cabal2nix cabal-install nix-prefetch-git ghcid
    ];

    file.stack-config = {
      text =
        ''
        templates:
          params:
            author-email: archbung@gmail.com
            author-name: Hizbullah Abdul Aziz Jabbar
            copyright: 'Copyright (c) 2020 Hizbullah Abdul Aziz Jabbar'
            github-username: archbung
        '';
      target = ".stack/config.yaml";
    };
  };
}
