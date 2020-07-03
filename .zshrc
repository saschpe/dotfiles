# Oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="saschpe"
# Set this to use case-sensitive completion
CASE_SENSITIVE="true"
# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"
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
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew command-not-found common-aliases dirhistory dnf docker gem git kubectl lol npm pep8 pip python screen sdk vundle web-search zsh-autosuggestions)
# ssh-agent
source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=/usr/sbin:/sbin:/usr/local/bin:$HOME/.local/bin:$HOME/bin:$PATH
ulimit -c unlimited                         # Enable 'core' dumps
#setterm -blength 0                          # Get rid of beeps
export EDITOR=vim

# Aliases
alias find="noglob find"
alias grep="grep -I"
alias ip="ip --color=auto"

# Debian packaging
export DEBFULLNAME="Sascha Peilicke"
export DEBEMAIL="sascha@peilicke.de"
export DEB_BUILD_ARCH=amd64

# Android
if [ `uname` = "Darwin" ] ; then
    export ANDROID_SDK_ROOT=${HOME}/Library/Android/sdk
    export JAVA_HOME=`/usr/libexec/java_home -v 11`
else
    export ANDROID_SDK_ROOT=${HOME}/.android/sdk
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
    ANDROID_CMDLINE_TOOLS_ROOT="${ANDROID_SDK_ROOT}/cmdline-tools/${ANDROID_CMDLINE_TOOLS_VERSION}/tools/bin"
    if [ -d "${ANDROID_SDK_ROOT}/ndk" ] ; then
        ANDROID_NDK_VERSION=$(ls "${ANDROID_SDK_ROOT}/ndk" | tail -n1)
        export NDK_ROOT="${ANDROID_SDK_ROOT}/ndk/${ANDROID_NDK_VERSION}"
    fi
    export PATH=${ANDROID_SDK_ROOT}/emulator:${ANDROID_SDK_ROOT}/platform-tools:${ANDROID_SDK_ROOT}/tools:${ANDROID_BUILD_TOOLS_ROOT}:${ANDROID_CMDLINE_TOOLS_ROOT}:${NDK_ROOT}:${PATH}
fi

# Google Cloud SDK
gcloud_sdk_root="${HOME}/Applications/google-cloud-sdk"
[ -f "${gcloud_sdk_root}/path.zsh.inc" ] && . "${gcloud_sdk_root}/path.zsh.inc"
[ -f "${gcloud_sdk_root}/completion.zsh.inc" ] && . "${gcloud_sdk_root}/completion.zsh.inc"

# Dart and Flutter
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/Applications/flutter/bin"
export CHROME_EXECUTABLE=`command -v brave-browser`

# Golang
export GOPATH="$HOME/.go"
export PATH="${PATH}":"${GOPATH//://bin:}/bin"

# Rubygems
if [ -e /usr/bin/ruby ] ; then
    export PATH="${PATH}":"${HOME}/.gem/ruby/$(ruby -e "puts RUBY_VERSION[0,3] + \".0\"")/bin:${HOME}/.gem/ruby/bin"
fi

# Icecream / ccache (prefer over ccache which comes via /etc/profile.d/ccache.sh)
#export CCACHE_PREFIX=icecc

# Jenkins CLI
export JENKINS_URL="http://jenkins"

# macOS
if [ `uname` = "Darwin" ] ; then
    # Official CMake.app
    export PATH="${PATH}":"/Applications/CMake.app/Contents/bin"
else
    alias open="xdg-open"
fi

# Create a temporary directory and cd in it
function tmpcd () { cd $(mktemp -d) }

# SDKMAN!
export SDKMAN_DIR="/home/saschpe/.sdkman"
[[ -s "/home/saschpe/.sdkman/bin/sdkman-init.sh" ]] && source "/home/saschpe/.sdkman/bin/sdkman-init.sh"

# Node.JS / NPM
export PATH="${PATH}":"${HOME}/.npm/global/bin"
