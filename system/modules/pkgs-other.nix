{ lib, config, pkgs, pkgs-stable, systemSettings, userSettings, ... }:
{
  options = {
    pkgsOther.enable = lib.mkEnableOption "other packages";
  };

  config = lib.mkIf config.pkgsOther.enable {
    environment.systemPackages =
      (with pkgs; [
        bottles-unwrapped
        # base16-shell-preview
        # basez # base16 binary
        cage # wayland wrapper
        woeusb-ng
        caligula
        # syslinux-unstable
        libpcap
        google-chrome
        motrix
        file
        scrot
        light
        lux
        mediainfo
        zram-generator
        cava
        zip
        ntfs3g
        brightnessctl
        openssl
        bluez
        bluez-tools
        killall
        timer
        gnugrep
        bat
        eza
        fd
        bottom
        ripgrep
        rsync
        w3m
        pandoc
        pciutils
        numbat
        # emulation
        genymotion
      ])

      ++

      (with pkgs-stable; [
        floorp
      ]);
  };
}
