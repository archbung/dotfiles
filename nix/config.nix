{ 
  allowUnfree = true; 

  packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  permittedInsecurePackages = [
    "spidermonkey-38.8.0"
  ];
}
