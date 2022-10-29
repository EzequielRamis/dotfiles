{ config, lib, pkgs, my, ... }:
let
  t = my.palette;
  unmapAll = str: ''
    unmap ${str}
    unmap [fullscreen] ${str}
    unmap [presentation] ${str}
    unmap [index] ${str}
  '';
  mapAll = str: ''
    map ${str}
    map [fullscreen] ${str}
    map [presentation] ${str}
    map [index] ${str}
  '';
in {
  programs.zathura = {
    enable = true;
    options = {
      font = "monospace normal 12";
      default-bg = "@bg_color"; # feature
      inputbar-bg = t."00";
      inputbar-fg = t."6A";
      notification-bg = t."00";
      notification-fg = t."0A";
      notification-error-bg = t."00";
      notification-error-fg = t."18";
      notification-warning-bg = t."00";
      notification-warning-fg = t."38";
      statusbar-bg = t."00";
      statusbar-fg = t."0F";
      statusbar-h-padding = 16;
      statusbar-v-padding = 8;
      index-bg = t."00";
      index-fg = t."0F";
      index-active-bg = t."61";
      index-active-fg = t."0F";
      page-padding = 16;
      recolor-darkcolor = t."02";
      recolor-lightcolor = t."0F";
      recolor-reverse-video = true;
      statusbar-basename = true;
      zoom-center = true;
      selection-clipboard = "clipboard";
    };
    extraConfig = ''
      ${unmapAll "q"}
      ${mapAll "x quit"}

      ${unmapAll "<Tab>"}
      ${mapAll "w toggle_index"}
    '';
  };
}
