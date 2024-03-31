{ config, lib, pkgs, ... }:

{
  programs.mangohud.enable = true;
  programs.mangohud.enableSessionWide = false;
  home.packages = with pkgs; [
    wineWowPackages.stable
    winetricks
    # (steam.override { extraPkgs = (pkgs: with pkgs; [ gamemode ]); })
    (discord.override { nss = nss_latest; })
    jstest-gtk
    linuxConsoleTools
    bottles
    (lutris.override { extraLibraries = pkgs: [ pkgs.jansson ]; })
    prismlauncher
    # rpcs3
  ];
  home.sessionVariables = {
    VK_ICD_FILENAMES =
      "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/nvidia_icd.i686.json";
  };
}
