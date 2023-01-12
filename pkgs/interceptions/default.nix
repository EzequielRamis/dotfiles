{ pkgs, inputs, ... }:

pkgs.stdenv.mkDerivation rec {
  name = "interceptions";
  src = inputs.interception-k2k;
  doCheck = false;
  configurePhase = ''
    mkdir ./default/interceptions
    cat ${./multi-rules.h.in} > ./default/interceptions/multi-rules.h.in
  '';
  makeFlags = [ "OUT_DIR=$(out)" "INSTALL_DIR=$(out)/opt/interception" ];
}
