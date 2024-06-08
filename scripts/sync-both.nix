{ pkgs, userSettings }:

pkgs.writeShellScriptBin "sync-both" ''
  sync-system
  sync-user
''
