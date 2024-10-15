# more intuitive splits
bind-key "|" split-window -h -c "#{pane_current_path}"
bind-key "\\" split-window -fh -c "#{pane_current_path}"
bind-key "-" split-window -v -c "#{pane_current_path}"
bind-key "_" split-window -fv -c "#{pane_current_path}"

# swap windows
bind -r "<" swap-window -d -t -1
bind -r ">" swap-window -d -t +1

# join pane
bind-key j choose-window 'join-pane -h -s "%%"'
bind-key J choose-window 'join-pane -s "%%"'

# add binding to reload tmux.conf for fast, iterative development
# <C-b>+r --> refreshes the tmux config
bind r source-file "${TMUX_CONF}"\; \
display "$TMUX_CONF reloaded!"

# keep current path when creating a new window
bind c new-window -c "#{pane_current_path}"

# go to a marked pane <C-b>+m to mark it first
bind \` switch-client -t'{marked}'

# toggles the synchronization of the panes: <C-b>+<Meta(alt)>-s
bind-key M-s set-window-option synchronize-panes\; \
display-message "This Window\'s panes are now sync [#{?pane_synchronized,on,of}]"

# switch panes using <Meta(alt)>-arrow without prefix <C-b>
bind -n M-Left select-pane -L
bind -n M-Down select-pane -D
bind -n M-Up select-pane -U
bind -n M-Right select-pane -R

# mouse mode
bind m \
	set -g mouse on \; \
	display 'mouse mode: ON'
bind M \
	set -g mouse off \; \
	display 'mouse mode: OFF'

