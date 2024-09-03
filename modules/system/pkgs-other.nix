{ lib, config, pkgs, pkgs-stable, ... }:
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
        # woeusb-ng
        caligula
        # syslinux-unstable
        lrcget
        feishin
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
        vlc
        # emulation
        genymotion

        nodejs # temp package
      ])

      ++

      (with pkgs-stable; [
        floorp
      ]);
  };
}
