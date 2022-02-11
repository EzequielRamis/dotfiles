{ config, pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    userName = "Ezequiel Ramis";
    userEmail = "ezequielramis.hello@gmail.com";
    signing = {
      # Change this 2 lines when it's finally installed
      key = "BF25118B1BFFE56E";
      signByDefault = false;
    };
    extraConfig = {
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      diff.algorithm = "histogram";
    };
  };
}