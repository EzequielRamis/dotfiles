{ lib, ... }:

let
  read = p:
    with builtins;
    with lib.attrsets;
    listToAttrs (map (c: {
      name = elemAt c 0;
      value = elemAt c 1;
    }) (collect isList (mapAttrsRecursive
      (path: value: [ (lib.strings.concatStrings path) value ])
      (mapAttrs (_: c: mapAttrs (_: v: v.value) c) (fromJSON (readFile p))))));
in read ./palette.json
