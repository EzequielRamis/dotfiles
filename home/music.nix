{ config, lib, pkgs, secrets, ... }:

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
      initial_volume = "100";
      volume_normalization = true;
      autoplay = false;
      device_type = "computer";
    };
  };
  home.sessionVariables.SPOTIFY_COOKIE =
    builtins.readFile secrets.spotify.cookie;
  home.packages = with pkgs; [ playerctl sptlrx spotify-tui ];
}
