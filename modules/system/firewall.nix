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
    networking.firewall = {
      enable = true;
      extraCommands = ''
        iptables -A nixos-fw -p tcp --source 192.168.1.0/24 -j nixos-fw-accept
        iptables -A nixos-fw -p udp --source 192.168.1.0/24 -j nixos-fw-accept
        iptables -A nixos-fw -p tcp --source 10.8.0.0/24 -j nixos-fw-accept
        iptables -A nixos-fw -p udp --source 10.8.0.0/24 -j nixos-fw-accept
      '';
    };
  };
}
