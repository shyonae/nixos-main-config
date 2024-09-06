{ config, lib, pkgs, pkgs-unstable, modulesPath, specificSystemSettings, ... }:
let
  systemSettings = {
    system = "x86_64-linux";
    timezone = "Europe/Rome";
    locale = "en_US.UTF-8";
    extraLocale = "it_IT.UTF-8";
  };
in
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../default.nix
    ];

  gnome.enable = lib.mkDefault false;
  bluetooth.enable = lib.mkDefault false;

  docker.enable = true;
  nfs.enable = true;
  samba.enable = true;
  ssh.enable = true;
  nixLd.enable = true;

  programs.zsh.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    lazydocker
    lazygit
    fastfetch
    regctl
    cron
  ];

  networking.firewall = {
    enable = true;
  };

  boot.loader.systemd-boot.enable = if (specificSystemSettings.bootMode == "uefi") then true else false;
  boot.loader.efi.canTouchEfiVariables = if (specificSystemSettings.bootMode == "uefi") then true else false;
  boot.loader.efi.efiSysMountPoint = specificSystemSettings.bootMountPath; # does nothing if running bios rather than uefi
  boot.loader.grub.enable = if (specificSystemSettings.bootMode == "uefi") then false else true;
  boot.loader.grub.device = specificSystemSettings.grubDevice; # does nothing if running uefi rather than bios

  # SMB Shares

  fileSystems."/smb/backups" = {
    device = "//192.168.1.12/backups";
    fsType = "cifs";
    options = [
      "uid=1000" # Set the user ID
      "gid=100" # Set the group ID
      "credentials=/home/shyonae/.smb" # Path to the credentials file
      "iocharset=utf8" # Charset encoding
      "vers=3.0" # SMB protocol version
      "noperm" # Don't check permissions
      "x-systemd.automount" # Let systemd handle automatic mount
      "x-systemd.requires=network-online.target" # Wait for network to be online
      "x-systemd.device-timeout=30s" # Retry the device for 30 seconds
      "x-systemd.mount-timeout=30s" # Timeout for each mount attempt
      "x-systemd.retry" # Retry mount until successful
    ];
  };

  fileSystems."/smb/library" = {
    device = "//192.168.1.12/library";
    fsType = "cifs";
    options = [
      "uid=1000" # Set the user ID
      "gid=100" # Set the group ID
      "credentials=/home/shyonae/.smb" # Path to the credentials file
      "iocharset=utf8" # Charset encoding
      "vers=3.0" # SMB protocol version
      "noperm" # Don't check permissions
      "x-systemd.automount" # Let systemd handle automatic mount
      "x-systemd.requires=network-online.target" # Wait for network to be online
      "x-systemd.device-timeout=30s" # Retry the device for 30 seconds
      "x-systemd.mount-timeout=30s" # Timeout for each mount attempt
      "x-systemd.retry" # Retry mount until successful
    ];
  };

  fileSystems."/smb/storage" = {
    device = "//192.168.1.12/storage";
    fsType = "cifs";
    options = [
      "uid=1000" # Set the user ID
      "gid=100" # Set the group ID
      "credentials=/home/shyonae/.smb" # Path to the credentials file
      "iocharset=utf8" # Charset encoding
      "vers=3.0" # SMB protocol version
      "noperm" # Don't check permissions
      "x-systemd.automount" # Let systemd handle automatic mount
      "x-systemd.requires=network-online.target" # Wait for network to be online
      "x-systemd.device-timeout=30s" # Retry the device for 30 seconds
      "x-systemd.mount-timeout=30s" # Timeout for each mount attempt
      "x-systemd.retry" # Retry mount until successful
    ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 12 * 1024;
  }];

  boot.kernel.sysctl = {
    "vm.swappiness" = 0;
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * *      root    sync; echo 1 > /proc/sys/vm/drop_caches"
    ];
  };

  # Networking
  networking.networkmanager.enable = true; # Use networkmanager

  # Timezone and locale
  time.timeZone = systemSettings.timezone; # time zone
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.extraLocale;
    LC_IDENTIFICATION = systemSettings.extraLocale;
    LC_MEASUREMENT = systemSettings.extraLocale;
    LC_MONETARY = systemSettings.extraLocale;
    LC_NAME = systemSettings.extraLocale;
    LC_NUMERIC = systemSettings.extraLocale;
    LC_PAPER = systemSettings.extraLocale;
    LC_TELEPHONE = systemSettings.extraLocale;
    LC_TIME = systemSettings.extraLocale;
  };
}
