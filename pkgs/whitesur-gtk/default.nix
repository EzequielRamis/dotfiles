{ pkgs, lib, inputs, ... }:

pkgs.stdenv.mkDerivation rec {
  name = "whitesur-gtk";
  src = inputs.whitesur;

  nativeBuildInputs = with pkgs; [
    glib
    gnome.gnome-shell
    libxml2
    sassc
    util-linux
  ];

  buildInputs = [
    pkgs.gnome-themes-extra # adwaita engine for Gtk2
  ];

  postPatch = ''
    find -name "*.sh" -print0 | while IFS= read -r -d ''' file; do
      patchShebangs "$file"
    done

    # Do not provide `sudo`, as it is not needed in our use case of the install script
    substituteInPlace lib-core.sh --replace '$(which sudo)' false

    # Provides a dummy home directory
    substituteInPlace lib-core.sh --replace 'MY_HOME=$(getent passwd "''${MY_USERNAME}" | cut -d: -f6)' 'MY_HOME=/tmp'
  '';

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    ./install.sh --dest $out/share/themes --alt all --theme all
    runHook postInstall
  '';

  meta = with lib; {
    description = "MacOS Big Sur like theme for Gnome desktops";
    homepage = "https://github.com/vinceliuice/WhiteSur-gtk-theme";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
