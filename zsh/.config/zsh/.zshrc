#!/usr/bin/env zsh

###################
# Zsh Config Files
###################
# man zsh(1) zshbuiltins(1) zshmisc(1) zshmodules(1) zshoptions(1) zshzle(1)
# More info -> https://zsh.sourceforge.io/Doc/zsh_a4.pdf
# To configure Zsh for your user’s session, you can use the following files:
#
# $ZDOTDIR/.zshenv
# $ZDOTDIR/.zprofile
# $ZDOTDIR/.zshrc
# $ZDOTDIR/.zlogin
# $ZDOTDIR/.zlogout
#
# Zsh read these files in the following order:
#
# .zshenv	- Should only contain user’s environment variables.
# .zprofile	- Can be used to execute commands just after logging in.
# .zshrc	- Should be used for the shell configuration and for executing commands.
# .zlogin	- Same purpose than .zprofile, but read just after .zshrc.
# .zlogout	- Can be used to execute commands when a shell exit.
#
# I’ll use only .zshenv and .zshrc
# .zshenv will live in $HOME
# .zshrc goes into $ZDOTDIR

# OS specific Package Manager
case "$(uname -s)" in
Darwin)
	# MacOS
	if [[ -f "/opt/homebrew/bin/brew" ]] then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi
	;;
Linux)
	;;
*)
	# Other OSes (e.g. FreeBSD, AIX, Solaris)
	;;
esac
setopt KSH_ARRAYS	# arrays start at index '0' just how God intended =)

# Navigation
setopt AUTO_CD		# change directory without `cd`
setopt AUTO_PUSHD	# push the old dir onto the `cd` stack
setopt PUSHD_IGNORE_DUPS	# ignore duplicates in the stack
setopt PUSHD_SILENT	# do not print the dir stack after pushd or popd
setopt CORRECT		# spelling correction
setopt EXTENDED_GLOB	# use extended globbing syntax
setopt CDABLE_VARS	# `cd` to a valid path stored in a variable

# History
setopt EXTENDED_HISTORY		# Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY		# Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST	# Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS		# Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS	# Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS	# Do not display a previously found event.
setopt HIST_IGNORE_SPACE	# Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS	# Do not write a duplicate event to the history file.
setopt HIST_VERIFY		# Do not execute immediately upon history expansion.
setopt appendhistory

# aliases
source $ZDOTDIR/aliases.zsh

# custom commands
source $ZDOTDIR/custom-commands.zsh

# Load completions
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	# include hidden files

# prompt
autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd() { vcs_info }
setopt PROMPT_SUBST
zstyle ':vcs_info:git:*' formats '%F{153}%b%f'
RPROMPT='%F{red}%*%f'
case "$(uname -s)" in
Darwin)
	PROMPT='%(?.%F{green}✅.%F{red}❌) %f %F{blue}%n%f@%F{red}%m%f:%F{211}%~ %f[λ: ${vcs_info_msg_0_}] %# '
	;;
Linux)
	PROMPT='%(?.%F{green}✅.%F{red}❌) %f🐧 %F{blue}%n%f@%F{red}%m%f:%F{211}%~ %f[λ: ${vcs_info_msg_0_}] %# '
	;;
*)
	# Other OSes (e.g. FreeBSD, AIX, Solaris)
	;;
esac

# profiling
zmodload zsh/zprof

#
# keybindings
# vi mode
bindkey -v
export KEYTIMEOUT=1
# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
# Change cursor shape for different vi modes
function cursor_mode() {
	# more info on cursor shapes https://ttssho2.osdn.jp/manual/4/en/usage/tips/vim.html

	cursor_block='\e[1 q'
	cursor_beam='\e[5 q'

	function zle-keymap-select() {
		if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
			echo -ne $cursor_block
		elif [[ ${KEYMAP} == main ]] ||
		[[ ${KEYMAP} == viins ]] ||
		[[ ${KEYMAP} = '' ]] ||
		[[ $1 = 'beam' ]]; then
			echo -ne $cursor_beam
		fi
	}

	function zle-line-init() {
		# init `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
		zle -K viins
		echo -ne $cursor_beam
	}

	zle -N zle-keymap-select
	zle -N zle-line-init
	echo -ne $cursor_beam	# use beam cursor on startup
	preexec() {
		echo -ne $cursor_beam	# use beam shape for each new prompt
	}
}
cursor_mode

# Edit command in vim with <C-e>
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# OS specific export PATH
case "$(uname -s)" in
Darwin)
	# MacOS
	export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
	;;
Linux)
	;;
*)
	# Other OSes (e.g. FreeBSD, AIX, Solaris)
	;;
esac

# fzf
source <(fzf --zsh)
 export FZF_DEFAULT_OPTS="--tmux 80% --style full \
	--preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'"
export FZF_DEFAULT_COMMAND="fd --type f"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments ($@) to fzf.
_fzf_comprun() {
	local command=$1
	shift

	case "$command" in
		cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
		export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
		ssh)          fzf --preview 'dig {}'                   "$@" ;;
		*)            fzf --preview 'bat -n --color=always {}' "$@" ;;
	esac
}

# zoxide: z->cd; zi->cd interactive
eval "$(zoxide init zsh)"

# syntax highlighting
##!!! must be at the end of .zshrc
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

[ -f "/Users/imdibene/.ghcup/env" ] && . "/Users/imdibene/.ghcup/env" # ghcup-env
