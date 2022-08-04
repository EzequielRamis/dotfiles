{ config, lib, pkgs, my, ... }:

{
  home.packages = with pkgs; [ libnotify ];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 320;
        height = 80;
        origin = "top-right";
        offset = "16x40";
        notification_limit = 0;
        transparency = 0;
        separator_height = 1;
        frame_width = 1;
        frame_color = my.palette."05";
        padding = 16;
        horizontal_padding = 16;
        text_icon_padding = 16;
        font = "Sans 10";
        corner_radius = 8;
        mouse_right_click = "close_current";
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_all";
        min_icon_size = 48;
        max_icon_size = 48;
        gap_size = 8;
      };
      urgency_low = {
        background = my.palette."00";
        foreground = my.palette."0F";
        timeout = 10;
      };
      urgency_normal = {
        background = my.palette."00";
        foreground = my.palette."0F";
        timeout = 10;
      };
      urgency_critical = {
        background = my.palette."00";
        foreground = my.palette."0F";
        timeout = 0;
      };
    };
  };
}
