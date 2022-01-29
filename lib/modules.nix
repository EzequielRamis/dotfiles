{ self, lib, ... }:

let
  inherit (builtins) attrValues readDir pathExists concatLists;
  inherit (lib)
    id mapAttrsToList filterAttrs hasPrefix hasSuffix nameValuePair
    removeSuffix;
  inherit (self.attrs) filterMapAttrs';
in rec {
  mapModules = dir: fn:
    filterMapAttrs' (_: v: v != null) (n: v:
      let path = "${toString dir}/${n}";
      in if v == "directory" && pathExists "${path}/default.nix" then
        nameValuePair n (fn path)
      else if v == "regular" && n != "default.nix" && hasSuffix ".nix" n then
        nameValuePair (removeSuffix ".nix" n) (fn path)
      else
        nameValuePair "" null) (readDir dir);

  mapModules' = dir: fn: attrValues (mapModules dir fn);

  importFrom = dir: mapModules' dir id;
  importFromWith = dir: s: mapModules' dir (m: import m s);

  mapModulesRec = dir: fn:
    filterMapAttrs' (_: v: v != null) (n: v:
      let path = "${toString dir}/${n}";
      in if v == "directory" then
        nameValuePair n (mapModulesRec path fn)
      else if v == "regular" && n != "default.nix" && hasSuffix ".nix" n then
        nameValuePair (removeSuffix ".nix" n) (fn path)
      else
        nameValuePair "" null) (readDir dir);

  mapModulesRec' = dir: fn:
    let
      dirs = mapAttrsToList (k: _: "${dir}/${k}")
        (filterAttrs (_: v: v == "directory") (readDir dir));
      files = attrValues (mapModules dir id);
      paths = files ++ concatLists (map (d: mapModulesRec' d id) dirs);
    in map fn paths;

  importFromRec = dir: mapModulesRec' dir id;
  importFromRecWith = dir: s: mapModulesRec' dir (m: import m s);
}
