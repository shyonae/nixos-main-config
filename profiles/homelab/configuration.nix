{ lib, config, pkgs, pkgs-stable, systemSettings, userSettings, ... }:
{
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

  gnome.enable = lib.mkDefault false;
  bluetooth.enable = true;
  firewall.enable = true;
  garbageCollect.enable = true;
  nfs.enable = true;
  samba.enable = true;
  ssh.enable = true;
  timesyncd.enable = true;
  virt.enable = true;
  pkgsCore.enable = true;

    environment.systemPackages = with pkgs; [
      lazydocker
      lazygit
      fastfetch
    ];

  # for nix-index-database
  programs.command-not-found.enable = false;

  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # Bootloader
  # Use systemd-boot if uefi, default to grub otherwise
  boot.loader.systemd-boot.enable = if (systemSettings.bootMode == "uefi") then true else false;
  boot.loader.efi.canTouchEfiVariables = if (systemSettings.bootMode == "uefi") then true else false;
  boot.loader.efi.efiSysMountPoint = systemSettings.bootMountPath; # does nothing if running bios rather than uefi
  boot.loader.grub.enable = if (systemSettings.bootMode == "uefi") then false else true;
  boot.loader.grub.device = systemSettings.grubDevice; # does nothing if running uefi rather than bios

  # Networking
  networking.hostName = systemSettings.hostname; # Define your hostname.
  networking.networkmanager.enable = true; # Use networkmanager

  # Timezone and locale
  time.timeZone = systemSettings.timezone; # time zone
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  programs.zsh.enable = true;

  # User account
  users = {
    defaultUserShell = pkgs.zsh;

    users.${userSettings.username} = {
      isNormalUser = true;
      description = userSettings.description;
      extraGroups = [ "networkmanager" "wheel" "input" "dialout" "audio" ];
      uid = 1000;
    };
  };

  services.getty.autologinUser = userSettings.username;

  # if plugged in, closing the laptop lid doesn't suspend
  services.logind.lidSwitchExternalPower = "ignore";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
