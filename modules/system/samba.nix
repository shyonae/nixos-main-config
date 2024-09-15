{ lib, config, pkgs, pkgs-stable, ... }:
{
  options = {
    samba.enable = lib.mkEnableOption "enables samba";
  };

  config = lib.mkIf config.samba.enable {
    services = {
      # Network shares
      samba = {
        package = pkgs.samba4Full;
        # ^^ `samba4Full` is compiled with avahi, ldap, AD etc support (compared to the default package, `samba`
        # Required for samba to register mDNS records for auto discovery 
        # See https://github.com/NixOS/nixpkgs/blob/592047fc9e4f7b74a4dc85d1b9f5243dfe4899e3/pkgs/top-level/all-packages.nix#L27268
        enable = true;
        openFirewall = true;
      };
    };
  };
}
