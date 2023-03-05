{ config, pkgs, lib, username, inputs, ... }: {
  programs.firefox = {
    enable = true;
    # WIP
    # package = pkgs.wrapFirefox (pkgs.runCommand "firefox-patched" {
    #   inherit (pkgs) gtk3;
    #   meta.description = "";
    # } ''
    #   mkdir $out
    #   cp -r ${pkgs.firefox} $out
    # '') { };
    profiles."${username}" = {
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "layout.css.color-mix.enabled" = true;
        "gfx.x11-egl.force-enabled" = true;
        "webgl.force-enabled" = true;
        "webgl.msaa-force" = true;
        "extensions.pocket.enabled" = false;
        "layout.frame_rate" = 60;
        "layout.frame_rate.precise" = true;
        "general.smoothScroll.msdPhysics.enabled" = true;
        "image.mem.min_discard_timeout_ms" = 2100000000;
        "image.mem.max_decoded_image_kb" = 512000;
        "general.smoothScroll.currentVelocityWeighting" = 0;
        "general.smoothScroll.mouseWheel.durationMaxMS" = 250;
        "general.smoothScroll.stopDecelerationWeighting" = "0.82";
        "mousewheel.min_line_scroll_amount" = 15;
        "browser.cache.disk.enable" = false;
        "browser.cache.disk.smart_size.enabled" = false;
        "browser.cache.disk_cache_ssl" = false;
        "browser.cache.offline.enable" = false;
        "browser.cache.memory.enable" = true;
        "browser.cache.memory.capacity" = 512000;
        "layout.css.has-selector.enabled" = true;
      };
      userChrome = builtins.readFile ./userChrome.css;
      userContent = builtins.readFile ./userContent.css;
    };
  };

  # WIP
  home.activation.firefox-scripts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    cd $HOME/.mozilla/firefox/${username}/chrome
    if [ ! -d ./firefox-scripts ]; then
      git clone https://github.com/xiaoxiaoflood/firefox-scripts.git
    else
      pushd ./firefox-scripts
      git pull
      popd
    fi
    unzip -o firefox-scripts/utils.zip
    cd firefox-scripts/chrome
    cp enterSelects.uc.js rebuild_userChrome.uc.js ../..
  '';
}
