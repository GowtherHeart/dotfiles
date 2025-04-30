if status is-interactive
    # Commands to run in interactive sessions can go here
end


# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# Brew
eval "$(/opt/homebrew/bin/brew shellenv)"
set -x HOMEBREW_NO_INSTALL_CLEANUP TRUE


# ITERM
# set -x ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX YES

# mcfly init fish | source
# atuin init fish | source


# Base
set -x EDITOR nvim
set -x LANG en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -g fish_cursor_insert line
# set -x TERM screen-256color

# PATH
set -U fish_user_paths ~/.npm-global/bin $fish_user_paths
set -U fish_user_paths ~/go/bin $fish_user_paths
set -U fish_user_paths ~/.local/bin $fish_user_paths


# Base Alias
alias ls lsd
alias lsa 'lsd -a'
alias ll 'lsd -l'
alias tree 'lsd --tree'

alias lsi 'lsd --ignore-config'
alias lsai 'lsd -a --ignore-config'
alias lli 'lsd -l --ignore-config'
alias treei 'lsd --tree --ignore-config'

# alias fzf "FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git' fzf $argv"

alias rm trash

alias cat bat
alias k kubectl
alias t tmux
alias v nvim
alias bclear "pbcopy < /dev/null"

# alias nvide "NVIM_APPNAME=new_nvim neovide --frame none"
alias neo "neovide --title-hidden --fork"


# Tmux
set PROJECT_CONFIG ".local/fish/config.fish"
alias tn 'tmux new-session -d -s'

function project_config
	if test -e $PWD/$PROJECT_CONFIG
		tmux send-keys -t $argv "source $PWD/$PROJECT_CONFIG" Enter
		# tmux send-keys -t $argv "set fish_history ''" Enter
	end
	tmux send-keys -t $argv "clear" Enter
end

function tnh
    if test (count $argv) -eq 0
        set session_name (basename (pwd))
    else
        set session_name $argv
    end
    tmux new-session -d -s $session_name
    project_config $session_name
    cd
end

function tw
	set t_window $(tmux new-window -d -P -F)
	tmux send-keys -t $t_window "source $PWD/$PROJECT_CONFIG" Enter
	project_config $t_window
end

function pycache_clean
	find . -type d -name __pycache__ -exec rm -r {} \+ 
end


function ff
	aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
end

# git
alias lgit lazygit

# docker
alias ldocker lazydocker
alias dsp "docker system prune"

# wezterm
alias wrw 'wezterm cli rename-workspace'

# App
alias ipython 'ipython --TerminalInteractiveShell.editing_mode=vi'
alias pg_local 'pgcli --host 127.0.0.1 --port 5433 --user postgres --password'
alias mq_local 'pgcli --host 127.0.0.1 --port 5433 --user postgres --password'


alias ut "ulimit -n 10240"


# colors
set -g fish_color_normal ffffff
set -g fish_color_command 5ef1ff
set -g fish_color_param ffaecf
set -g fish_color_keyword 5eff6c
set -g fish_color_quote f1ff5e
set -g fish_color_redirection 5ea1ff
set -g fish_color_end bd5eff
set -g fish_color_comment 7b8496
set -g fish_color_error ff6e5e
set -g fish_color_gray 7b8496
set -g fish_color_selection --background=3c4048
set -g fish_color_search_match --background=3c4048
set -g fish_color_option f1ff5e
set -g fish_color_operator 5ea1ff
set -g fish_color_escape ffaecf
set -g fish_color_autosuggestion 7b8496
set -g fish_color_cancel ff6e5e
set -g fish_color_cwd ffbd5e
set -g fish_color_user 5ef5d2
set -g fish_color_host 5eff6c
set -g fish_color_host_remote f1ff5e
set -g fish_color_status ff6e5e
set -g fish_pager_color_progress 7b8496
set -g fish_pager_color_prefix 5ea1ff
set -g fish_pager_color_completion ffffff
set -g fish_pager_color_description 7b8496




# loaders
starship init fish | source
zoxide init fish | source
