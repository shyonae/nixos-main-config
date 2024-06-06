{ lib, config, ... }:
{
  options = {
    firewall.enable = lib.mkEnableOption "enables firewall";
  };

  config = lib.mkIf config.firewall.enable {
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    networking.firewall.enable = true;
  };
}
