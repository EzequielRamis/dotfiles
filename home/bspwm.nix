{ config, lib, pkgs, my, ... }:
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
  top_padding = 32;
  window_gap = 16;
  t = my.palette;
in {
  xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      inherit top_padding window_gap;
      border_width = 2;
      split_ratio = 0.5;
      gapless_monocle = false;
      borderless_monocle = true;
      single_monocle = true;

      # initial light theme
      normal_border_color = t."05";
      focused_border_color = t."66";
      active_border_color = t."16";
      presel_feedback_color = t."66";
    };
    rules = {
      Emacs.state = "tiled";
      Zathura.state = "tiled";
      "*:*:Picture-in-Picture".state = "floating";
      "*:jetbrains-clion:splash".state = "floating";
      "origin.exe".state = "floating";
      "explorer.exe".hidden = true;
      "eadesktop.exe".private = true;
      "eadesktop.exe".state = "floating";
      "eadesktop.exe".center = true;
      "steam".follow = false;
    };
    monitors = { HDMI-0 = map toString (lib.lists.range 1 desks'); };
    extraConfig = ''
      bspc desktop -l monocle

      xdo lower -N "eww-bar"
      bspc subscribe node_state | while read -r _ _ _ _ state flag; do
        if [[ "$state" != fullscreen ]]; then continue; fi
        if [[ "$flag" == on ]]; then
          xdo lower -N "eww-bar"
        else
          xdo raise -N "eww-bar"
        fi
      done &
    '';
  };
  xdg.configFile."bspwm/dark".executable = true;
  xdg.configFile."bspwm/dark".text = ''
    bspc config normal_border_color '${t."0A"}'
    bspc config focused_border_color '${t."65"}'
    bspc config active_border_color '${t."15"}'
    bspc config presel_feedback_color '${t."64"}'
  '';
  xdg.configFile."bspwm/light".executable = true;
  xdg.configFile."bspwm/light".text = ''
    bspc config normal_border_color '${t."05"}'
    bspc config focused_border_color '${t."66"}'
    bspc config active_border_color '${t."16"}'
    bspc config presel_feedback_color '${t."66"}'
  '';
  services.sxhkd = {
    enable = true;
    keybindings = mkHotkeyChain {
      "alt + {_,shift + }Tab" = "bspc node -f {next,prev}.leaf.local.!sticky";
      Print = "flameshot gui";
      "shift + Print" = "flameshot full -c";

      # sound
      XF86AudioMute = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      XF86AudioRaiseVolume = "pactl set-sink-volume @DEFAULT_SINK@ +2%";
      XF86AudioLowerVolume = "pactl set-sink-volume @DEFAULT_SINK@ -2%";

      XF86AudioPlay = "playerctl -p spotifyd play-pause";

      # headset/speakers toggle
      "alt + XF86AudioPlay" = "audio_device_toggle";
      "shift + XF86AudioPlay" =
        "spt pb --transfer=Daemon; playerctl -p spotifyd play";
      "shift + XF86AudioMute" = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
      XF86AudioNext = "playerctl -p spotifyd next";
      XF86AudioPrev = "playerctl -p spotifyd previous";

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
        o = "overflow";
        "{q,e}" = "bspc node @parent -F {horizontal,vertical}";
        "{w,a,s,d}" = "bspc node -f {north,west,south,east}.leaf.local.!sticky";
        "{period,comma}" = "bspc node {last.descendant_of,@parent} -f";
        "${desks}" = "bspc desktop -f ${desks}";

        shift = plus {
          f = ''
            {\
              eww close bar; bspc config top_padding 0,\
              bspc config top_padding ${toString top_padding}; eww open bar\
              }'';
          x = "bspc node -k";
          "{q,e}" = "bspc node @parent -R {270,90}";
          # from https://www.reddit.com/r/bspwm/comments/r5stxu/resizing_windows_nicely_in_my_opinion/
          "{w,a,s,d}" = ''
            {\
              bspc node @parent/first  -z top 0 -${step}; \
              bspc node @parent/second -z top    0 -${step}, \
              bspc node @parent/second -z left   -${step} 0; \
              bspc node @parent/first  -z right  -${step} 0, \
              bspc node @parent/second -z top    0 +${step}; \
              bspc node @parent/first  -z top 0 +${step}, \
              bspc node @parent/first  -z right  +${step} 0; \
              bspc node @parent/second -z left   +${step} 0  \
              }'';
          "{1-9}" = "bspc node @parent -r 0.{1-9}";
          t =
            "flameshot gui --raw | tesseract -l spa+eng stdin stdout | xclip -in -selection clipboard; notify-send Tesseract 'Copied to clipboard'";
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
            a = "bspc node -n last.!automatic";
            s = "bspc node -s last.marked";
            d = "bspc node -p cancel; bspc node -g marked=off";
            "${desks}" = "bspc node -d ${desks} -f";
            f = ''
              {\
                eww close bar; bspc config top_padding 0; bspc config window_gap 0,\
                bspc config window_gap ${
                  toString window_gap
                }; bspc config top_padding ${
                  toString top_padding
                }; eww open bar\
                }'';
          };
        };

        space = chord {
          "{_,super + }" = none {
            space = "rofit -show drun";
            q = ''
              rofit -show p -modi "p:rofi-power --choices=shutdown/reboot/logout" -theme power'';
            u = ''
              rofit -show emoji -emoji-format "\{emoji\}" -modi emoji -theme emoji'';
            n = ''
              rofit -show calc -modi calc -no-show-match -no-sort -automatic-save-to-history -theme calc -calc-command "echo -n \'\{result\}\' | xclip -selection clipboard"'';
            f = "firefox";
            e = "emacsclient -c -a ''";
            w = "fehbg random";
            t = "che theme toggle";
            m = "pcmanfm";
          };
        };
      };
    };
  };
  xdg.configFile."qalculate/qalc.cfg".text = ''
    digit_grouping=2
  '';
}
