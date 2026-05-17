{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ pinentry-tty ];
  programs.git = {
    enable = true;
    lfs.enable = true;
    signing = {
      key = "5B1D02EC58BED67B";
      signByDefault = false;
    };
    includes = [{
      condition = "gitdir:~/Desktop/Orga2/";
      path = "~/Desktop/Orga2/.gitconfig";
    }];
    settings = {
      user.name = "Ezequiel Ramis";
      user.email = "ezequiel@ramis.ar";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      diff.algorithm = "histogram";
    };
  };
  programs.delta.enable = true;
  programs.delta.enableGitIntegration = true;
  services.gpg-agent.enable = true;
  services.gpg-agent.extraConfig = ''
    allow-emacs-pinentry
  '';
}
