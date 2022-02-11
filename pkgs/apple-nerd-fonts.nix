{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  name = "apple-nerd-fonts";
  version = "1.0";

  src = builtins.fetchTarball {
    url = "https://github.com/EzequielRamis/${name}/releases/download/${version}/apple-nerd.tar.gz";
    sha256 = "0ra0rv5cfw6gcdqam370g69afybbagqfyg03lf1l05m2bs3cpr29";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/apple-nerd
    cp -r ${src}/* $out/share/fonts/apple-nerd
  '';
}
