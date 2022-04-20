{ config, pkgs, lib, username, ... }: {
  programs.firefox = {
    enable = true;
    profiles."${username}" = {
      isDefault = true;
    };
  };
}
