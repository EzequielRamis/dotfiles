{ config, pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    userName = "Ezequiel Ramis";
    userEmail = "ezequiel@ramis.ar";
    signing = {
      key = "5B1D02EC58BED67B";
      signByDefault = false;
    };
    includes = [{
      condition = "gitdir:~/Desktop/Orga2/";
      path = "~/Desktop/Orga2/.gitconfig";
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
  services.gpg-agent.enable = true;
}
