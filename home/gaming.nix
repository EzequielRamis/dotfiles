{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.mangohud.enable = true;
  programs.mangohud.enableSessionWide = false;
  home.packages = with pkgs; [
    gamescope
    wineWow64Packages.stable
    winetricks
    # (steam.override { extraPkgs = (pkgs: with pkgs; [ gamemode ]); })
    (discord.override { nss = nss_latest; })
    jstest-gtk
    linuxConsoleTools
    prismlauncher
    # rpcs3
  ];
  home.sessionVariables = {
    # https://github.com/ValveSoftware/steam-for-linux/issues/10827
    STEAM_DISABLE_BROWSER_SHUTDOWN_WORKAROUND = 1;
    SDL_GAMECONTROLLERCONFIG = "030000005e040000dd02000003020000,Microsoft Xbox One,a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:Linux,";
    SDL_JOYSTICK_DEVICE = "/dev/input/by-id/usb-Microsoft_Controller_7EED8D604973-joystick";
    SDL_VIDEODRIVER = "wayland";
    PROTON_ENABLE_WAYLAND = 1;
    PROTON_ENABLE_HDR = 1;
    ENABLE_HDR_WSI = 1;
    DXVK_HDR = 1;
  };
}
