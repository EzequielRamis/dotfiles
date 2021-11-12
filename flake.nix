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

      pkgs = import nixpkgs {
        config = { allowUnfree = true; };
        localSystem = { inherit system; };
      };

      modulesFrom = 
        with pkgs.lib builtins;
        dir: map (m: "${dir}/${m}") (attrNames (filterAttrs (_: type: type == "directory") (readDir dir)));
    in
    {
      nixosConfigurations = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./foo/configuration.nix ];
      };
      homeManagerConfigurations = home-manager.lib.homeManagerConfiguration {
        inherit pkgs system username;
        homeDirectory = "/home/${username}";
        configuration = {
          imports = modulesFrom ./home;
        };
      };
    };
}
