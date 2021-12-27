if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Disable welcome message
set -U fish_greeting

# Set default terminal mode
set -x -g TERM "xterm-256color"

# Keep less output on the screen
set -x -g LESS -iXFR

# Set Emacs to default editor
set -x -g EDITOR 'emacsclient -t -a ""'

# User bin folder
set -x -g PATH ~/bin ~/.local/bin $PATH /usr/local/sbin

# Readline colors
set -g fish_color_autosuggestion 585858
set -g fish_color_cancel \x2dr
set -g fish_color_command a1b56c
set -g fish_color_comment f7ca88
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end ba8baf
set -g fish_color_error ab4642
set -g fish_color_escape 86c1b9
set -g fish_color_history_current \x2d\x2dbold
set -g fish_color_host normal
set -g fish_color_host_remote yellow
set -g fish_color_match 7cafc2
set -g fish_color_normal normal
set -g fish_color_operator 7cafc2
set -g fish_color_param d8d8d8
set -g fish_color_quote f7ca88
set -g fish_color_redirection d8d8d8
set -g fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
set -g fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
set -g fish_color_status red
set -g fish_color_user brgreen
set -g fish_color_valid_path \x2d\x2dunderline
set -g fish_pager_color_completion normal
set -g fish_pager_color_description B3A06D\x1eyellow
set -g fish_pager_color_prefix normal\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
set -g fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan
