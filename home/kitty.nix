{ config, pkgs, lib, my, ... }:
let t = my.palette;
in {
  programs.kitty = {
    enable = true;
    font.name = "mono";
    font.size = 16;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      allow_remote_control = true;
      window_padding_width = "0 16";
      background_opacity = "0.9";
      include = "mytheme.conf";
      cursor_text_color = "background";
    };
  };
  xdg.configFile."kitty/themes/mydark.conf".text = ''
    # mydark theme

    background ${t."0F"}
    foreground ${t."00"}
    cursor ${t."02"}

    # black
    color0 ${t."0F"}
    color8 ${t."08"}

    # red
    color1 ${t."16"}
    color9 ${t."15"}

    # green
    color2 ${t."45"}
    color10 ${t."43"}

    # yellow
    color3 ${t."33"}
    color11 ${t."32"}

    # blue
    color4 ${t."66"}
    color12 ${t."64"}

    # magenta
    color5 ${t."76"}
    color13 ${t."75"}

    # cyan
    color6 ${t."55"}
    color14 ${t."53"}

    # white
    color7 ${t."03"}
    color15 ${t."00"}
  '';
  xdg.configFile."kitty/themes/mylight.conf".text = ''
    # mylight theme

    background ${t."00"}
    foreground ${t."0F"}
    cursor ${t."08"}

    # black
    color0 ${t."0F"}
    color8 ${t."08"}

    # red
    color1 ${t."18"}
    color9 ${t."17"}

    # green
    color2 ${t."47"}
    color10 ${t."45"}

    # yellow
    color3 ${t."35"}
    color11 ${t."34"}

    # blue
    color4 ${t."68"}
    color12 ${t."66"}

    # magenta
    color5 ${t."78"}
    color13 ${t."77"}

    # cyan
    color6 ${t."57"}
    color14 ${t."55"}

    # white
    color7 ${t."03"}
    color15 ${t."00"}
  '';
}
