{ lib, config, ... }:

{
  options = {
    htop.enable = lib.mkEnableOption "enables htop";
  };

  config = lib.mkIf config.htop.enable {
    programs.htop = {
      enable = true;
      settings = {
        tree_view = 1;
      };
    };
  };
}
