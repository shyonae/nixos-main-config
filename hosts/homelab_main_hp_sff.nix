{ config, lib, pkgs, pkgs-stable, modulesPath, ... }:
let
  systemSettings = {
    system = "x86_64-linux";
    hostname = "homelabMainHPSFF";
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
  pkgsOther.enable = lib.mkDefault false;
  bluetooth.enable = lib.mkDefault false;

  docker.enable = true;
  nfs.enable = true;
  samba.enable = true;
  ssh.enable = true;
  nixLd.enable = true;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    lazydocker
    lazygit
    fastfetch
    regctl
    cron
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

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

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/a0c24063-27fe-457d-b6e7-c9094940f046";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/CEAA-A8D5";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-03c84bf83522.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-0925a95d82b2.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-32e381c44d4f.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-4b247170a98f.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-4c5f1a95c82a.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-6e737b695afc.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-7f0054c6082e.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-af5e6be8302b.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-b7ed4afd3d89.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-c2c8e5c0256b.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s18.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
