{ pkgs, lib, hostname, username, secrets, data, ... }: {
  imports = [ ./hardware-configuration.nix ];

  nix = {
    package = pkgs.nixUnstable;
    # the keep-* options are set due to nix-direnv
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    settings.trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ] ++ secrets.trusted-public-keys;
    settings.substituters =
      [ "https://cache.nixos.org" "https://nix-community.cachix.org" ]
      ++ secrets.substituters;
  };
  nixpkgs.config.allowUnfree = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.gfxmodeEfi = "1920x1080";
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "${hostname}"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "es";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.xserver = {
    enable = true;
    autorun = false;
    resolutions = [{
      x = 1920;
      y = 1080;
    }];
    layout = "es";
    xkbOptions = "caps:super";
    displayManager.startx.enable = true;
    videoDrivers = [ "nvidia" ];
    screenSection = ''
      Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option         "AllowIndirectGLXProtocol" "off"
      Option         "TripleBuffer" "on"
    '';
    gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
  };

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  services.greetd = {
    enable = true;
    settings = let
      startx = "startx -x .xinitrc &> /dev/null";
      user = username;
    in {
      default_session = {
        inherit user;
        command = "${
            lib.makeBinPath [ pkgs.greetd.tuigreet ]
          }/tuigreet --time --cmd '${startx}'";
      };
      initial_session = {
        inherit user;
        command = startx;
      };
    };
  };

  fonts = {
    fonts = with pkgs; [
      fira-code
      twitter-color-emoji
      emacs-all-the-icons-fonts
      my.apple-nerd-fonts
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Twitter Color Emoji" ];
        monospace = [ "LigaSF Mono Nerd Font" "FiraCode" ];
        serif = [
          "New York Small"
          "New York Medium"
          "New York Large"
          "New York Extra Large"
        ];
        sansSerif = [ "SF Pro Text" "SF Pro Display" ];
      };
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # rgb and mouse
  hardware.i2c.enable = true;
  services.ratbagd.enable = true;

  services.gvfs.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "networkmanager" "i2c" "audio" ]; # Enable ‘sudo’ for the user.
    initialPassword = "";
  };

  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    [ neovim curl wget git ] ++ secrets.systemPackages;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # ssd
  services.fstrim.enable = true;

  services.udev = {
    packages = secrets.udevPackages;
    extraRules = builtins.readFile data.openrgb-rules;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "tty";
  };

  # fixes gtk
  programs.dconf.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
