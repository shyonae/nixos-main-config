{ pkgs, pkgs-stable, lib, inputs, ... }:
let
  userSettings = {
    username = "shyonae";
    description = "One sky. One destiny.";
    email = "";
    nixMainFlakeFolder = "$HOME/nix";
    fontName = "Fantasque Sans Mono"; # Selected font
    fontPkg = pkgs.fantasque-sans-mono; # Font package
    term = "kitty";
    editor = "vim"; # Default editor
    polarity = "dark"; # stylix polarity
    cursorName = "Bibata-Modern-Amber";
    cursorSize = 20;
    base16SchemeName = "solarized-dark";
  };
in
{

  users = {
    defaultUserShell = pkgs.zsh;

    users.${userSettings.username} = {
      isNormalUser = true;
      description = userSettings.description;
      extraGroups = [ "networkmanager" "wheel" "input" "dialout" "audio" "docker" ];
      uid = 1000;
    };
  };

  home-manager = {
    extraSpecialArgs = {
      inherit pkgs pkgs-stable userSettings;
    };

    backupFileExtension = "backup";

    users.${userSettings.username} = { pkgs, ... }: {

      imports = [
        ./default.nix
        ./../modules/home/.bundle.nix
        inputs.stylix.homeManagerModules.stylix
      ];

      homePkgsOther.enable = lib.mkDefault false;

      home = {
        username = userSettings.username;
        homeDirectory = "/home/${userSettings.username}";
        stateVersion = "23.05";

        sessionVariables = {
          EDITOR = lib.mkForce userSettings.editor;
          TERM = userSettings.term;
        };
      };
    };
  };
}
