{ config, lib, pkgs, ... }: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [ droidcam-obs ];
  };
}
