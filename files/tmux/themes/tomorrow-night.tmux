# ** Based on: https://github.com/NickTomlin/dotfiles/blob/master/home/.tmux/tomorrow-night.tmux
# ** Attribution: A modified version of https://github.com/connrs/dotfiles/blob/master/tmux/tomorrow-night.tmux
# ** Colorsheme: Tomorrow night-eighties swatch: https://raw.github.com/ChrisKempson/Tomorrow-Theme/master/Images/Tomorrow-Night-Eighties-Palette.png
#
# Color key:
# 2d2d2d Background
# 393939 Current Line
# 515151 Selection
# cccccc Foreground
# 999999 Comment
# f2777a Red
# f99157 Orange
# ffcc66 Yellow
# 99cc99 Green
# 66cccc Aqua
# 6699cc Blue
# cc99cc Purple
#
# alas, something like this does not work.
# @todo find out why
# YELLOW=ffcc66

## set status bar
set -g status-bg default

## highlight active window
setw -g window-status-current-style "bg=#282a2e,fg=#81a2be"

## highlight activity in status bar
setw -g window-status-activity-style "bg=#1d1f21,fg=#8abeb7"

## pane border and colors
set -g pane-active-border-style "bg=default,fg=#373b41"
set -g pane-border-style "bg=default,fg=#373b41"

set -g clock-mode-colour "#81a2be"
set -g clock-mode-style 24

set -g message-style "bg=#8abeb7,fg=#000000"

set -g message-command-style "bg=#8abeb7,fg=#000000"

# message bar or "prompt"
set -g message-style "bg=#2d2d2d,fg=#cc99cc"

set -g mode-style "bg=#8abeb7,fg=#000000"

# left side of status bar holds "(>- session name -<)"
set -g status-left-length 100
# set -g status-left-bg green
# set -g status-left-fg black
set -g status-left-style bold
set -g status-left '#[fg=#cc99cc,bg=#2d2d2d] #H#[fg=]:#[fg=#99cc99]#S '

# right side of status bar holds "[host name] (date time)"
set -g status-right-length 100
set -g status-right-style bold,fg=black
set -g status-right '#[fg=#f99157,bg=#2d2d2d] #{?mouse,[M] | ,}%H:%M |#[fg=#6699cc] %y.%m.%d '

# make background window look like white tab
set-window-option -g window-status-style none,bg=default,fg=white
set-window-option -g window-status-format '#[fg=#6699cc,bg=colour235] #I#{?pane_synchronized, [sync],} #[fg=#999999,bg=#2d2d2d] #W #[default]'

# make foreground window look like bold yellow foreground tab
set-window-option -g window-status-current-style none
set-window-option -g window-status-current-format '#[fg=#f99157,bg=#2d2d2d] #I#{?pane_synchronized, [sync],} #[fg=#cccccc,bg=#393939] #W #[default]'

# active terminal yellow border, non-active white
set -g pane-border-style "bg=default,fg=#999999"
set -g pane-active-border-style "fg=#f99157"

set -g pane-border-format " #{pane_title} "
set-environment -g TMUX_XPANES_PANE_BORDER_FORMAT " #{pane_title} "
