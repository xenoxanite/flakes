{ pkgs, lib, config, ... }:
with lib;
let cfg = config.tmux.enable;
in {
  options.tmux.enable = mkEnableOption "tmux";
  config = mkIf cfg {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      prefix = "C-a";
      terminal = "screen-256color";
      plugins = with pkgs.tmuxPlugins; [ vim-tmux-navigator ];
      extraConfig = ''
        # better split
        TERM=screen-256color
        bind '"' split-window -h -c "#{pane_current_path}"
        bind '|' split-window -v -c "#{pane_current_path}"

        # reload
        unbind r
        bind r source-file ~/.config/tmux/tmux.conf
        unbind /

        # Swap kill with display pane binds
        bind q kill-pane
        bind x display-pane

        setw -g pane-base-index 1
      '';
    };
  };
}
