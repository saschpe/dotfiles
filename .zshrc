##  vi:ft=sh:
##
## Zsh custom configuration file
## Created by Sascha Peilicke <saschpe@gmx.de>
##
## This file is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob
#setopt correct                              # Correct command spelling
setopt inc_append_history                   # Append every command immediatly
setopt share_history                        # Import new commands immediatly

#bindkey -v                                 # Vi key bindings
bindkey -e                                  # Emacs key bindings

# Turn on full featured completion
zstyle :compinstall filename "/home/lastmohican/.zshrc"
autoload -U zsh/zutils
autoload -Uz compinit
compinit
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:processes' command 'ps x -o pid,pcpu,tt,args'
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=$color[white]=$color[red]"
zstyle ':completion:*:*:rm:*' file-patterns '*.o:object-files %p:all-files'
zstyle ':completion:*:*:wine:*' file-patterns '*.exe:executables *(-/):directories'
zstyle ':completion:*:*:(*pdf*|acroread|rm):*' file-sort time
zstyle ':completion:*' menu select=2
#  scrolling in completition list
local LISTPROMPT=

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls="ls -h --color=auto"
    #alias dir="ls --color=auto --format=vertical"
    #alias vdir="ls --color=auto --format=long"
    alias grep="grep --color=auto --exclude-dir=.svn --exclude-dir=.git"
    alias fgrep="fgrep --color=auto --exclude-dir=.svn --exclude-dir=.git"
    alias egrep="egrep --color=auto --exclude-dir=.svn --exclude-dir=.git"
fi

# Convenience and human-readable format printing
alias v="ls -lha"
alias d="ls -ah"
alias h="history"
alias ssi="ssh -T -o UserKnownHostsFile=/dev/null"
alias top="top -d 1 -u $USER"
alias dosbox="dosbox -conf /home/saschpe/.dosbox/dosbox.conf"
alias df="df -h"
alias du="du -h"
alias free="free -m"
alias rgrep="wcgrep -r"
alias j="ps ax"
alias open="kde-open 2> /dev/null > /dev/null"
alias iosc="osc -A ibs"
alias psc='ps xawf -eo pid,user,cgroup,args'
alias virshduff='virsh -c qemu+ssh://root@duff.suse.de/system'

# Global aliases
alias -g "\&"="&> /dev/null &|"

# Fast directory change
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."

export BROWSER="/usr/bin/firefox"
export DEBFULLNAME="Sascha Peilicke"        # Useful Debian packaging stuff
export DEBEMAIL="saschpe@gmx.de"
export EDITOR="/usr/bin/vim"                # Default editor
export JAVA_HOME="/usr/lib64/jvm/java"
#export LANG=de_DE.UTF-8
#export LANGUAGE=en_US
#export LC_ALL=de_DE.UTF-8
#export LESS="-RIM"                         # Needed for git colors
export MAKEFLAGS="-j3"                      # Parallel compiling (SMP)
export PAGER="less -RMi"
export PATH=/usr/sbin:/sbin:$PATH
#export PROMPT="%n@%m:%~%# "                # Fancy prompt
if [ $UID -eq 0 ] ; then
    export PROMPT=$'%{\e[0;1;31m%}%n%{\e[0;32m%}@%m%{\e[0m%}:%{\e[0;33m%}%3~%{\e[0m%}%% '
else
    export PROMPT=$'%{\e[0;32m%}%n%{\e[0;32m%}@%m%{\e[0m%}:%{\e[0;33m%}%3~%{\e[0m%}%% '
fi

# Go language specific settings
export GOARCH=amd64
export GOOS=linux
export GOROOT=/usr/lib64/go
export GOBIN=/usr/bin
#export GOROOT=$HOME/projects/go/golang
#export GOBIN=$GOROOT/bin
export PATH=$GOBIN:$PATH

# Ruby/Rails/Rubygems settings
export PATH=$HOME/.gem/ruby/1.9.1/bin:$PATH

# suse
#export PATH=$PATH:/suse/bin
# Set generic HTTP proxy for applications which honor http_proxy
#http_proxy=http://127.0.0.1:8118/
#HTTP_PROXY=$http_proxy
#export http_proxy HTTP_PROXY

ulimit -c unlimited                         # Enable 'core' dumps

#function easy-ssh {
#    exec ssh-agent zsh
#}

# Override cd() to change environment based on the current working dir by
# searching for the ".my_setup" file.
#function cd() {
#    if test -z "$1"; then
#        builtin cd
#    elif test -z "$2"; then
#        builtin cd "$1"
#    else
#        builtin cd "$1" "$2"
#    fi
#    _f=`findup .my-setup`
#    if test -n "$_f" -a "$_lastf" != "$_f"; then
#        echo "Loading $_f"
#        _lastf="$_f"
#        source "$_f"
#    fi
#}
# Execute our new cd() function once
#cd .

# Display processes tree in less
pst () {
    pstree -p $* | less -S
}

# mkdir && cd
function mcd () { mkdir "$@"; cd "$@" }

# Create a temporary directory and cd in it
function tmpcd () { cd $(mktemp -d) }

# Find all occurences of sth in files
function find_all_in () {
    find . -type f -name "$1" | xargs grep $2
}
function find_first_in () {
    find . -type f -name "$1" | xargs grep $2 -m1
}

function osc_expand_link () {
    osc api "/source/$1/$2?rev=$3&linkrev=base&expand"
}
