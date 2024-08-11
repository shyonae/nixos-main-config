{ config, lib, pkgs, pkgs-stable, modulesPath, ... }:
let
  systemSettings = {
    system = "x86_64-linux";
    hostname = "homelabthinkpadt440p1";
    timezone = "Europe/Rome";
    locale = "en_US.UTF-8";
  };
in
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
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

  services.logind.lidSwitchExternalPower = "ignore"; # prevents laptop from powering off when the lid is closed (while powered in)

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

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sr_mod" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/fbb3756b-b9b9-440b-9a3c-b7db2b4f4411";
      fsType = "ext4";
    };

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  networking.useDHCP = lib.mkDefault true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
