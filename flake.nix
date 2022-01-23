{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # pin emacs-overlay until emacs 29 is stable
    emacs-overlay.url = "github:nix-community/emacs-overlay/4c0dfcbfdff6beb283bb8889239d604c3e504187";
    doom-emacs = {
      url = "github:hlissner/doom-emacs";
      flake = false;
    };
  };

  outputs = { self, home-manager, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "ezequiel";
      hostname = "ramis";

      pkgs = import nixpkgs {
        config = { allowUnfree = true; };
        localSystem = { inherit system; };
        overlays = with inputs; [
          nixpkgs-wayland.overlay
          emacs-overlay.overlay
          (final: prev: ({
            doomEmacsRevision = inputs.doom-emacs.rev;
          } //
            inputs.nixpkgs-wayland.packages.${system}
          ))
        ];
      };

      userData = {
        inherit pkgs system hostname username;
      }

      nixConfig = with pkgs; import ./nixos/configuration.nix userData;

    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixConfig
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = {
              programs.home-manager.enable = true;
              imports = with (import ./helpers.nix); modulesFrom ./home;
            };
            home-manager.extraSpecialArgs = userData;
          }
        ];
      };
    };
}
