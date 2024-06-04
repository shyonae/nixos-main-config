{ pkgs, pkgs-stable, systemSettings, userSettings, ... }:
{
  imports =
    [
      ../../system/hardware-configuration.nix
      ../../system/hardware/bluetooth.nix
      ../../system/hardware/printing.nix
      ../../system/hardware/sound.nix
      ../../system/hardware/time.nix
      ../../system/services/firewall.nix
      ../../system/services/garbage-collect.nix
      ../../system/services/proxy.nix
      ../../system/services/samba.nix
      ../../system/services/ssh.nix
      ../../system/services/flatpak.nix
      ../../system/style/x11-gnome.nix
      ../../system/style/fonts.nix

      ../../user/pkgs/pkgs.nix
      ../../user/pkgs/pkgs-core.nix
      ../../user/pkgs/pkgs-desktop.nix
    ];

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
      extraGroups = [ "networkmanager" "wheel" "input" "dialout" ];
      packages = [ ];
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
