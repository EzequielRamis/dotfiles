{ pkgs, lib, hostname, username, secrets, ... }: {
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
      "cm-idris2-pkgs.cachix.org-1:YB2oJSEsD5oMJjAESxolC2GQtE6B5I6jkWhte2gtXjk="
    ];
    settings.substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://cm-idris2-pkgs.cachix.org"
    ];
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
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "es_AR.UTF-8/UTF-8" ];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "es";
  };

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # rgb and mouse
  hardware.i2c.enable = true;

  hardware.xpadneo.enable = true;

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
    printing.drivers = [ pkgs.hplipWithPlugin ];

    xserver = {
      enable = true;
      exportConfiguration = true;
      resolutions = [{
        x = 1920;
        y = 1080;
      }];
      videoDrivers = [ "nvidia" ];
      screenSection = ''
        Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
        Option         "AllowIndirectGLXProtocol" "off"
        Option         "TripleBuffer" "on"
      '';
      gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
      displayManager = {
        lightdm.enable = true;
        autoLogin.enable = true;
        autoLogin.user = username;
        defaultSession = "none+fake";
        session = [{
          name = "fake";
          manage = "window";
          start = "";
        }];
      };
    };

    ratbagd.enable = true;

    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # ssd
    fstrim.enable = true;

    gnome.at-spi2-core.enable = true;
    gnome.gnome-keyring.enable = true;

    # gaming
    samba = {
      enable = true;
      enableWinbindd = true;
    };

    interception-tools = {
      enable = true;
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g ${secrets.keyboard} | ${pkgs.my.interceptions}/opt/interception/interceptions | ${pkgs.interception-tools}/bin/uinput -d ${secrets.keyboard}"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK]
      '';
    };
  } // secrets.services;

  fonts = {
    fonts = with pkgs; [
      fira-code
      twitter-color-emoji
      emacs-all-the-icons-fonts
      my.apple-nerd-fonts
      cm_unicode
      bakoma_ttf
      lmmath
      lmodern
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "i2c"
      "audio"
      "scanner"
    ]; # Enable ‘sudo’ for the user.
    initialPassword = "";
  };

  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ neovim curl wget git ];

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "tty";
  };

  # fixes gtk
  programs.dconf.enable = true;

  programs.gamemode.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
