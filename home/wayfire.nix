{ config, pkgs, lib, ... }:
let
  super = "<super> ";
  alt = "<alt> ";
  ctrl = "<ctrl> ";
  shift = "<shift> ";
  super-k = super + "KEY_K ";
  super-j = super + "KEY_J ";
  super-h = super + "KEY_H ";
  super-l = super + "KEY_L ";
  vswitchN = n:
    let
      s = builtins.toString n;
      key = "KEY_${s}";
    in {
      "binding_${s}" = super + key;
      "send_win_${s}" = shift + super + key;
      "with_win_${s}" = ctrl + shift + super + key;
    };
  button_move = ctrl + super + "BTN_LEFT";
  button_resize = ctrl + super + "BTN_RIGHT";
in {
  home.packages = with pkgs; [
    wlr-randr
    wayfire
    my.wayfire-plugins.swayfire
  ];

  xdg.configFile."wayfire.ini".text = lib.generators.toINI { } {
    input.xkb_layout = "es";
    # Change the output when it's ready
    # "output:eDP-1" = {
    "output:Virtual-1" = {
      # mode = "1920x1080@60";
      mode = "1680x1050@60";
      position = 0.0;
      transform = "normal";
      scale = 1.0;
    };
    core = {
      plugins = ''
        swayfire \
        command \
        fast-switcher \
        expo \
        vswitch \
        move \
        resize \
        input \
        wm-actions
      '';
      close_top_view = "<super> KEY_D | <alt> KEY_F4";
      vwidth = 2;
      vheight = 2;
      preferred_decoration_mode = "server";
    };
    move.activate = button_move;
    resize.activate = button_resize;
    swayfire = {
      toggle_tile = "<super> KEY_T";
      toggle_focus_tile = "<super> <shift> KEY_T";
    };
    command = {
      binding_terminal = "<super> KEY_Z";
      command_terminal = "foot";

      binding_launcher = "<super> KEY_SPACE";
      command_launcher = "rofi -show run";
    };
    fast-switcher.activate = "<alt> KEY_TAB";
    expo = {
      toggle = super;
      select_workspace_1 = "KEY_1";
      select_workspace_2 = "KEY_2";
      select_workspace_3 = "KEY_3";
      select_workspace_4 = "KEY_4";
    };
    vswitch =  vswitchN 1 // vswitchN 2 // vswitchN 3 // vswitchN 4;
    # Makes Caps Lcok an additional Esc, but with Shift + Caps Lock is the
    # regular Caps Lock. From xkeyboard-config man.
    input.xkb_options = "caps:escape_shifted_capslock";
    wm-actions.toggle_fullscreen = "<super> KEY_F";
  };
}
