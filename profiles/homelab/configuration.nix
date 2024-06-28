{ lib, config, pkgs, pkgs-stable, systemSettings, userSettings, ... }:
{
  imports =
    [
      ../work/configuration.nix
    ];

  nfs.enable = true;

  gnome.enable = lib.mkDefault false;
  adb.enable = lib.mkDefault false;
  pipewire.enable = lib.mkDefault false;
  pkgsOther.enable = lib.mkDefault false;

  environment.systemPackages = with pkgs; [
      lazydocker
    ];

  fileSystems."/nfs/backups" = {
    device = "192.168.1.12:/backups";
    fsType = "nfs4";
    options = [ "auto" "nofail" "noatime" "nolock" "intr" "tcp" "actimeo=1800" ];
  };

  # SMB Shares
  fileSystems."/smb/library" = {
    device = "//192.168.1.12/library";
    fsType = "cifs";
    options = [ "uid=1000" "gid=100" "credentials=/home/shyonae/.smb" "iocharset=utf8" "vers=3.0" "noperm" ];
  };

  fileSystems."/smb/storage" = {
    device = "//192.168.1.12/storage";
    fsType = "cifs";
    options = [ "uid=1000" "gid=100" "credentials=/home/shyonae/.smb" "iocharset=utf8" "vers=3.0" "noperm" ];
  };
}
