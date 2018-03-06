# Oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="saschpe"
# Set this to use case-sensitive completion
CASE_SENSITIVE="true"
# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"
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
plugins=(command-not-found common-aliases dirhistory git mercurial pep8 pip python screen suse svn web-search vundle zsh-autosuggestions)
# ssh-agent
source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=/usr/sbin:/sbin:/usr/local/bin:$HOME/.local/bin:$HOME/bin:$PATH
ulimit -c unlimited                         # Enable 'core' dumps
#setterm -blength 0                          # Get rid of beeps

# Debian packaging
export DEBFULLNAME="Sascha Peilicke"
export DEBEMAIL="sascha@peilicke.de"
export DEB_BUILD_ARCH=amd64

# Android
if [ `uname` = "Darwin" ] ; then
    export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
    # AOSP want's JDK 1.7.x, make sure we use that:
    jdk7_ver=$(ls /Library/Java/JavaVirtualMachines/ | grep "1.7" | tail -n 1)
    export ANDROID_JAVA_HOME=/Library/Java/JavaVirtualMachines/$jdk7_ver/Contents/Home/
else
    export ANDROID_SDK_ROOT=$HOME/.android/sdk
    case "$(grep -e "^ID=" /etc/os-release | cut -d"=" -f2)" in
        'fedora')
            export JAVA_HOME=/usr/lib/jvm/java
            ;;
        'opensuse')
            export JAVA_HOME=/usr/lib64/jvm/jre
            ;;
        'ubuntu'|*)
            export JAVA_HOME=$(dirname $(dirname $(update-alternatives --list javac)))
            ;;
    esac
fi
ANDROID_BUILD_TOOLS_VERSION=$(ls $ANDROID_SDK_ROOT/build-tools | tail -n1)
export NDK_ROOT=$ANDROID_SDK_ROOT/ndk-bundle
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/tools/proguard/bin:$ANDROID_SDK_ROOT/build-tools/$ANDROID_BUILD_TOOLS_VERSION:$NDK_ROOT:$PATH
export ANDROID_HVPROTO=ddm                  # Hierarchy viewer variable
alias aosp-env="source $HOME/bin/aosp-env"  # auto-source AOSP env setup script

# Chrome
export CHROME_BIN=chromium-browser

# Golang
export GOPATH=$HOME/.go
export PATH=${GOPATH//://bin:}/bin:$PATH

# Rubygems
if [ -e /usr/bin/ruby ] ; then
  export PATH=$HOME/.gem/ruby/$(ruby -e "puts RUBY_VERSION[0,3] + \".0\"")/bin:${PATH}
fi

# Icecream / ccache (prefer over ccache which comes via /etc/profile.d/ccache.sh)
#export CCACHE_PREFIX=icecc

# Jenkins CLI
export JENKINS_URL="http://jenkins"

# macOS
if [ `uname` = "Darwin" ] ; then
    # Official CMake.app
    export PATH="/Applications/CMake.app/Contents/bin":"$PATH"
else
    alias open="xdg-open"
fi

# Create a temporary directory and cd in it
function tmpcd () { cd $(mktemp -d) }
