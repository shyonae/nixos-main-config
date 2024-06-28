{
  description = "My system configuration";

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, aagl, ... }@inputs:
    let
      systemSettings = {
        system = "x86_64-linux";
        profile = "homelab";
        hostname = "nixos";
        timezone = "Europe/Rome";
        locale = "en_US.UTF-8";
        bootMode = "uefi";
        bootMountPath = "/boot";
        grubDevice = "/dev/sda"; # only used for legacy (bios) boot mode
      };

      userSettings = {
        username = "shyonae";
        description = "One sky. One destiny.";
        email = "";
        nixMainFlakeFolder = "$HOME/nix";
        fontName = "Fantasque Sans Mono"; # Selected font
        fontPkg = pkgs.fantasque-sans-mono; # Font package
        term = "kitty";
        browser = "floorp"; # Default browser
        editor = "vim"; # Default editor
        polarity = "dark"; # stylix polarity
        cursorName = "Bibata-Modern-Amber";
        cursorSize = 20;
        base16SchemeName = "gigavolt";
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
          ./profiles/${systemSettings.profile}/configuration.nix
          ./system/modules/.bundle.nix
          ./system/hardware-configuration.nix
          inputs.base16.nixosModule
          inputs.nix-ld.nixosModules.nix-ld
          inputs.nix-index-database.nixosModules.nix-index

          {
            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig; # Set up Cachix
            programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
            programs.anime-games-launcher.enable = true;
            programs.anime-borb-launcher.enable = true;
            programs.honkers-railway-launcher.enable = true;
            # programs.honkers-launcher.enable = true; # honkai impact 3rd
          }

        ];
        specialArgs = {
          inherit inputs pkgs-stable userSettings systemSettings;
        };
      };

      homeConfigurations.${userSettings.username} = hlib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./profiles/${systemSettings.profile}/home.nix
          ./user/modules/.bundle.nix
          inputs.nixvim.homeManagerModules.nixvim
          inputs.stylix.homeManagerModules.stylix
        ];
        extraSpecialArgs = {
          inherit inputs pkgs-stable userSettings systemSettings;
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

    stylix = {
      url = "github:danth/stylix";
      inputs.home-manager.follows = "home-manager";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16 = {
      url = "github:SenchoPens/base16.nix";
    };

    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      # Or, if you follow Nixkgs release 24.05:
      # url = "github:ezKEa/aagl-gtk-on-nix/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Name of nixpkgs input you want to use
    };
  };
}

