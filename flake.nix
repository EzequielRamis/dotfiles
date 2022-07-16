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
    whitesur = {
      flake = false;
      # 2022-02-21 release
      url =
        "github:vinceliuice/WhiteSur-gtk-theme/3dca2b10d0a24bd111119c3eb94df512d7e067f5";
    };
    # my fork
    eww.url = "github:EzequielRamis/eww/css";
    secrets.url = "git+ssh://git@github.com/EzequielRamis/secrets.git";
    secrets.flake = false;
    openrgb-rules = {
      flake = false;
      url =
        "https://gitlab.com/CalcProgrammer1/OpenRGB/-/jobs/artifacts/master/raw/60-openrgb.rules?job=Linux+64+AppImage&inline=false";
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
          config.allowUnfree = true;
          localSystem = { inherit system; };
        } // o);

      pkgs = mkPkgs {
        overlays = [
          (final: prev: {
            my = lib.my.mapModules ./pkgs (p:
              prev.callPackage p {
                inherit inputs;
                inherit (lib) my;
              });
            unstable = mkPkgs { };
            eww = inputs.eww.defaultPackage."${system}";
          })
        ];
      };

      secrets = import inputs.secrets { inherit pkgs; };
      data = { inherit (inputs) openrgb-rules; };

      userData = {
        inherit pkgs system hostname username secrets data;
        inherit (lib) my;
      };

      nixConfig = with pkgs;
        import ./system/configuration.nix (userData // { inherit lib; });

    in rec {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixConfig
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = {
                home.stateVersion = "18.09";
                programs.home-manager.enable = true;
                imports = lib.my.importFrom ./home;
              };
              extraSpecialArgs = userData;
            };
          }
        ];
      };
      defaultPackage = nixosConfigurations.${hostname};
    };
}
