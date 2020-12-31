{ self, lib, ... }:

let
  inherit (builtins) attrValues readDir pathExists mapAttrs';
  inherit (lib) filterAttrs hasPrefix hasSuffix nameValuePair removeSuffix;
in rec {
  mapFilterAttrs = p: f: attrs:
    filterAttrs p (mapAttrs' f attrs);

  mapModules = dir: f:
    mapFilterAttrs
      (n: v: v != null && !(builtins.hasPrefix "_" n))
      (n: v:
        let path = "${toString dir}/${n}"; in
        if v == "directory" && builtins.pathExists "${path}/default.nix"
        then builtins.nameValuePair n (f path)
        else if v == "regular" && n != "default.nix" && builtins.hasSuffix ".nix" n
        then builtins.nameValuePair (builtins.removeSuffix ".nix" n) (f path)
        else builtins.nameValuePair "" null)
      (builtins.readDir dir);
}
