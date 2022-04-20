{ pkgs, inputs, ... }:

pkgs.stdenv.mkDerivation rec {
  name = "apple-nerd-fonts";
  src = inputs.apple-nerd-fonts;

  installPhase = ''
    mkdir -p $out/share/fonts/apple-nerd
    cp -r ${src}/* $out/share/fonts/apple-nerd
  '';
}
