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
    # pin emacs-overlay to v28 until it is stable
    emacs-overlay.url =
      "github:nix-community/emacs-overlay/5e7af7d4bda485bb65a353d16a1ca38d9b73b178";
  };

  outputs = { self, home-manager, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "ezequiel";
      hostname = "ramis";

      lib = nixpkgs.lib.extend (final: prev: {
        my = import ./lib {
          inherit pkgs inputs;
          lib = final;
        };
      });

      mkPkgs = ow:
        import nixpkgs ({
          config = { allowUnfree = true; };
          localSystem = { inherit system; };
        } // ow);

      pkgs = mkPkgs {
        overlays = with inputs; [
          nixpkgs-wayland.overlay
          emacs-overlay.overlay
          (final: prev:
            inputs.nixpkgs-wayland.packages.${system} // {
              my = lib.my.mapModulesRec ./pkgs (p: prev.callPackage p { });
              unstable = mkPkgs { };
            })
        ];
      };

      userData = { inherit pkgs system hostname username; };

      nixConfig = with pkgs;
        import ./nixos/configuration.nix (userData // { inherit lib; });

    in {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixConfig
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = {
              programs.home-manager.enable = true;
              xdg.enable = true;
              imports = lib.my.importFrom ./home;
            };
            home-manager.extraSpecialArgs = userData;
          }
        ];
      };
    };
}
