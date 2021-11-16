{ pkgs, nixpkgs-wayland, ... }: {
  # config = {
  #   nix = {
  #     # add binary caches
  #     binaryCachePublicKeys = [
  #       "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  #       "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
  #       # ...
  #     ];
  #     binaryCaches = [
  #       "https://cache.nixos.org"
  #       "https://nixpkgs-wayland.cachix.org"
  #         # ...
  #     ];
  #   };

  #   # use it as an overlay
  #   nixpkgs.overlays = [ nixpkgs-wayland.overlay ];

  #   # Enable the X11 windowing system.
  #   # services.xserver.enable = true;

  #   # Enable the Plasma 5 Desktop Environment.
  #   # services.xserver.displayManager.gdm.enable = true;
  #   # services.xserver.desktopManager.gnome.enable = true;
  #   # services.xserver.displayManager.defaultSession = "none+i3";
  #   # services.xserver.displayManager.sddm.enable = true;
  #   # services.xserver.desktopManager.plasma5.enable = true;

  #   # Configure keymap in X11
  #   # services.xserver.layout = "es";
  #   # services.xserver.xkbOptions = "eurosign:e";

  #   # pull specific packages (built against inputs.nixpkgs, usually `nixos-unstable`)
  #   environment.systemPackages = with pkgs; [
  #     nixpkgs-wayland.packages.${system}.wayfire
  #   ];
  # };
  programs.sway.enable = true;
}