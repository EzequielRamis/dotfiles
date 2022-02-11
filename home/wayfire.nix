{ pkgs, lib, ... }:
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
  home.packages = with pkgs; [ wayfire wlr-randr ];

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
        simple-tile \
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
    simple-tile = {
      inherit button_move button_resize;
      key_toggle = "<super> KEY_T";
      key_focus_above = ctrl + super-k;
      key_focus_below = ctrl + super-j;
      key_focus_left = ctrl + super-h;
      key_focus_right = ctrl + super-l;
      keep_fullscreen_on_adjacent = true;
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
    vswitch = {
      binding_up = super-k;
      binding_down = super-j;
      binding_left = super-h;
      binding_right = super-l;
      binding_last = "<super> KEY_U";

      send_win_up = shift + super-k;
      send_win_down = shift + super-j;
      send_win_left = shift + super-h;
      send_win_right = shift + super-l;

      with_win_up = ctrl + shift + super-k;
      with_win_down = ctrl + shift + super-j;
      with_win_left = ctrl + shift + super-h;
      with_win_right = ctrl + shift + super-l;
    } // vswitchN 1 // vswitchN 2 // vswitchN 3 // vswitchN 4;
    # Makes Caps Lcok an additional Esc, but with Shift + Caps Lock is the
    # regular Caps Lock. From xkeyboard-config man.
    input.xkb_options = "caps:escape_shifted_capslock";
    wm-actions.toggle_fullscreen = "<super> KEY_F";
  };
}