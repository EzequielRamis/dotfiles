{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, home-manager, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        username = "ezequiel";
        hostname = "ramis";

        pkgs = import nixpkgs {
          config = { allowUnfree = true; };
          localSystem = { inherit system; };
          overlays = [ inputs.nixpkgs-wayland.overlay ];
        };

        nixConfig = with pkgs; import ./nixos/configuration.nix {
          inherit pkgs hostname username;
        };

      in
      {
        nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            nixConfig
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}" = import ./home.nix;
            }
          ];
        };
      };
    );
}
