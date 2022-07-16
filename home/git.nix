{ config, pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    userName = "Ezequiel Ramis";
    userEmail = "ezequielramis.hello@gmail.com";
    signing = {
      key = "5B1D02EC58BED67B";
      signByDefault = false;
    };
    includes = [{
      condition = "gitdir:~/Desktop/glamit/";
      path = "~/Desktop/glamit/.gitconfig";
    }];
    extraConfig = {
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      diff.algorithm = "histogram";
    };
    delta.enable = true;
  };
}
