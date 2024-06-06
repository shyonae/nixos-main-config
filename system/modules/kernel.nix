{ config, lib, pkgs, ... }:

{
  options = {
    kernel.enable = lib.mkEnableOption "enables kernel options";
  };

  config = lib.mkIf config.kernel.enable {
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
    boot.consoleLogLevel = 0;
  };
}
