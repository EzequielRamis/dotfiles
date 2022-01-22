{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
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
          (final: prev: {
            doomEmacsRevision = inputs.doom-emacs.rev;
          })
        ];
      };

      nixConfig = with pkgs; import ./nixos/configuration.nix {
        inherit pkgs system hostname username;
        inherit (inputs) nixpkgs-wayland;
      };

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
            home-manager.extraSpecialArgs = {
              inherit pkgs system hostname username;
              inherit (inputs) nixpkgs-wayland;
            };
          }
        ];
      };
    };
}
