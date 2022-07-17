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
      no_audio_cache = true;
      initial_volume = "100";
      volume_normalization = true;
      autoplay = false;
      device_type = "computer";
    };
  };
  home.sessionVariables.SPOTIFY_COOKIE =
    builtins.readFile secrets.spotify.cookie;
  home.packages = with pkgs; [ sptlrx spotify-tui ];
}
