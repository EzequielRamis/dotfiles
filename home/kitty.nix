{ config, pkgs, lib, my, ... }: {
  programs.kitty = {
    enable = true;
    font.name = "mono";
    font.size = 16;
    settings = let t = my.palette;
    in {
      confirm_os_window_close = 0;
      window_padding_width = "0 16";
      enable_audio_bell = false;

      foreground = t."00";
      background = t."0F";
      background_opacity = "0.9";

      # black
      color0 = t."0F";
      color8 = t."0A";

      # red
      color1 = t."16";
      color9 = t."15";

      # green
      color2 = t."46";
      color10 = t."44";

      # yellow
      color3 = t."34";
      color11 = t."32";

      # blue
      color4 = t."66";
      color12 = t."64";

      # magenta
      color5 = t."76";
      color13 = t."75";

      # cyan
      color6 = t."56";
      color14 = t."54";

      # white
      color7 = t."04";
      color15 = t."00";
    };
  };
}
