{ config, pkgs, lib, username, ... }: {
  programs.firefox = {
    enable = true;
    profiles."${username}" = {
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "layout.css.color-mix.enabled" = true;
        "gfx.webrender.all" = true;
      };
      userChrome = builtins.readFile ./userChrome.css;
    };
  };
}
