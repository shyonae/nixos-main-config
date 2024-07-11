{ config, lib, pkgs, inputs, modulesPath, ... }:
let
  systemSettings = {
    system = "x86_64-linux";
    hostname = "wslwork";
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

  environment.systemPackages = with pkgs; [
    lazydocker
    lazygit
    fastfetch
    regctl
    cron
  ];

  wsl = {
    enable = true;
    defaultUser = "shyonae";
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = false;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  nix = {
    settings = {
      trusted-users = [ "shyonae" ];
      accept-flake-config = true;
      auto-optimise-store = true;
    };

    nixPath = [
      "nixpkgs=${inputs.nixpkgs.outPath}"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
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

  boot.initrd.availableKernelModules = [ "virtio_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/mnt/wsl" =
    {
      device = "none";
      fsType = "tmpfs";
    };

  fileSystems."/usr/lib/wsl/drivers" =
    {
      device = "drivers";
      fsType = "9p";
    };

  fileSystems."/lib/modules" =
    {
      device = "none";
      fsType = "tmpfs";
    };

  fileSystems."/lib/modules/5.15.153.1-microsoft-standard-WSL2" =
    {
      device = "none";
      fsType = "overlay";
    };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/35d80675-65c9-4eb1-8e10-fe50771c58d6";
      fsType = "ext4";
    };

  fileSystems."/mnt/wslg" =
    {
      device = "none";
      fsType = "tmpfs";
    };

  fileSystems."/mnt/wslg/distro" =
    {
      device = "none";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/usr/lib/wsl/lib" =
    {
      device = "none";
      fsType = "overlay";
    };

  fileSystems."/tmp/.X11-unix" =
    {
      device = "/mnt/wslg/.X11-unix";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/mnt/wslg/doc" =
    {
      device = "none";
      fsType = "overlay";
    };

  fileSystems."/mnt/c" =
    {
      device = "C:\134";
      fsType = "9p";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/7eea8ec2-8ac8-4cf4-bee6-d0a427e092fe"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
