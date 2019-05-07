# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# https://unix.stackexchange.com/questions/39273/how-to-navigate-within-bashs-reverse-search
# https://stackoverflow.com/questions/791765/unable-to-forward-search-bash-history-similarly-as-with-ctrl-r
# https://stackoverflow.com/questions/24623021/getting-stty-standard-input-inappropriate-ioctl-for-device-when-using-scp-thro
# make ctrl-s work for searching forward in bash history
[[ $- == *i* ]] && stty -ixon

# https://stackoverflow.com/questions/1030182/how-do-i-change-bash-history-completion-to-complete-whats-already-on-the-line
#bind '"\e[A": history-search-backward'
#bind '"\e[B": history-search-forward'

# http://unix.stackexchange.com/questions/31/list-of-useful-less-functions
# http://blog.nexcess.net/2011/10/30/features-of-the-less-pager/
# -G - turn off highlighting
# -M - show line number and percentage
# -I - ignore case in searches
# -S - chop off long lines
# ma - mark position as 'a', return with 'a
# &pattern - only show lines matching pattern
# &!pattern - exclude lines matching pattern
export PAGER=/usr/bin/less

# -F Causes less to automatically exit if the entire file can be displayed on
#    the first screen
# -X don't send termcap stuff so it will stop clearing the screen when it exits
# -M show line number and percentage
#export LESS=-J

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

# formatted as 2000-03-14 03:14:15
export HISTTIMEFORMAT="%F %T "

# https://superuser.com/questions/310914/permanently-change-date-time-format-for-ls
# http://rene.kabis.org/2011/05/07/linux-and-displaying-dates-in-iso-8601-format/
export TIME_STYLE=long-iso

# http://unix.stackexchange.com/questions/4859/visual-vs-editor-whats-the-difference
# too many scripts are use $EDITOR to choose your editor instead of $VISUAL and
# I am sick of having to edit stuff in ed so just set $EDITOR to a fancy pants
# editor instead of a line editor
if [ -e /usr/bin/mg ]; then
    export EDITOR="/usr/bin/mg -n"
    export VISUAL="/usr/bin/mg -n"
elif [ -e /usr/bin/emacs ]; then
    export EDITOR="/usr/bin/emacs -q -nw"
    export VISUAL="/usr/bin/emacs -q -nw"
else
    export EDITOR=/bin/vi
    export VISUAL=/bin/vi
fi

# so whenever I open something in the terminal it doesn't open emacs in X
alias emacs='emacs -nw'

# protect myself from myself
alias rm='rm --preserve-root'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# GREP_OPTIONS is deprecated, replace with aliases
alias  grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'

# With -F, on listings append the following
#    '*' for executable regular files
#    '/' for directories
#    '@' for symbolic links
#    '|' for FIFOs
#    '=' for sockets
alias ls='ls -F --color=auto'
alias htop='htop --no-color'
alias mtr='mtr --show-ips'

# only append to bash history to prevent it from overwriting it when you have
# multiple ssh windows open
shopt -s histappend
# save all lines of a multiple-line command in the same history entry
shopt -s cmdhist
# correct minor errors in the spelling of a directory component
shopt -s cdspell
# check the window size after each command and, if necessary, updates the values of LINES and COLUMNS
shopt -s checkwinsize

# emacs as readline mode
# is default but will set anyways
set -o emacs

# http://superuser.com/questions/394153/what-causes-bash-to-pause-after-a-bad-command
unset command_not_found_handle


# print out the field numbers in awk would be for a line. you can give it a
# custom FS too if you want
function ad {
    if [[ "$1" ]]; then
        awk -F"$1" '{print $0; {for (f=1; f<=NF; f++) {printf "%2d %s\n", f, $f}}print ""}'
    else
        awk '{print $0; {for (f=1; f<=NF; f++) {printf "%2d %s\n", f, $f}}print ""}'
    fi
}

if [[ -e /usr/share/powerline/bash/powerline.sh ]]; then
    source /usr/share/powerline/bash/powerline.sh
fi
