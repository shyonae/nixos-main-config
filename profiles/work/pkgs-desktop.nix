{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gparted
    floorp
  ];
}
