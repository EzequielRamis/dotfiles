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
  none = prefix " ";

  step = "10";
  desks' = 4;
  desks = "{1-${toString desks'}}";
  bottom_padding = 32;
in {
  xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      inherit bottom_padding;
      window_gap = 16;
      border_width = 2;
      split_ratio = 0.5;
      gapless_monocle = false;
      borderless_monocle = true;
      single_monocle = true;
    };
    rules = { Emacs = { state = "tiled"; }; };
    monitors = { Virtual1 = map toString (lib.lists.range 1 desks'); };
  };
  services.sxhkd = {
    enable = true;
    keybindings = mkHotkeyChain {
      "alt + {_,shift + }Tab" = "bspc node -f {next,prev}.leaf.local";

      super = plus {
        # reload sxhkd
        Escape = "pkill -USR1 -x sxhkd; bspc wm -r";
        Return = "$TERMINAL";
        f = "bspc desktop -l next";
        m = "bspc node @/first -f";
        t = "bspc node -t {floating,tiled}";
        p = "bspc node -g sticky";
        x = "bspc node -c";
        b = "bspc node @parent -B";
        g = "bspc node @parent -E";
        "{q,e}" = "bspc node @parent -F {horizontal,vertical}";
        "{w,a,s,d}" = "bspc node -f {north,west,south,east}.leaf";
        "${desks}" = "bspc desktop -f ${desks}";

        shift = plus {
          f = ''
            {\
              eww close bar; bspc config bottom_padding 0,\
              bspc config bottom_padding ${
                toString bottom_padding
              }; eww open bar\
              }'';
          x = "bspc node -k";
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
          "{1-9}" = "bspc node @parent -r 0.{1-9}";
        };

        alt = plus {
          f = "bspc node -t {fullscreen,tiled}";
          m = "bspc node -s biggest.window";
          "{q,e}" = "bspc node @parent -C {backward,forward}";
          "{w,a,s,d}" = ''
            {\
              bspc node focused.tiled    -s north.leaf; \
              bspc node focused.floating -v 0 -${step}, \
              bspc node focused.tiled    -s west.leaf;  \
              bspc node focused.floating -v -${step} 0, \
              bspc node focused.tiled    -s south.leaf; \
              bspc node focused.floating -v 0 +${step}, \
              bspc node focused.tiled    -s east.leaf;  \
              bspc node focused.floating -v +${step} 0, \
              }'';
          "${desks}" = "bspc node -d ${desks}";
          shift = plus {
            q = "bspc node -p {north,south}";
            e = "bspc node -p {west,east}";
            w = "bspc node -g marked";
            a = "bspc node -n last.!automatic.local";
            s = "bspc node -s last.marked";
            d = "bspc node -p cancel; bspc node -g marked=off";
            "${desks}" = "bspc node -d ${desks} -f";
          };
        };

        space = chord {
          "{_,super + }" = none {
            space = "rofi -show drun";
            q = ''
              rofi -show p -modi "p:rofi-power --choices=shutdown/reboot/logout" -theme power'';
            u = "rofi -show emoji";
            f = "firefox";
            e = "emacsclient -c -a ''";
          };
        };
      };
    };
  };
}
