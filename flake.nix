{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
  };

  outputs = { self, home-manager, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "ezequiel";
      hostname = "ramis";

      pkgs = import nixpkgs {
        config = { allowUnfree = true; };
        localSystem = { inherit system; };
        overlays = with inputs; [ nixpkgs-wayland.overlay ];
      };

      nixConfig = with pkgs; import ./nixos/configuration.nix {
        inherit pkgs system hostname username;
        inherit (inputs) nixpkgs-wayland;
      };

      hmConfig = import ./home.nix {
        inherit pkgs home-manager hostname username;
      };

    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixConfig
          hmConfig
        ];
      };
    };
}
