# For now the best way to manage doom emacs is to only use bin/doom and nix the
# least possible
{ config, lib, pkgs, my, ... }:
let emacsDir = "$HOME/.emacs.d";
in {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm epkgs.pdf-tools ];
  };
  services.emacs = {
    enable = false;
    defaultEditor = true;
  };

  home.sessionVariables.DOOMDIR = "~/.doom.d";
  home.sessionPath = [ "${emacsDir}/bin" ];
  home.packages = with pkgs; [
    fd
    ripgrep
    nixfmt
    cmake
    gnumake
    gcc
    libtool
    libvterm-neovim
    pandoc
    # org
    texlive.combined.scheme-medium
    (python39.withPackages (ps: with ps; [ grip ]))
    nodejs
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier
    nodePackages.typescript-language-server
    sumneko-lua-language-server
  ];

  home.activation.doom-clone = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d ${emacsDir} ]; then
      git clone https://github.com/hlissner/doom-emacs.git ${emacsDir}
    fi
  '';

  xdg.dataFile."dotfiles/mypalette.el".text = ''
    ${lib.strings.concatStrings (lib.attrsets.mapAttrsToList (name: value: ''
      (defconst palette${name} "${value}")
    '') my.palette)}

    (provide 'mypalette)
  '';
}
