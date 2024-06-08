{ pkgs, userSettings }:

pkgs.writeShellScriptBin "flake-upd" ''
  input=$(nix flake metadata --json ${userSettings.nixMainFlakeFolder} | nix run nixpkgs#jq ".locks.nodes.root.inputs[]" | sed "s/\"//g" | nix run nixpkgs#fzf)

  nix flake lock --update-input $input
''
