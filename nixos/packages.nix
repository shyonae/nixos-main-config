{ pkgs, pkgs-stable,... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = 
    (with pkgs; [
    # CLI
    bitwarden-cli
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
    ranger
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

    # Sound
    pipewire
    pulseaudio
    pamixer

    # Other
    samba4Full
    cifs-utils
    home-manager
  ];);

  fonts.packages = with pkgs; [
    jetbrains-mono
    fantasque-sans-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
