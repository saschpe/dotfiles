# Oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="saschpe"
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(common-aliases dirhistory zsh-autosuggestions)
# ssh-agent
source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR=vim
export PATH=/usr/sbin:/sbin:/usr/local/bin:"${HOME}/.local/bin":"${HOME}/bin":"${PATH}"
ulimit -c unlimited # Enable core dumps

if [ `uname` != "Darwin" ] ; then
    alias open="xdg-open"
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
    export JAVA_HOME=`/usr/libexec/java_home -v 11`
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
    ANDROID_BUILD_TOOLS_VERSION=`ls "${ANDROID_SDK_ROOT}/build-tools" | tail -n1`
    ANDROID_BUILD_TOOLS_ROOT="${ANDROID_SDK_ROOT}/build-tools/${ANDROID_BUILD_TOOLS_VERSION}"
    ANDROID_CMDLINE_TOOLS_VERSION=`ls "${ANDROID_SDK_ROOT}/cmdline-tools" | tail -n1`
    ANDROID_CMDLINE_TOOLS_ROOT="${ANDROID_SDK_ROOT}/cmdline-tools/${ANDROID_CMDLINE_TOOLS_VERSION}/bin"
    if [ -d "${ANDROID_SDK_ROOT}/ndk" ] ; then
        ANDROID_NDK_VERSION=`ls "${ANDROID_SDK_ROOT}/ndk" | tail -n1`
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
export CHROME_EXECUTABLE=`command -v brave-browser`

# Golang
export GOPATH="${HOME}/.go"
export PATH="${PATH}":"${GOPATH//://bin:}/bin"

# Rubygems
if [ -e /usr/bin/ruby ] ; then
    ruby_version=`ruby -e "puts RUBY_VERSION[0,3] + \".0\""`
    export PATH="${PATH}":"${HOME}/.gem/ruby/${ruby_version}/bin":"${HOME}/.gem/ruby/bin"
fi

# Icecream / ccache (prefer over ccache which comes via /etc/profile.d/ccache.sh)
#export CCACHE_PREFIX=icecc

# Jenkins CLI
export JENKINS_URL="http://jenkins"

# NodeJS / NPM
export PATH="${PATH}":"${HOME}/.npm/global/bin"

# Java
[ -s "/Users/saschpe/.jabba/jabba.sh" ] && source "/Users/saschpe/.jabba/jabba.sh"
