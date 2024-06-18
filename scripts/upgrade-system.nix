{ pkgs, userSettings }:

pkgs.writeShellScriptBin "upgrade-system" ''
  sudo nixos-rebuild switch --flake ${userSettings.nixMainFlakeFolder} --upgrade
''
