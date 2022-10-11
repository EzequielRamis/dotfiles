{ lib, pkgs, bottlesExtraLibraries ? pkgs:
  [ ] # extra packages to add to steam.run multiPkgs
, bottlesExtraPkgs ? pkgs: [ ] # extra packages to add to steam.run targetPkgs
, ... }:

let
  steam-run = (pkgs.steam.override {
    # required by wine runner `caffe`
    extraLibraries = pkgs:
      with pkgs;
      [ libunwind libusb1 gnutls pkgsi686Linux.gnutls ]
      ++ bottlesExtraLibraries pkgs;
    extraPkgs = pkgs: [ ] ++ bottlesExtraPkgs pkgs;
  }).run;
in pkgs.python3Packages.buildPythonApplication rec {
  pname = "bottles";
  version = "2022.9.28";

  src = pkgs.fetchFromGitHub {
    owner = "bottlesdevs";
    repo = pname;
    rev = version;
    sha256 = "sha256-gGGS+a7C6AzH6eq1VTaYYGFeJWaVxQpbnX7xNNEN15o=";
  };

  postPatch = ''
    chmod +x build-aux/meson/postinstall.py
    patchShebangs build-aux/meson/postinstall.py

    substituteInPlace bottles/backend/wine/winecommand.py \
      --replace \
        'self.__get_runner()' \
        '(lambda r: (f"${steam-run}/bin/steam-run {r}", r)[r == "wine" or r == "wine64"])(self.__get_runner())'
  '';

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
    wrapGAppsHook
    gettext
    appstream-glib
    desktop-file-utils
  ];

  buildInputs = with pkgs; [
    gdk-pixbuf
    glib
    gobject-introspection
    gsettings-desktop-schemas
    gspell
    gtk4
    gtksourceview4
    libhandy
    libnotify
    webkitgtk
    gnome.adwaita-icon-theme
  ];

  propagatedBuildInputs = with pkgs.python3Packages;
    [
      pyyaml
      pytoml
      requests
      pycairo
      pygobject3
      lxml
      dbus-python
      gst-python
      liblarch
      patool
      markdown
      (buildPythonPackage rec {
        pname = "icoextract";
        version = "0.1.4";
        src = fetchPypi {
          inherit pname version;
          sha256 = "sha256-x0GEV0PUbkAzoUJgAqup9bHd7iYttGyzIZNdo8KsFyo=";
        };
        propagatedBuildInputs = [ pefile pillow setuptools ];
        doCheck = false;
      })
      (buildPythonPackage rec {
        pname = "FVS";
        version = "0.3.4";
        src = fetchPypi {
          inherit pname version;
          sha256 = "sha256-yYd0HzdwbqB9kexJjBRRYmdsoWtZtcjCNRz0ZJVM5CI=";
        };
        propagatedBuildInputs = [ orjson ];
        doCheck = false;
      })
    ] ++ (with pkgs; [
      steam-run
      xdg-utils
      pciutils
      cabextract
      wineWowPackages.stableFull
      freetype
      p7zip
      gamemode # programs.gamemode.enable
      mangohud
      libadwaita
      gtksourceview5
      xorg.xdpyinfo
      openldap
      pkgsi686Linux.openldap
      blueprint-compiler
    ]);

  format = "other";
  strictDeps =
    false; # broken with gobject-introspection setup hook, see https://github.com/NixOS/nixpkgs/issues/56943
  dontWrapGApps = true; # prevent double wrapping

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  passthru.updateScript = pkgs.gitUpdater { inherit pname version; };

  meta = with lib; {
    description = "An easy-to-use wineprefix manager";
    homepage = "https://usebottles.com/";
    downloadPage = "https://github.com/bottlesdevs/Bottles/releases";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ psydvl shamilton ];
    platforms = platforms.linux;
  };
}
