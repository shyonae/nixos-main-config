{ pkgs, pkgs-stable, lib, config, ... }:
{
  options = {
    mullvad.enable = lib.mkEnableOption "enables mullvad";
  };

  config = lib.mkIf config.mullvad.enable {
    services.mullvad-vpn.enable = true;
    environment.systemPackages = with pkgs; [ mullvad-vpn ];
  };
}
