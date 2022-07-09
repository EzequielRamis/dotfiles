{ config, pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;
    font.name = "mono";
    font.size = 16;
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.75";
      window_padding_width = "0 16";
    };
  };
}
