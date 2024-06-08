{ lib, config, pkgs, pkgs-stable, userSettings, ... }:
{
  options = {
    customScripts.enable = lib.mkEnableOption "enables custom scripts";
  };

  config = lib.mkIf config.customScripts.enable {
    home.packages = with pkgs; [
      # custom scripts
      (import ../../scripts/sync-user.nix { inherit pkgs userSettings; })
      (import ../../scripts/sync-sys.nix { inherit pkgs userSettings; })
      (import ../../scripts/sync-both.nix { inherit pkgs userSettings; })
      (import ../../scripts/flake-upd-all.nix { inherit pkgs userSettings; })
      (import ../../scripts/flake-upd.nix { inherit pkgs userSettings; })
    ];
  };
}
