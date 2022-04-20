{ pkgs, inputs, ... }:

pkgs.stdenv.mkDerivation rec {
  name = "whitesur-firefox";
  src = inputs.whitesur-firefox;

  installPhase = ''
    mkdir -p $out
    cp -r ${src}/src/other/firefox/Monterey/* $out
  '';
}
