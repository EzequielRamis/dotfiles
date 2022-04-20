{ pkgs, inputs, ... }:

pkgs.stdenv.mkDerivation rec {
  name = "apple-nerd-fonts";
  src = inputs.apple-nerd-fonts;

  buildInputs = [ pkgs.rsync ];

  installPhase = ''
    mkdir -p $out/share/fonts/apple-nerd
    rsync -a --exclude='NY/*Black*' --exclude='NY/*Heavy*' ${src}/ $out/share/fonts/apple-nerd
  '';
}
