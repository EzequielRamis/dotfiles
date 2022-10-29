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
    gobject-introspection
  ];

  propagatedBuildInputs = with pkgs;
    with python3Packages; [
      # nix rant
      libadwaita
      gtksourceview5
      #others
      gdk-pixbuf
      gspell
      libhandy
      libnotify
      webkitgtk
      gnome.adwaita-icon-theme
      lxml
      dbus-python
      gst-python
      liblarch
      pciutils
      mangohud
      openldap
      pkgsi686Linux.openldap

      # https://github.com/bottlesdevs/Bottles/blob/main/com.usebottles.bottles.dev.yml python modules
      pillow
      pyyaml
      urllib3
      chardet
      certifi
      idna
      pefile
      # https://github.com/bottlesdevs/Bottles/blob/main/com.usebottles.bottles.dev.yml tools
      vmtouch
      vulkan-tools
      xorg.xdpyinfo
      # https://github.com/bottlesdevs/Bottles/blob/main/com.usebottles.bottles.dev.yml libraries
      rpcsvc-proto
      perl534Packages.ParseYapp
      imagemagick
      blueprint-compiler
      # https://github.com/bottlesdevs/Bottles/blob/main/com.usebottles.bottles.dev.yml bottles components
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
      # https://github.com/bottlesdevs/Bottles/blob/main/snapcraft.yaml build-packages
      gettext
      glib
      appstream-glib
      desktop-file-utils
      gsettings-desktop-schemas
      pytoml
      requests
      gtk4
      # https://github.com/bottlesdevs/Bottles/blob/main/snapcraft.yaml stage-packages
      pygobject3
      pycairo
      markdown
      gamemode
      gamemode # programs.gamemode.enable
      freetype
      cabextract
      wineWowPackages.stableFull
      p7zip
      patool
    ];
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
