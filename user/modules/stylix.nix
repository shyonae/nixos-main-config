{ lib, config, pkgs, userSettings, ... }:
{
  options = {
    stylix.enable = lib.mkEnableOption "enables stylix";
  };

  config = lib.mkIf config.stylix.enable {

    home.packages = with pkgs; [
      base16-schemes
      bibata-cursors
    ];

    stylix = {
      targets.gtk.enable = true;
      targets.lazygit.enable = true;
      targets.vscode.enable = true;
      targets.gnome.enable = true;

      autoEnable = true;
      # nix build nixpkgs#bibata-cursors
      # nix build nixpkgs#base16-schemes
      # cd result
      # https://sesh.github.io/base16-viewer/
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${userSettings.base16SchemeName}.yaml";
      image = ./themes/wallpapers/kh2.8.png;

      cursor = {
        name = userSettings.cursorName;
        size = userSettings.cursorSize;
      };

      fonts = {
        monospace = {
          package = userSettings.fontPkg;
          name = userSettings.fontName;
        };
        sansSerif = {
          package = userSettings.fontPkg;
          name = userSettings.fontName;
        };
        serif = {
          package = userSettings.fontPkg;
          name = userSettings.fontName;
        };
      };

      opacity = {
        applications = 0.9;
        popups = 0.9;
        terminal = 0.7;
        desktop = 0.5;
      };

      polarity = userSettings.polarity;
    };
  };
}
