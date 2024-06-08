{ pkgs, userSettings }:

pkgs.writeShellScriptBin "flake-upd-all" ''
  sudo nix flake update ${userSettings.nixMainFlakeFolder}
''
