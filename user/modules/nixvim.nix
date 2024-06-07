{ lib, config, pkgs, ... }:
{
  imports = [
    ./nixvim/opts.nix
    ./nixvim/keymaps.nix
    ./nixvim/autocmds.nix
    ./nixvim/plugins/plugins-bundle.nix
  ];

  options = {
    nixvim.enable = lib.mkEnableOption "enables nixvim";
  };

  config = lib.mkIf config.nixvim.enable {
    stylix.targets.nixvim.enable = true;
    programs.nixvim = {
      enable = true;

      defaultEditor = true;
      colorschemes.oxocarbon.enable = true;

      extraPlugins = [
        pkgs.vimPlugins."heirline-nvim"
        pkgs.vimPlugins."cheatsheet-nvim"
      ];
    };
  };
}
