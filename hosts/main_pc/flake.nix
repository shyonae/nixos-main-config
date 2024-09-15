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
            MAIN_DIRECTORY/hosts/main_pc/main_pc.nix
            MAIN_DIRECTORY/modules/system/.bundle.nix
            MAIN_DIRECTORY/users/shyonae.nix
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
