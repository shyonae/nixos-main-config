{ pkgs, pkgs-stable, lib, inputs, ... }:
let
  userSettings = {
    username = "shyonae";
    description = "One sky. One destiny.";
    email = "";
    nixMainFlakeFolder = "$HOME/nix";
    fontName = "Fantasque Sans Mono";
    fontPkg = pkgs.fantasque-sans-mono;
    term = "kitty";
    browser = "floorp"; # Default browser
    editor = "vim"; # Default editor
    polarity = "dark"; # stylix polarity
    cursorName = "Kasane_Teto";
    cursorSize = 20;
    base16SchemeName = "solarized-dark";
    cursorPath = "/home/${userSettings.username}/nix/users/themes/cursors/Kasane_Teto";
  };
in
{

  users = {
    defaultUserShell = pkgs.zsh;

    users.${userSettings.username} = {
      isNormalUser = true;
      description = userSettings.description;
      extraGroups = [ "networkmanager" "wheel" "input" "dialout" "audio" "adbusers" "docker" "libvirtd" "tty" "video" ];
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

      homePkgsCore.enable = true;
      homePkgsOther.enable = true;
      syncthing.enable = true;

      home = {
        pointerCursor = {
          gtk.enable = true;
          x11.enable = true;
          # size = userSettings.cursorSize; # set in stylix
          # name = userSettings.cursorName; # set in stylix
          package = lib.mkForce (
            pkgs.runCommand "kasane-teto-cursor" { } ''
              mkdir -p $out/share/icons
              ln -s ${userSettings.cursorPath} $out/share/icons/
            ''
          );
        };

        username = userSettings.username;
        homeDirectory = "/home/${userSettings.username}";
        stateVersion = "23.05";

        sessionVariables = {
          # NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
          EDITOR = lib.mkForce userSettings.editor;
          TERM = userSettings.term;
          BROWSER = userSettings.browser;
          MOZ_ENABLE_WAYLAND = 0;
          STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${userSettings.username}/.steam/root/compatibilitytools.d";
        };
      };
    };
  };
}
