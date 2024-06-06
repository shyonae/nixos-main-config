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

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:
    let
      systemSettings = {
        system = "x86_64-linux";
        profile = "personal";
        hostname = "nixos";
        timezone = "Italy/Rome";
        locale = "en_US.UTF-8";
        bootMode = "uefi";
        bootMountPath = "/boot";
        grubDevice = "/dev/sda"; # only used for legacy (bios) boot mode
      };

      userSettings = {
        username = "shyonae";
        description = "One sky. One destiny.";
        email = "";
        font = "Fantasque Sans Mono"; # Selected font
        fontPkg = pkgs.fantasque-sans-mono; # Font package
        term = "kitty";
        browser = "firefox"; # Default browser
        editor = "vim"; # Default editor
      };

      pkgs = import nixpkgs {
        system = systemSettings.system;
        config.allowUnfree = true;
      };

      pkgs-stable = import nixpkgs-stable {
        system = systemSettings.system;
        config.allowUnfree = true;
      };

      username = userSettings.username;
      hostname = systemSettings.hostname;
      lib = nixpkgs.lib;
      hlib = home-manager.lib;
    in
    {
      nixosConfigurations.${systemSettings.hostname} = lib.nixosSystem {
        modules = [
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
          ./system/modules/.bundle.nix
          ./system/hardware-configuration.nix
        ];
        specialArgs = {
          inherit inputs pkgs-stable userSettings systemSettings;
        };
      };

      homeConfigurations.${userSettings.username} = hlib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
          ./user/modules/.bundle.nix
          inputs.nixvim.homeManagerModules.nixvim
        ];
        extraSpecialArgs = {
          inherit inputs pkgs-stable userSettings systemSettings;
        };
      };
    };
}

