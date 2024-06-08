{ pkgs, userSettings }:

pkgs.writeShellScriptBin "sync-system" ''
  sudo nixos-rebuild switch --flake ${userSettings.nixMainFlakeFolder}
''
