{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    osu-lazer-bin
    clonehero
  ];

  hardware.opengl.driSupport32Bit = true;
  programs.steam.enable = true;
}

