{
  # Better terminal, with good rendering.
  programs.kitty = {
    enable = true;
    # Pick "name" from https://github.com/kovidgoyal/kitty-themes/blob/master/themes.json
    theme = "Tokyo Night";
    font = {
      name = "Monaco";
      size = 14;
    };
    settings = {
      # https://github.com/kovidgoyal/kitty/issues/371#issuecomment-1095268494
      # mouse_map = "left click ungrabbed no-op";
      # Ctrl+Shift+click to open URL.
      confirm_os_window_close = "0";
    };
  };
}
