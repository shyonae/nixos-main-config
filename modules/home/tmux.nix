{ lib, config, pkgs, ... }:
{
  options = {
    tmux.enable = lib.mkEnableOption "enables tmux";
  };

  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      shortcut = "a";
      # aggressiveResize = true; -- Disabled to be iTerm-friendly
      baseIndex = 1;
      newSession = true;
      # Stop tmux+escape craziness.
      escapeTime = 0;
      # Force tmux to use /tmp for sockets (WSL2 compat)
      secureSocket = false;

      plugins = with pkgs; [
        tmuxPlugins.better-mouse-mode
        # [Switch to session by name]: <prefix> + g
        # [Creates new session by name]: <prefix> + C
        # [Delete session without exiting tmux]: <prefix> + X
        # [Switch to the last session]: <prefix> + S
        # [Promote window to session]: <prefix> + @
        tmuxPlugins.sessionist

        # [To save]: <prefix> + CTRL-s
        # [To restore]: <prefix> + CTRL-r
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = ''
            resurrect_dir="$HOME/.tmux/resurrect"
            set -g @resurrect-dir $resurrect_dir
            set -g @resurrect-capture-pane-contents 'on'
          '';
        }
      ];

      extraConfig = ''
        # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        # Mouse works as expected
        set-option -g mouse on
        # easy-to-remember split pane commands
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
      '';
    };
  };
}
