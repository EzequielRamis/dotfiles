{ config, lib, pkgs, ... }:

let
  reconnectScript = pkgs.writeShellScript "bluetooth-reconnect.sh" ''
    set -euo pipefail
    PATH=/run/current-system/sw/bin:
    bluetoothctl info A4:05:6E:6D:B5:9A | grep -q 'Connected: no' && bluetoothctl --timeout 180 connect A4:05:6E:6D:B5:9A
  '';
in {
  systemd.user.timers."bluetooth-reconnect" = {
    Unit = { Description = "Reconnect to bluetooth headset"; };
    Timer = {
      OnUnitActiveSec = "181";
      OnStartupSec = "10";
      Unit = "bluetooth-reconnect.service";
    };
    Install = { WantedBy = [ "timers.target" "bluetooth.target" ]; };
  };
  systemd.user.services."bluetooth-reconnect" = {
    Unit = { Description = "Reconnect to bluetooth headset"; };
    Service = {
      Type = "simple";
      ExecStart = reconnectScript;
    };
  };
}
