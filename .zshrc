# Oh-my-zsh
ZSH_DISABLE_COMPFIX=true
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="saschpe"
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Zsh history
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=$HISTSIZE
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
#setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
#setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(common-aliases dirhistory zsh-autosuggestions)
# ssh-agent
source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR=vim
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=/usr/sbin:/sbin:"${HOME}/.local/bin":"${HOME}/bin":"${PATH}"
ulimit -c unlimited # Enable core dumps

if [ `uname` != "Darwin" ] ; then
    alias open="xdg-open"
    export PATH="${PATH}:/usr/local/bin" # Avoid Brew x86 on M1
fi

function tmpcd () { cd $(mktemp -d) }

# Aliases
alias find="noglob find"
alias grep="grep -I"
alias ip="ip --color=auto"
alias df1='df --type btrfs --type ext4 --type ext3 --type ext2 --type vfat --type iso9660'
alias mount1="mount | /bin/grep -E '^/'"

# Debian packaging
export DEBFULLNAME="Sascha Peilicke"
export DEBEMAIL="sascha@peilicke.de"
export DEB_BUILD_ARCH=amd64

# Android
if [ `uname` = "Darwin" ] ; then
    export ANDROID_SDK_ROOT="${HOME}/Library/Android/sdk"
    export JAVA_HOME=`/usr/libexec/java_home -v 17`
else
    export ANDROID_SDK_ROOT="${HOME}/.android/sdk"
    case "$(grep -e "^ID=" /etc/os-release | cut -d"=" -f2)" in
        'fedora')
            export JAVA_HOME=/usr/lib/jvm/java
            ;;
        'opensuse')
            export JAVA_HOME=/usr/lib64/jvm/jre
            ;;
        'ubuntu'|*)
            if command -v javac >/dev/null ; then
                export JAVA_HOME="$(dirname $(dirname $(alternatives --list javac)))"
            fi
            ;;
    esac
fi
if [ -d "${ANDROID_SDK_ROOT}" ] ; then
    ANDROID_BUILD_TOOLS_VERSION=$(ls "${ANDROID_SDK_ROOT}/build-tools" | tail -n1)
    ANDROID_BUILD_TOOLS_ROOT="${ANDROID_SDK_ROOT}/build-tools/${ANDROID_BUILD_TOOLS_VERSION}"
    ANDROID_CMDLINE_TOOLS_VERSION=$(ls "${ANDROID_SDK_ROOT}/cmdline-tools" | tail -n1)
    ANDROID_CMDLINE_TOOLS_ROOT="${ANDROID_SDK_ROOT}/cmdline-tools/${ANDROID_CMDLINE_TOOLS_VERSION}/bin"
    if [ -d "${ANDROID_SDK_ROOT}/ndk" ] ; then
        ANDROID_NDK_VERSION=$(ls "${ANDROID_SDK_ROOT}/ndk" | tail -n1)
        export NDK_ROOT="${ANDROID_SDK_ROOT}/ndk/${ANDROID_NDK_VERSION}"
    fi
    export PATH="${PATH}":"${ANDROID_SDK_ROOT}/emulator":"${ANDROID_SDK_ROOT}/platform-tools":"${ANDROID_BUILD_TOOLS_ROOT}":"${ANDROID_CMDLINE_TOOLS_ROOT}":"${NDK_ROOT}"
fi

# Google Cloud SDK
gcloud_sdk_root="${HOME}/Applications/google-cloud-sdk"
[ -f "${gcloud_sdk_root}/path.zsh.inc" ] && source "${gcloud_sdk_root}/path.zsh.inc"
[ -f "${gcloud_sdk_root}/completion.zsh.inc" ] && source "${gcloud_sdk_root}/completion.zsh.inc"

# Dart and Flutter
export PATH="${PATH}":"${HOME}/.pub-cache/bin":"${HOME}/Applications/flutter/bin"
export CHROME_EXECUTABLE=$(command -v brave-browser)

# Docker Desktop CLI
export PATH="${PATH}":"${HOME}/.docker/bin"

# Golang
export GOPATH="${HOME}/.go"
export PATH="${PATH}":"${GOPATH//://bin:}/bin"

# Icecream / ccache (prefer over ccache which comes via /etc/profile.d/ccache.sh)
#export CCACHE_PREFIX=icecc

# Jenkins CLI
export JENKINS_URL="http://jenkins"

# Java
[ -s "$HOME/.jabba/jabba.sh" ] && source "$HOME/.jabba/jabba.sh"

# Homebrew
if [ $(uname) = "Darwin" ] ; then
    if [ $(uname -m) = "arm64" ] ; then
        export HOMEBREW_PREFIX="/opt/homebrew";
        export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
        export HOMEBREW_REPOSITORY="/opt/homebrew";
        export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew";
        export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
        export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
        export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
        export PATH="/opt/homebrew/opt/ruby/bin:${PATH}"
    else
        export PATH="/usr/local/sbin:${PATH}"
        export PATH="/usr/local/opt/ruby/bin:${PATH}"
    fi
fi

# Rubygems
if command -v ruby >/dev/null ; then
    ruby_version=$(ruby -e "puts RUBY_VERSION[0,3] + \".0\"")
    export PATH="${HOME}/.local/share/gem/ruby/${ruby_version}/bin:${HOME}/.gem/ruby/${ruby_version}/bin:${PATH}"
fi

# NodeJS
if [ $(uname) = "Darwin" ] ; then
    if [ $(uname -m) = "arm64" ] ; then
        export PATH="/opt/homebrew/opt/node@18/bin:${PATH}"
    else
        export PATH="/usr/local/opt/node@18/bin:${PATH}"
    fi
fi
