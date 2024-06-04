{ config, pkgs, ... }:

{
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
}

