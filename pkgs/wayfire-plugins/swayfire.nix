{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  name = "swayfire";

  src = pkgs.fetchFromGitHub {
    owner = "Javyre";
    repo = name;
    rev = "master";
    sha256 = "1r05d2sqclq5kj0qkscp8q249kdwjjksi44vrl70gh23qf06b0yf";
  };

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
    wayland
    cairo
    glm
    libinput
    libxkbcommon
    pango
  ];
  buildInputs = [ pkgs.wayfire ];

  mesonBuildType = "release";
}
