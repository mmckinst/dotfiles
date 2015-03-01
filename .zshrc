#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

autoload -U compinit
compinit

autoload -U colors
colors


#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt EXTENDED_GLOB

setopt EMACS

# http://serverfault.com/questions/109207/how-do-i-make-zsh-completion-act-more-like-bash-completion
unsetopt AUTO_MENU
unsetopt MENU_COMPLETE
# https://unix.stackexchange.com/questions/12035/zsh-equivalent-of-bash-show-all-if-ambiguous
setopt BASH_AUTO_LIST

# https://stackoverflow.com/questions/444951/zsh-stop-backward-kill-word-on-directory-delimiter
autoload -U select-word-style
select-word-style bash

export PAGER=/usr/bin/less

# http://unix.stackexchange.com/questions/4859/visual-vs-editor-whats-the-difference
if [ -e /usr/bin/mg ]; then
    export EDITOR=/usr/bin/mg
    export VISUAL=/usr/bin/mg
    export SUDO_EDITOR=/usr/bin/mg
elif [ -e /usr/bin/emacs ]; then
    export EDITOR=/usr/bin/emacs
    export VISUAL=/usr/bin/emacs
    export SUDO_EDITOR=/usr/bin/emacs
else
    export EDITOR=/bin/vi
    export VISUAL=/bin/vi
    export SUDO_EDITOR=/bin/vi
fi

# protect myself from myself
alias rm='rm --preserve-root'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# so whenever I open something in the terminal it doesn't open emacs in X
alias emacs='emacs -nw'

alias ls='ls -F --color=auto'

# http://askubuntu.com/questions/4575/terminal-colours
# https://gist.github.com/sharad/rc/blob/master/LESS_TERMCAP
# make man pages all colorful
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


#PROMPT="[%F{green}%T%f][%n@%m %c]%# "
PROMPT="[%F{green}%T%f][%(?,%n@%m %c,%F{red}%n@%m %c%f)] "
