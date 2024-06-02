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
			pkgs = nixpkgs.legacyPackages.${system};
			pkgs-stable = import nixpkgs-stable {
					inherit system;
					config.allowUnfree = true;
        	};
		in {

		# nixos - system hostname
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	      	inherit system inputs pkgs;
			modules = [
				./nixos/configuration.nix
				inputs.nixvim.nixosModules.nixvim
			];
			specialArgs = {
        			inherit pkgs-stable 
			};
		};

		homeConfigurations.shyonae = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			modules = [ 
				./home-manager/home.nix 
			];
			extraSpecialArgs = {
        			inherit pkgs-stable 
			};
		};
	};
}

