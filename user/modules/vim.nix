{ lib, config, ... }:
{
  options = {
    vim.enable = lib.mkEnableOption "enables vim";
  };

  config = lib.mkIf config.vim.enable {
    stylix.targets.vim.enable = true;
    programs.vim = {
      enable = true;
      extraConfig = ''
        set tabstop=2
        set shiftwidth=2
        set expandtab
        set smarttab
        set backspace=indent,eol,start
      '';
    };
  };
}
