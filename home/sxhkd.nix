{ config, lib, pkgs, ... }:
let
  mkHotkeyChain = sep: set:
    with builtins;
    with lib.attrsets;
    with lib.strings;
    listToAttrs (map (c: {
      name = elemAt c 0;
      value = elemAt c 1;
    }) (collect isList
      (mapAttrsRecursive (path: value: [ (concatStringsSep sep path) value ])
        set)));
  hkc = mkHotkeyChain " ; ";
  hkc' = mkHotkeyChain " : ";
in {
  services.sxhkd = {
    enable = true;
    keybindings = hkc {
      "super + space" = "rofi -show run";
      "super + f" = "bspc desktop -l next";
      "super + p" = "bspc node -g sticky";
      "alt + {_,shift + }Tab" = "bspc node -f {next,prev}";
    };
  };
}
