{ lib, inputs, pkgs, withALSA ? true, withPulseAudio ? false
, withPortAudio ? false, withMpris ? false, withKeyring ? false, ... }:

pkgs.rustPackages.rustPlatform.buildRustPackage rec {
  pname = "spotifyd";
  version = "0.3.3";

  src = inputs.spotifyd;

  nativeBuildInputs = [ pkgs.pkg-config ];

  cargoSha256 = "sha256-fSXvEtB1P6zuzF5x/WkKcfKmWepPoGc72VzIF7DQCe4=";

  buildInputs = [ pkgs.openssl ] ++ lib.optional withALSA pkgs.alsa-lib
    ++ lib.optional withPulseAudio pkgs.libpulseaudio
    ++ lib.optional withPortAudio pkgs.portaudio
    ++ lib.optional (withMpris || withKeyring) pkgs.dbus;

  buildNoDefaultFeatures = true;
  buildFeatures = lib.optional withALSA "alsa_backend"
    ++ lib.optional withPulseAudio "pulseaudio_backend"
    ++ lib.optional withPortAudio "portaudio_backend"
    ++ lib.optional withMpris "dbus_mpris"
    ++ lib.optional withKeyring "dbus_keyring";

  doCheck = false;

  meta = with lib; {
    description = "An open source Spotify client running as a UNIX daemon";
    homepage = "https://github.com/Spotifyd/spotifyd";
    changelog =
      "https://github.com/Spotifyd/spotifyd/raw/v${version}/CHANGELOG.md";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ anderslundstedt Br1ght0ne marsam ];
    platforms = platforms.unix;
  };
}
