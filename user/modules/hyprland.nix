{ lib, config, pkgs, inputs, userSettings, systemSettings, ... }:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    sleep 1
  '';
  plugins = inputs.hyprland-plugins.packages;
in
{
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland options";
  };

  config = lib.mkIf config.hyprland.enable {
    home.sessionVariables = {
      # If your cursor becomes invisible
      WLR_NO_HARDWARE_CURSORS = "1";
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };

    home.packages = with pkgs; [
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
      )
      libnotify
      dunst
      swww
      rofi-wayland
    ];

    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = [ "--all" ];

      plugins = with plugins."${systemSettings.system}"; [
      ];

      settings = {
        exec-once = ''${startupScript}/bin/start'';
      };
    };
  };

}
