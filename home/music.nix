{ config, lib, pkgs, secrets, ... }:

{
  home.packages = with pkgs; [ playerctl sptlrx spotifyd ];
  home.sessionVariables.SPOTIFY_COOKIE =
    builtins.readFile secrets.spotify.cookie;
  xdg.configFile."spotifyd/spotifyd.conf".text = ''
    [global]
    username = "${secrets.spotify.username}"
    password = "${secrets.spotify.password}"

    use_mpris = true
    backend = "pulseaudio"
    device_name = "Daemon"
    no_audio_cache = true
    initial_volume = "100"
    volume_normalization = true
    autoplay = true
    device_type = "computer"
  '';
}
