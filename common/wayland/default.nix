{ pkgs, lib, nixpkgs-wayland, username, ... }: 
let user = username; in
{
  nix = {
    # add binary caches
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      # ...
    ];
    binaryCaches = [
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
        # ...
    ];
  };

  # use it as an overlay
  nixpkgs.overlays = [ nixpkgs-wayland.overlay ];

  hardware.opengl.enable = true;

  # pull specific packages (built against inputs.nixpkgs, usually `nixos-unstable`)
  environment.systemPackages = with pkgs; [
      nixpkgs-wayland.packages.${system}.wayfire
      nixpkgs-wayland.packages.${system}.wlr-randr
  ];

  # https://github.com/WayfireWM/wayfire/wiki/FAQ#2-the-mouse-cursor-is-invisible
  environment.variables.WLR_NO_HARDWARE_CURSORS = "1";

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        inherit user;
        command = "${lib.makeBinPath [pkgs.greetd.tuigreet] }/tuigreet --time --cmd wayfire";
      };
      initial_session = {
        inherit user;
        command = "wayfire";
      };
    };
  };
}