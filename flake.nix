{
	description = "My system configuration";

	inputs = {

		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

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
		in {

		    # nixos - system hostname
		    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
		      specialArgs = {
		        inherit inputs system pkgs pkgs-stable;
		      };
		      modules = [
		        ./nixos/configuration.nix
			inputs.nixvim.nixosModules.nixvim
		      ];
		    };

		    homeConfigurations.shyonae = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			extraSpecialArgs = {
				inherit inputs system pkgs-stable;
			};
			modules = [ ./home-manager/home.nix ];
	    };
	  };
}

