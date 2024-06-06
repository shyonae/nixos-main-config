{ lib, config, pkgs, pkgs-stable, ... }:
{
  options = {
    fonts.enable = lib.mkEnableOption "enables fonts";
  };

  config = lib.mkIf config.fonts.enable {
    fonts.packages = with pkgs; [
      jetbrains-mono
      fantasque-sans-mono
      noto-fonts
      noto-fonts-emoji
      twemoji-color-font
      font-awesome
      powerline-fonts
    ];
  };
}
