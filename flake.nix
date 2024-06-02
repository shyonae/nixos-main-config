{
	description = "My system configuration";

	inputs = {

		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		home-manager-stable = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs-stable.follows = "nixpkgs-stable";
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
			pkgs-stable = nixpkgs-stable.legacyPackages.${system};
			hostname = "nixos";
			username = "shyonae";
		in {

		# nixos - system hostname
		nixosConfigurations.hostname = lib.nixosSystem {
      		inherit system inputs;
			modules = [
				./nixos/configuration.nix
				inputs.nixvim.nixosModules.nixvim
			];
			specialArgs = {
				inherit hostname;
				inherit pkgs-stable;
			};
		};

			homeConfigurations.shyonae = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ 
					./home-manager/home.nix 
				];
				extraSpecialArgs = {
					inherit hostname;
					inherit pkgs-stable;
				};
			};
	};
}

