# ~/.config/zsh/config.d/commands.zsh
# Custom commands for zsh.

# Aliases alternative programs to commonly used commands
alias ls="exa --color=always --group-directories-first --icons"
alias du="dust"
alias find="fd"
alias grep="rg"
alias cat="bat --paging=never"
alias less="bat --paging=always"
alias man="batman"
alias diff="batdiff"
batthemes() {
	bat --list-themes | fzf --preview="bat --theme={} --color=always $1"
}

# So I don't accidentally delete anything again
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# Help Command Alias
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
alias help=run-help

# Aliases for ls
alias la="ls -a"    # Show all files including dotfiles in directory
alias l.="ls -d .*" # Show only dotfiles current directory
alias ll="ls -l"    # Show files in directory in long format
alias lla="ls -la"  # Show all files including dotfiles in directory in long format

# wezterm imgcat
alias imgcat="wezterm imgcat"

# Aliases for quick access to frequently edited dotfiles
alias zshrc="$EDITOR ~/.zshrc"
alias kakrc="kak -e edit-kakrc"

# Change directory to ranger's current directory after quitting ranger
alias ranger="ranger_cd"

# Run yadm for system files
alias sysyadm="sudo yadm -Y /etc/yadm -C /"

# Use Kakoune to align columns of text
alias align="kak -f '<a-s><S>\h<ret><a-;><&>'"

# Sets up ssh-agent and adds ssh key at default location
function ssh-setup() {
	eval "$(ssh-agent -s)" && ssh-add
}

# Single character sourcing
function source-wrapper() {
	if [[ -z "$*" ]]; then
		src
	else
		source "$@"
	fi
}

alias .="source-wrapper"

# Fallback behaviour if bd has no arguments passed
function bd-wrapper() {
	if [[ -z "$*" ]]; then
		cd ..
	else
		\bd "$@"
	fi
}

alias bd="bd-wrapper"

# Autoload zsh modules not enabled by default
autoload zcalc           # Calculator program
autoload zmv             # Move/rename files that match a pattern/
autoload -U tetriscurses # Tetris
alias tetris="tetriscurses"

# Enable zoxide
eval "$(zoxide init zsh)"
alias cd="z"