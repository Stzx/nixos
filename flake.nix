{
  description = "NixOS";

  inputs = {
    systems = {
      url = "path:./flake.systems.nix";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, disko, ... } @ args:
    let
      legacyPackages = nixpkgs.legacyPackages;

      stateVersion = "23.11";

      defaultSystem = "x86_64-linux";

      secrets = import ./rabbit-hole/secrets.nix;

      mkPkgs = system: import nixpkgs {
        localSystem = { inherit system; };
        config = {
          allowAliases = false;
          allowUnfree = true;
        };
      };

      mkLib = hostName: rec {
        nixos = self.nixosConfigurations.${hostName}.config;

        lib = nixpkgs.lib.extend (final: _: rec {
          my = import ./lib { config = nixos; lib = final; pkgs = nixpkgs; };

          inherit (my) mkDesktopCfg;
        });
      };

      mkHomeManager = username: hostName:
        let
          inherit (mkLib hostName) nixos lib;

          user = ./. + "/home-manager/${username}";
        in
        {
          "${username}@${hostName}" = home-manager.lib.homeManagerConfiguration rec {
            inherit (nixos.nixpkgs) pkgs;
            inherit lib;

            extraSpecialArgs = { inherit nixos secrets; dotsPath = ./dots; };
            modules = [
              secrets.home-manager

              ./home-manager
              ./modules/home-manager

              {
                home = {
                  inherit stateVersion username;

                  homeDirectory = "/home/${username}";
                };
              }
            ] ++ lib.optional (builtins.pathExists user) user;
          };
        };

      mkSystem = system: hostName:
        let
          inherit (mkLib hostName) lib;

          pkgs = mkPkgs system;
        in
        {
          "${hostName}" = lib.nixosSystem {
            inherit lib;

            specialArgs = { inherit secrets; };
            modules = [
              secrets.nixos
              disko.nixosModules.disko

              ./nixos
              ./modules/nixos
              (./. + "/nixos/${hostName}")

              {
                nixpkgs = { inherit pkgs; };

                system = { inherit stateVersion; };

                networking = { inherit hostName; };
              }
            ];
          };
        };
    in
    {
      devShells.${defaultSystem} = import ./flake.shells.nix {
        pkgs = legacyPackages.${defaultSystem};
      };

      nixosConfigurations = { }
      // mkSystem defaultSystem "nos"
      // mkSystem defaultSystem "vnos";

      homeConfigurations = { }
      // mkHomeManager "stzx" "nos"
      // mkHomeManager "drop" "vnos";

    } // flake-utils.lib.eachDefaultSystem (system: {
      formatter = legacyPackages.${system}.nixpkgs-fmt;
    });
}
