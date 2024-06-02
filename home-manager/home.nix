{ config, pkgs, pkgs-stable, ... }: {

	imports = [
		./zsh.nix
		./modules/bundle.nix
	];

	home = {
		username = "shyonae";
		homeDirectory = "/home/shyonae";
		stateVersion = "24.05";
	};
}	
