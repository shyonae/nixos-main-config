{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # cli utilities
    tmux
    vim
    file
    tree
    wget
    git
    fastfetch
    htop
    nix-index
    unzip
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
    lazygit
    bluez
    bluez-tools
    nixpkgs-fmt
    samba4Full
    cifs-utils
    home-manager

    # Sound
    pipewire
    pulseaudio
    pamixer
  ];
}
