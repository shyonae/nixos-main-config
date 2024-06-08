{ pkgs, userSettings }:

pkgs.writeShellScriptBin "sync-user" ''
  home-manager switch --flake ${userSettings.nixMainFlakeFolder}
''
