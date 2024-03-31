{ pkgs, lib, username, ... }: {
  home.sessionVariables = {
    TERMINAL = "kitty";
    BROWSER = "firefox";
    # https://github.com/NixOS/nixpkgs/issues/194929
    NIX_CC = "/dev/null";
    SDL_GAMECONTROLLERCONFIG =
      "030000005e040000dd02000003020000,Microsoft Xbox One,a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:Linux,";
    SDL_JOYSTICK_DEVICE =
      "/dev/input/by-id/usb-Microsoft_Controller_7EED8D604973-joystick";
    NIXPKGS_ALLOW_UNFREE = 1;
    LD_LIBRARY_PATH =
      "${lib.makeLibraryPath (with pkgs; [ openssl_1_1 ])}:$LD_LIBRARY_PATH";
  };
  # xdg.desktopEntries.Lutris = {
  #   type = "Application";
  #   name = "Lutris";
  #   exec = "WEBKIT_DISABLE_COMPOSITING_MODE=1 lutris";
  #   genericName = "Game launcher";
  # };
}
