#!/usr/bin/env zsh

# system
alias shutdown='sudo shutdown now'
alias restart='sudo reboot'
alias pg='ping 8.8.8.8'
# interactive mode
alias cpi='cp -i'
alias rmi='rm -i'
alias mvi='mv -i'
# general
alias g='lazygit'
alias vf="fzf --print0 | xargs -0 -o vim"
alias tree='tree -I .git -aCF --noreport'
alias d='dirs -v'
for idx ({1..9}) alias "$idx"="cd +${idx} > /dev/null"; unset idx	# dir stack
# human friendly outputs
alias df='df -h'	# human-readable sizes
alias free='free -m'	# show sizes in MB
# top offenders
alias psmem='ps auxf | sort -nr -k 4 | head -5'	# who's eating my precious memory
alias pscpu='ps auxf | sort -nr -k 3 | head -5'	# who's eating my precious cpu
alias bigf='find / -xdev -type f -size +500M'	# files > 500 MB

# vi
alias vi='vim'
alias svim='sudoedit'

# git
alias g='git'
alias ga='git add'
alias gap='git add -p'
alias gal='git add --all'
alias gb='git branch'
alias gba='git branch --all'
alias gbD='git branch --delete --force'
alias gbd='git branch --delete'
alias gc='git commit --verbose'
alias gca='git commit --verbose --amend'
alias gcane='git commit --verbose --amend --no-edit'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcb='git checkout -b'
alias gcl='git clone --recurse-submodules'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gds='git diff --staged'
alias gdup='git diff @{upstream}'
alias gfap='git fetch --all --prune'
alias gpsho='git push origin'
alias gpsh='git push'
alias gpllo='git pull origin'
alias gpll='git pull'
alias gl='git log'
alias gr='git remote'
alias grs='git remote show'
alias glo='git log --pretty="oneline"'
alias glog='git log --graph --oneline --decorate'
alias gloga='git log --graph --oneline --decorate --all'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias gs='git status'
alias gss='git status -s'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ls
alias ls='ls --color=auto'
alias l='ls -lh'
alias lla='ls -lah'
alias la='ls -A'
alias lr='ls -ltrahHF'

# tmux
alias tmuxn='tmux new -s'
alias tmuxk='tmux kill-session -t'
alias tmuxl='tmux list-sessions'

# OS specifics, e.g. Package Manager
case "$(uname -s)" in
Darwin)
	# MacOS
	alias pkmg='brew'		# Homebrew for MacOS as package manager
	alias pkmgdg='pkmg update && pm upgrade'
	;;
Linux)
	# Debian
	#alias pkmg='sudo apt'	# APT
	alias pkmg='sudo nala'	# nala apt wrapper
	alias pkmgdg='pm update && pm upgrade -y'
	alias bat='batcat'
	;;
*)
	# Other OSes (e.g. FreeBSD, AIX, Solaris)
	;;
esac
alias pkmgi='pkmg install'
alias pkmgs='pkmg search'
alias pkmgud='pkmg update'
alias pkmgug='pkmg upgrade'

# docker
alias dockls="docker container ls | awk 'NR > 1 {print \$NF}'"	# display names of running containers
alias dockstats='docker stats $(docker ps -q)'	# stats on images
alias dockimg='docker images'			# list images installed
alias dockprune='docker system prune -a'	# prune everything

# personal
# directories
alias work='$WORKSPACE'
alias dotfiles='$DOTFILES'
alias doc='$HOME/Documents'
alias dwn='$HOME/Downloads'

# knowledge base
alias kbhome='$HOME/Documents/knowledge-base'
