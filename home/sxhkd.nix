{ config, lib, pkgs, ... }:
let
  mkHotkeyChain = set:
    with builtins;
    with lib.attrsets;
    with lib.strings;
    listToAttrs (map (c: {
      name = elemAt c 0;
      value = elemAt c 1;
    }) (collect isList
      (mapAttrsRecursive (path: value: [ (concatStrings path) value ]) set)));
  prefix = c: with lib.attrsets; mapAttrs' (n: v: nameValuePair "${c}${n}" v);
  plus = prefix " + ";
  chord = prefix " ; ";
  chord' = prefix " : ";
in {
  services.sxhkd = {
    enable = true;
    keybindings = mkHotkeyChain {
      "alt + {_,shift + }Tab" = "bspc node -f {next,prev}.leaf";
      super = plus {
        # reload sxhkd
        shift = plus { Escape = "pkill -USR1 -x sxhkd"; };
        "{w,a,s,d}" = "bspc node -f {north,west,south,east}.leaf";
        Return = "$TERMINAL";
        space = "rofi -show run";
        f = "bspc desktop -l next";
        p = "bspc node -g sticky";
      };
    };
  };
}
