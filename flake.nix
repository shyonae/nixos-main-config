{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      hostname = "nixos";
      username = "shyonae";
      lib = nixpkgs.lib;
      hlib = home-manager.lib;
    in
    {
      nixosConfigurations.${hostname} = lib.nixosSystem {
        specialArgs = {
          inherit inputs system pkgs pkgs-stable;
        };
        modules = [
          ./nixos/configuration.nix
        ];
      };

      homeConfigurations.${username} = hlib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs system pkgs-stable username;
        };
        modules = [ 
          ./home-manager/home.nix 
          inputs.nixvim.homeManagerModules.nixvim
        ];
      };
    };
}

