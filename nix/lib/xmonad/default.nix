# { nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:
{ nixpkgs, compiler ? "default", doBenchmark ? false }:
let
  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, stdenv, X11, xmobar, xmonad-contrib }:
    mkDerivation {
      pname = "xmonad";
      version = "0.1.0.0";
      src = ./.;
      isLibrary = false;
      isExecutable = true;
      executableHaskellDepends = [ base X11 xmobar xmonad-contrib ];
      license = stdenv.lib.licenses.bsd3;
    };

  haskellPackages =
    if compiler == "default" then
      pkgs.haskellPackages
    else
      pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f { });

in
if pkgs.lib.inNixShell then drv.env else drv
