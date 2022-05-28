{ pkgs, inputs, lib, ... }:

pkgs.stdenv.mkDerivation rec {
  name = "whitesur-firefox";
  src = inputs.whitesur;

  installPhase = ''
    mkdir -p $out
    cp -r ${src}/src/other/firefox/Monterey/* $out
  '';

  meta = with lib; {
    description = "MacOS Safari like theme for Firefox";
    homepage = "https://github.com/vinceliuice/WhiteSur-gtk-theme";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
