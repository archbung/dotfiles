[
  (import (builtins.fetchTarball {
    url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  }))

  (import (builtins.fetchTarball {
    url = https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
  }))
]
