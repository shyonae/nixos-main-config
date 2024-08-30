{
  description = "My system configuration";

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, aagl, ... }@inputs:
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

        mainpc = nixpkgs.lib.nixosSystem {

          inherit specialArgs system;

          modules = shared-modules ++ [
            ./hosts/main_pc.nix
            ./modules/system/.bundle.nix
            ./users/shyonae.nix
            inputs.base16.nixosModule
            inputs.nix-index-database.nixosModules.nix-index
            {
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig; # Set up Cachix
              programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
              programs.honkers-railway-launcher.enable = true;
            }
          ];
        };

        homelabmainhpsff = nixpkgs.lib.nixosSystem {

          inherit specialArgs system;

          modules = shared-modules ++ [
            ./hosts/homelab_main_hp_sff.nix
            ./modules/system/.bundle.nix
            ./users/shyonae-homelab.nix
            inputs.base16.nixosModule
          ];
        };

        homelabthinkpadt440p1 = nixpkgs.lib.nixosSystem {

          inherit specialArgs system;

          modules = shared-modules ++ [
            ./hosts/homelab_thinkpad_t440p_1.nix
            ./modules/system/.bundle.nix
            ./users/shyonae-homelab.nix
            inputs.base16.nixosModule
          ];
        };

        homelabrd450 = nixpkgs.lib.nixosSystem {

          inherit specialArgs system;

          modules = shared-modules ++ [
            ./hosts/homelab_rd450.nix
            ./modules/system/.bundle.nix
            ./users/shyonae-homelab.nix
            inputs.base16.nixosModule
          ];
        };

        wslwork = nixpkgs.lib.nixosSystem {

          inherit specialArgs system;

          modules = shared-modules ++ [
            ./hosts/wsl_work.nix
            ./modules/system/.bundle.nix
            ./users/shyonae-homelab.nix
            inputs.base16.nixosModule
            inputs.nixos-wsl.nixosModules.wsl
            inputs.nix-ld.nixosModules.nix-ld
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

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };

    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

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

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

