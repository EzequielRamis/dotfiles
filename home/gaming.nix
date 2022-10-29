{ config, lib, pkgs, ... }:

{
  programs.mangohud.enable = true;
  programs.mangohud.enableSessionWide = true;
  home.packages = with pkgs; [
    steam
    (discord.override { nss = nss_latest; })
    jstest-gtk
    linuxConsoleTools
    bottles
  ];
  home.sessionVariables = {
    VK_ICD_FILENAMES =
      "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/nvidia_icd.i686.json";
  };
}
