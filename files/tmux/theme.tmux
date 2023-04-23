# Use same background for status bar
set-option -g status-style bg=default

# Left side of status bar
set-option -g status-left-length 20
set-option -g status-left-style bold
set-option -g status-left ' #[fg=blue]#H#[fg=]:#[fg=green]#S#[default]  '

# Right side of status bar
set-option -g status-right-length 8
set-option -g status-right-style bold,fg=green
set-option -g status-right ' #{?pane_synchronized,[S],}#{?mouse,[M],} '

# Inactive window
set-option -gw window-status-style fg=magenta
set-option -gw window-status-format ' #I: #W '

# Active window
set-option -gw window-status-current-style bold,fg=#de935f
set-option -gw window-status-current-format '[#I: #W]'

# Clock
set-option -g clock-mode-colour magenta
set-option -g clock-mode-style 24

# Command prompt
set-option -g message-style "fg=magenta"
set-option -g message-command-style "fg=yellow"

# Pane border
set-option -g pane-border-style "fg=#999999"
set-option -g pane-active-border-style "fg=#de935f"

# Pane title
set-option -g pane-border-format " #{pane_title} "
set-environment -g TMUX_XPANES_PANE_BORDER_FORMAT " #{pane_title} "
