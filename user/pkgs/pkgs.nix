{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # cli utilities
    tmux
    file
    nix-index
    scrot
    ffmpeg
    light
    lux
    mediainfo
    zram-generator
    cava
    zip
    ntfs3g
    yt-dlp
    brightnessctl
    swww
    openssl
    bluez
    bluez-tools
    killall
    libnotify
    timer
    gnugrep
    bat eza fd bottom ripgrep
    rsync
    w3m
    pandoc
    hwinfo
    pciutils
    numbat

    # Sound
    pipewire
    pulseaudio
    pamixer
  ];
}
