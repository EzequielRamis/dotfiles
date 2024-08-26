# For now the best way to manage doom emacs is to only use bin/doom and nix the
# least possible
{ config, lib, pkgs, my, ... }:
let emacsDir = "$HOME/.emacs.d";
in {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.pdf-tools
      epkgs.treesit-grammars.with-all-grammars
    ];
  };
  services.emacs = {
    enable = false;
    defaultEditor = true;
    client = {
      enable = true;
      arguments = [ "-c -a ''" ];
    };
  };

  home.sessionVariables.DOOMDIR = "~/.doom.d";
  home.sessionPath = [ "${emacsDir}/bin" ];
  home.packages = with pkgs; [
    fd
    ripgrep
    nixfmt-classic
    cmake
    gnumake
    gcc
    libtool
    libvterm-neovim
    pandoc
    # org
    texlive.combined.scheme-medium
    (python3.withPackages (p: with p; [ grip ]))
    sumneko-lua-language-server
    # nodePackages.pyright
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
