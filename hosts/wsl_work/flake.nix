{
  description = "My system configuration";

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };

      pkgs-stable = import nixpkgs-stable {
        system = system;
        config.allowUnfree = true;
      };

      specialArgs = inputs // {
        inherit pkgs-stable pkgs inputs;
      };

      shared-modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
          };
        }
      ];

    in
    {
      nixosConfigurations = {

        wslwork = nixpkgs.lib.nixosSystem {
          inherit specialArgs system;
          modules = shared-modules ++ [
            ./wsl_work.nix
            ../../modules/system/.bundle.nix
            ../../users/shyonae-homelab.nix
            inputs.base16.nixosModule
            inputs.nixos-wsl.nixosModules.wsl
            inputs.nix-index-database.nixosModules.nix-index
          ];
        };
      };
    };


  ################# INPUTS #################


  inputs = {

    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16 = {
      url = "github:SenchoPens/base16.nix";
    };
  };
}

