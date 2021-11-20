{ ... }:
{
  services.virtualbox.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  videoDrivers = [ "virtualbox" ];
  boot.initrd.checkJournalingFS = false;  
  fileSystems = [
    { mountPoint = "/";
      label = "nixos";
    }
  ];
}
