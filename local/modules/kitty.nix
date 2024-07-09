{ lib, config, ... }:
{
  options = {
    kitty.enable = lib.mkEnableOption "enables kitty";
  };

  config = lib.mkIf config.kitty.enable {
    stylix.targets.kitty.variant256Colors = true;
    programs.kitty = {
      enable = true;
      # Pick "name" from https://github.com/kovidgoyal/kitty-themes/blob/master/themes.json
      theme = "Cobalt2";
      settings = {
        # https://github.com/kovidgoyal/kitty/issues/371#issuecomment-1095268494
        # mouse_map = "left click ungrabbed no-op";
        # Ctrl+Shift+click to open URL.
        confirm_os_window_close = "0";
      };
    };
  };
}
