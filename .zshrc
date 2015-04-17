# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="saschpe"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias grc "git ci -C HEAD --amend"
alias open="xdg-open 2> /dev/null > /dev/null"

# Set this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often to auto-update? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to the command execution time stamp shown 
# in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(command-not-found common-aliases dirhistory git mercurial pep8 pip python screen ssh-agent suse svn web-search)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=/usr/sbin:/sbin:$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#export JAVA_HOME="/usr/lib64/jvm/jre"

ulimit -c unlimited                         # Enable 'core' dumps

#setterm -blength 0                          # Get rid of beeps

# Debian packaging stuff
export DEBFULLNAME="Sascha Peilicke"
export DEBEMAIL="saschpe@mailbox.org"
export DEB_BUILD_ARCH=amd64

# Android stuff
if [ "$TERM_PROGRAM" = "Apple_Terminal" ] ; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
else
    export ANDROID_HOME=$HOME/.android/sdk
fi
export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:${PATH}

export CHROME_BIN=chromium-browser

# Go language specific settings
#export GOARCH=amd64
#export GOOS=linux
#export GOROOT=/usr/lib64/go
#export GOBIN=/usr/bin

# Rubygems
if [ -e /usr/bin/ruby ] ; then
  export PATH=$HOME/.gem/ruby/$(ruby -e "puts RUBY_VERSION")/bin/:${PATH}
fi

# Create a temporary directory and cd in it
function tmpcd () { cd $(mktemp -d) }
