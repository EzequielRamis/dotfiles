{ config, lib, pkgs, secrets, my, ... }:

{
  services.playerctld.enable = true;
  services.spotifyd = {
    enable = true;
    settings.global = {
      inherit (secrets.spotify) username password;
      use_mpris = true;
      backend = "pulseaudio";
      device_name = "Daemon";
      no_audio_cache = false;
      cache_path = ".cache/spotifyd";
      max_cache_size = 1000000000;
      initial_volume = "75";
      volume_normalization = true;
      autoplay = false;
      device_type = "computer";
      on_song_change_hook = "~/.dotfiles/bin/spotify_metadata";
    };
  };
  home.sessionVariables.SPOTIFY_COOKIE =
    builtins.readFile secrets.spotify.cookie;
  home.packages = with pkgs; [ playerctl sptlrx spotify-tui ];
  xdg.configFile."cava/config".text = let t = my.palette;
  in ''
    [general]

    # Accepts only non-negative values.
    framerate = 60

    # 'autosens' will attempt to decrease sensitivity if the bars peak. 1 = on, 0 = off
    # new as of 0.6.0 autosens of low values (dynamic range)
    autosens = 0

    # Manual sensitivity in %. If autosens is enabled, this will only be the initial value.
    # 200 means double height. Accepts only non-negative values.
    sensitivity = 12

    # The number of bars (0-200). 0 sets it to auto (fill up console).
    # Bars' width and space between bars in number of characters.
    bars = 0
    bar_width = 4
    bar_spacing = 1
    # bar_height is only used for output in "noritake" format
    ; bar_height = 32

    [output]

    # Ouput method. Can be 'ncurses', 'noncurses' or 'raw'.
    # 'noncurses' is for systems that does not suport ncurses.
    # 'raw' is a 16 bit data stream of the bar heights that can be used to send to other applications.
    # 'raw' defaults to 200 bars, which can be adjusted in the 'bars' option above.
    method = ncurses

    [color]

    # Colors can be one of seven predefined: black, blue, cyan, green, magenta, red, white, yellow.
    # Or defined by hex code '#xxxxxx' (hex code must be within). User defined colors requires
    # ncurses output method and a terminal that can change color definitions such as Gnome-terminal or rxvt.
    # if supported, ncurses mode will be forced on if user defined colors are used.
    # default is to keep current terminal color
    ; background = default
    ; foreground = default

    # Gradient mode, only hex defined colors (and thereby ncurses mode) are supported,
    # background must also be defined in hex  or remain commented out. 1 = on, 0 = off.
    # You can define as many as 8 different colors. They range from bottom to top of screen
    gradient = 1
    gradient_count = 7
    gradient_color_1 = '${t."73"}'
    gradient_color_2 = '${t."63"}'
    gradient_color_3 = '${t."53"}'
    gradient_color_4 = '${t."43"}'
    gradient_color_5 = '${t."33"}'
    gradient_color_6 = '${t."23"}'
    gradient_color_7 = '${t."13"}'

    [smoothing]

    # Percentage value for integral smoothing. Takes values from 0 - 100.
    # Higher values means smoother, but less precise. 0 to disable.
    # DEPRECATED as of 0.8.0, use noise_reduction instead
    ; integral = 77

    # Disables or enables the so-called "Monstercat smoothing" with or without "waves". Set to 0 to disable.
    monstercat = 1
    waves = 1
  '';
}
