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
			lib = nixpkgs.lib;
			pkgs = nixpkgs.legacyPackages.${system};
		in {

		# nixos - system hostname
		nixosConfigurations.nixos = lib.nixosSystem {
	      		inherit system inputs;
			modules = [
				./nixos/configuration.nix
				inputs.nixvim.nixosModules.nixvim
			];
			specialArgs = {
        			pkgs-stable = import nixpkgs-stable {
          				inherit system;
          				config.allowUnfree = true;
        			};
			};
		};

		homeConfigurations.shyonae = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			modules = [ 
				./home-manager/home.nix 
			];
		};
	};
}

