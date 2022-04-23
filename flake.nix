{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-nerd-fonts = {
      flake = false;
      url =
        "https://github.com/EzequielRamis/apple-nerd-fonts/releases/download/1.0/apple-nerd.tar.gz";
    };
    whitesur-firefox = {
      flake = false;
      url = "github:vinceliuice/WhiteSur-gtk-theme";
    };
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

      mkPkgs = o:
        import nixpkgs ({
          config = { allowUnfree = true; };
          localSystem = { inherit system; };
        } // o);

      pkgs = mkPkgs {
        overlays = [
          (final: prev: {
            my = lib.my.mapModulesRec ./pkgs
              (p: prev.callPackage p { inherit inputs; });
            unstable = mkPkgs { };
          })
        ];
      };

      userData = { inherit pkgs system hostname username; };

      nixConfig = with pkgs;
        import ./system/configuration.nix (userData // { inherit lib; });

    in rec {
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
      defaultPackage = nixosConfigurations.${hostname};
    };
}
