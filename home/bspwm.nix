{ config, lib, pkgs, ... }:
let
  mkHotkeyChain = set:
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
  desks' = 4;
  desks = "{1-${toString desks'}}";
in {
  xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      border_width = 2;
      split_ratio = 0.5;
      gapless_monocle = false;
      borderless_monocle = true;
    };
    rules = { Emacs = { state = "tiled"; }; };
    monitors = { Virtual1 = map toString (lib.lists.range 1 desks'); };
  };
  services.sxhkd = {
    enable = true;
    keybindings = mkHotkeyChain {
      "alt + {_,shift + }Tab" = "bspc node -f {next,prev}.leaf.local";

      super = plus {
        Return = "$TERMINAL";
        space = "rofi -show run";
        f = "bspc desktop -l next";
        p = "bspc node -g sticky";
        m = "bspc node @/first -f";
        k = "bspc node -c";
        "{q,e}" = "bspc node @parent -F {horizontal,vertical}";
        "{w,a,s,d}" = "bspc node -f {north,west,south,east}.leaf";
        "${desks}" = "bspc desktop -f ${desks}";

        shift = plus {
          # reload sxhkd
          Escape = "pkill -USR1 -x sxhkd";
          f = "bspc node -t {fullscreen,tiled}";
          "{q,e}" = "bspc node @parent -R {270,90}";
          # from https://www.reddit.com/r/bspwm/comments/r5stxu/resizing_windows_nicely_in_my_opinion/
          "{w,a,s,d}" = ''
            {\
              bspc node @parent/first  -z bottom 0 -${step}; \
              bspc node @parent/second -z top    0 -${step}, \
              bspc node @parent/second -z left   -${step} 0; \
              bspc node @parent/first  -z right  -${step} 0, \
              bspc node @parent/second -z top    0 +${step}; \
              bspc node @parent/first  -z bottom 0 +${step}, \
              bspc node @parent/first  -z right  +${step} 0; \
              bspc node @parent/second -z left   +${step} 0  \
              }'';
        };

        alt = plus {
          k = "bspc node -k";
          "{q,e}" = "bspc node @parent -C {backward,forward}";
          "{w,a,s,d}" = "bspc node -s {north,west,south,east}.leaf";
          "${desks}" = "bspc node -d ${desks}";
        };
      };
    };
  };
}
