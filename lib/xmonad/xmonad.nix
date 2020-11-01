{ mkDerivation, base, stdenv, X11, xmobar, xmonad-contrib }:
mkDerivation {
  pname = "xmonad";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base X11 xmobar xmonad-contrib ];
  license = stdenv.lib.licenses.bsd3;
}
