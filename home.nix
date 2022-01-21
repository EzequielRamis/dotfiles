{ pkgs, home-manager, username, ... }:
with (import ./helpers.nix);
{
  home-manager.nixosModules.home-manager.home-manager {
    useGlobalPkgs = false;
    useUserPackages = true;
    users.${username} = {
      nixpkgs = pkgs;
      programs.home-manager.enable = true;
      imports = modulesFrom ./home;
    };
  };
}
