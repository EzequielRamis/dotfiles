{ config, lib, pkgs, ... }:

{
  xdg.configFile."pulse/daemon.conf".text = ''
    flat-volumes = no
  '';
}
