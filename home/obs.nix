{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.obs-studio = {
    enable = false;
    package = (pkgs.obs-studio.override { cudaSupport = true; });
    plugins = with pkgs.obs-studio-plugins; [ obs-advanced-masks ];
  };
}
