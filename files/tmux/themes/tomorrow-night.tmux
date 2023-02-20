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
# tmux < 3.2:
set-option -g status-bg default
# tmux >= 3.2:
set-option -g status-style bg=default

## highlight active window
set-option -gw window-status-current-style "bg=#282a2e,fg=#81a2be"

## highlight activity in status bar
set-option -gw window-status-activity-style "bg=#1d1f21,fg=#8abeb7"

## pane border and colors
set-option -g pane-active-border-style "bg=default,fg=#373b41"
set-option -g pane-border-style "bg=default,fg=#373b41"

set-option -g clock-mode-colour "#81a2be"
set-option -g clock-mode-style 24

set-option -g message-style "bg=#8abeb7,fg=#000000"

set-option -g message-command-style "bg=#8abeb7,fg=#000000"

# message bar or "prompt"
set-option -g message-style "bg=#2d2d2d,fg=#cc99cc"

set-option -g mode-style "bg=#8abeb7,fg=#000000"

# left side of status bar holds "(>- session name -<)"
set-option -g status-left-length 100
# set-option -g status-left-bg green
# set-option -g status-left-fg black
set-option -g status-left-style bold
set-option -g status-left '#[fg=#cc99cc,bg=#2d2d2d] #H#[fg=]:#[fg=#99cc99]#S '

# right side of status bar holds "[host name] (date time)"
set-option -g status-right-length 100
set-option -g status-right-style bold,fg=black
set-option -g status-right '#[fg=#f99157,bg=#2d2d2d]#{?mouse, [M] ,}'

# make background window look like white tab
set-option -gw window-status-style none,bg=default,fg=white
set-option -gw window-status-format '#[fg=#6699cc,bg=colour235] #I#{?pane_synchronized, [sync],} #[fg=#999999,bg=#2d2d2d] #W #[default]'

# make foreground window look like bold yellow foreground tab
set-option -gw window-status-current-style none
set-option -gw window-status-current-format '#[fg=#f99157,bg=#2d2d2d] #I#{?pane_synchronized, [sync],} #[fg=#cccccc,bg=#393939] #W #[default]'

# active terminal yellow border, non-active white
set-option -g pane-border-style "bg=default,fg=#999999"
set-option -g pane-active-border-style "fg=#f99157"

set-option -g pane-border-format " #{pane_title} "
set-environment -g TMUX_XPANES_PANE_BORDER_FORMAT " #{pane_title} "
