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

export TERM="xterm-256color"
export DOTFILES="$HOME/.dotfiles"
export WORKSPACE="$HOME/workspace"

# for fresh installs set the env right
[ -f "$DOTFILES/setenv.zsh" ] && source "$DOTFILES/setenv.zsh"

# XDG -> https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# editor
export EDITOR="vim"
export VISUAL="vim"
export VIMINIT="source $XDG_CONFIG_HOME/vim/.vimrc"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"	# .zshrc goes into $ZDOTDIR
export HISTFILE="$ZDOTDIR/.zhistory"	# history filepath
export HISTSIZE=10000			# max entrys for internal history
export SAVEHIST=10000			# max entrys for history file
export HISTDUP=erase

# other
export TMUX_CONFIG_DIR="$XDG_CONFIG_HOME/tmux"
export TMUX_CONF="$TMUX_CONFIG_DIR/tmux.conf"
export GDB_CONFIG_DIR="$XDG_CONFIG_HOME/gdb"
export GDB_INIT="$GDB_CONFIG_DIR/.gdbinit"
export LLDB_CONFIG_DIR="$XDG_CONFIG_HOME/lldb"
export LLDB_INIT="$GDB_CONFIG_DIR/.lldbinit"
export VIM_CONFIG_DIR="$XDG_CONFIG_HOME/vim"
