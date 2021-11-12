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

      dirsFrom = 
        with pkgs.lib builtins;
        dir: map (m: "${dir}/${m}") (attrNames (filterAttrs (_: type: type == "directory") (readDir dir)));

      home-modules = 
        with builtins;
        filter (d: pathExists "${d}/default.nix") (dirsFrom ./home);
    in
    {
      nixosConfigurations."${hostname}" = 
      let nixConfig = import ./nixos/configuration.nix {
        inherit pkgs hostname username;
        config = pkgs.config;
      };
      in
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ nixConfig ];
      };

      homeManagerConfigurations = home-manager.lib.homeManagerConfiguration {
        inherit pkgs system username;
        homeDirectory = "/home/${username}";
        configuration = {
          imports = home-modules;
        };
      };
    };
}
