# Autostart x after login if possible
if [[ -z $DISPLAY && ! -a /tmp/.X11-unix/X0 && $(id -u) != 0 ]]; then
	exec startx
fi


# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'


# Prompt
PS1='\[\033[0;36m\]\u@\h:\[\033[1;32m\]\w
\[\033[1;36m\]\$\[\033[0;0m\] '


# PATH
PATH=$PATH:/usr/local/bin:/usr/local/sbin:/home/rmendoza/tclock_remix
export PATH


# Editor
export EDITOR=vim


# Live Repo Stuff
alias lhg='ssh -qt live hg -R `hg root`'
alias lout='hg out ssh://live/`hg root`'
alias linc='hg inc ssh://live/`hg root`'
alias lpush='hg push ssh://live/`hg root`'
alias lpull='hg pull ssh://live/`hg root`' 


# Misc
TREE_CHARSET=$LANG
export TREE_CHARSET

LC_CTYPE=$LANG
export LC_CTYPE

