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
  step = "10";
  step' = 10;
in {
  services.sxhkd = {
    enable = true;
    keybindings = mkHotkeyChain {
      "alt + {_,shift + }Tab" = "bspc node -f {next,prev}.leaf";

      super = plus {
        Return = "$TERMINAL";
        space = "rofi -show run";
        f = "bspc desktop -l next";
        p = "bspc node -g sticky";
        m = "bspc node @/first -f";
        k = "bspc node -c";
        "{q,e}" = "bspc node @parent -F {horizontal,vertical}";
        "{w,a,s,d}" = "bspc node -f {north,west,south,east}.leaf";

        shift = plus {
          # reload sxhkd
          Escape = "pkill -USR1 -x sxhkd";
          k = "bspc node -k";
          "{q,e}" = "bspc node @parent -R {270,90}";
          "{w,a,s,d}" = ''
          {\
            bspc node @parent/first -z bottom 0 -${step}; \
            bspc node @parent/second -z top 0 -${step}, \
            bspc node @parent/second -z left -${step} 0; \
            bspc node @parent/first -z right -${step} 0, \
            bspc node @parent/second -z top 0 +${step}; \
            bspc node @parent/first -z bottom 0 +${step}, \
            bspc node @parent/first -z right +${step} 0; \
            bspc node @parent/second -z left +${step} 0 \
            }'';
        };

        alt = plus {
          "{q,e}" = "bspc node @parent -C {backward,forward}";
          "{w,a,s,d}" = "bspc node -s {north,west,south,east}.leaf";
        };
      };
    };
  };
}
