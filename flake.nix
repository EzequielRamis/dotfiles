{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixpkgs }:
    let
      system = "x86_64-linux";

      username = "ezequiel";
      hostname = "ramis";

      pkgs = import nixpkgs {
        config = { allowUnfree = true; };
        localSystem = { inherit system; };
      };
    in
    {
      nixosConfigurations."${hostname}" = 
      let nixConfig = with pkgs; import ./nixos/configuration.nix {
        inherit config pkgs hostname username;
      };
      in
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ nixConfig ];
      };

      homeManagerConfigurations = home-manager.lib.homeManagerConfiguration {
        inherit pkgs system username;
        homeDirectory = "/home/${username}";
        configuration.imports = ./home;
      };
    };
}
