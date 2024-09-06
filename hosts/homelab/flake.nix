{
  description = "My system configuration";

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };

      pkgs-unstable = import nixpkgs-unstable {
        system = system;
        config.allowUnfree = true;
      };

      specialArgs = inputs // {
        inherit pkgs-unstable pkgs inputs;
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

      common-modules = [
        ../../modules/system/.bundle.nix
        ../../users/shyonae-homelab.nix
        inputs.base16.nixosModule
      ];

    in
    {
      nixosConfigurations = {

        homelabmainhpsff = nixpkgs.lib.nixosSystem {
          inherit specialArgs system;
          modules = shared-modules ++ common-modules ++ [ MAIN_DIRECTORY/hosts/homelab/homelab_main_hp_sff.nix ];
        };

        homelabthinkpadt440p1 = nixpkgs.lib.nixosSystem {
          inherit specialArgs system;
          modules = shared-modules ++ common-modules ++ [ MAIN_DIRECTORY/hosts/homelab/homelab_thinkpad_t440p_1.nix ];
        };

        homelabrd450 = nixpkgs.lib.nixosSystem {
          inherit specialArgs system;
          modules = shared-modules ++ common-modules ++ [ MAIN_DIRECTORY/hosts/homelab/homelab_rd450.nix ];
        };
      };
    };


  ################# INPUTS #################


  inputs = {

    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.home-manager.follows = "home-manager";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16 = {
      url = "github:SenchoPens/base16.nix";
    };
  };
}

