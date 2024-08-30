{ config, lib, pkgs, pkgs-stable, modulesPath, ... }:
let
  systemSettings = {
    system = "x86_64-linux";
    hostname = "homelabd450";
    timezone = "Europe/Rome";
    locale = "en_US.UTF-8";
  };
in
{
  imports =
    [
      (modulesPath + "/profiles/qemu-guest.nix")
      ./default.nix
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
    enable = false;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  # SMB Shares

  fileSystems."/smb/backups" = {
    device = "//192.168.1.12/backups";
    fsType = "cifs";
    options = [ "uid=1000" "gid=100" "credentials=/home/shyonae/.smb" "iocharset=utf8" "vers=3.0" "noperm" ];
  };

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

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/6d87d40f-9e44-41d7-8f85-488200e0a686";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/3909-42BA";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  networking.useDHCP = lib.mkDefault true;


  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
