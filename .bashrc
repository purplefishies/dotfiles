#!/bin/bash
#****************************************************************************
# config::name= .bashrc
# config::desc= Jimbo's Bash settings....
# config::author= jamesd
# config::cvs= $Id$
# config::changed= $Date$
# config::modusr= $Author$
# config::notes=
#                1. Sets up my bash shell
#                2. Tries to use generic files so that they can be used by 
#                   my TCSH and BASH users alike.
# config::todo=
#                1. New prompt which displays infor`mation to the Title.
#****************************************************************************

if [ -t 0 ] ; then
    stty stop ''
    stty start ''
    stty -ixon
    stty -ixoff

    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # Color settings
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    WHITE=$(tput setaf 7 )
    RED=$(tput setaf 1 )
    GREEN=$(tput setaf 2 )
    RESET=$(tput sgr0 )
    YELLOW=$(tput setaf 3)
    BOLD=$(tput bold)
fi

PERL="/usr/bin/perl"
MY_OS=`uname -s`
MY_TEST="test"

MY_ID=`id | perl -ne 's/^\S+=\d+\((\S+?)\).*/$1/; print;'`
my_version_num=`echo $BASH_VERSION | /usr/bin/perl -ne 's/^(\d+)\..*/$1/; print ; '`
MY_CAD="${HOME}/Scripts/CAD"
BASH_VRS=`echo $BASH_VERSION | sed 's/^\([0-9]\)\..*/\1/'`

if [ 1 ] ; then
# Before
    MY_PROMPT='$RED\h ${WHITE}\w % '
else 
    MY_PROMPT="${RED}\h ${WHITE}\w % "
fi

#
# Diff Application
#
export DIFF_APP=bcompare

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Loading functions...
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if [ -f $HOME/.functions ] ; then
    source $HOME/.functions
    aio
fi

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Loading Aliases....
#
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

if [[ "${HOME}/.alias" -nt "${HOME}/.bash_alias" ]] ; then
    if [ -f "${HOME}/.bash_alias" ]; then
        rm "${HOME}/.bash_alias"
    fi
    if [ "$(type -t ldalias)" ] ; then
        ldalias "${HOME}/.alias"
    fi
elif [[ -f "${HOME}/.bash_alias" ]]; then
    source ${HOME}/.bash_alias >&1 >/dev/null
else
    if [ "$(type -t ldalias)" ] ; then
        ldalias "${HOME}/.alias"
    fi
fi

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 
# Setting up the PATH environment and Environmental variables
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

test -f ${HOME}/.env && ldenv ${HOME}/.env

export GRADLE_OPTS="-Dorg.gradle.daemon=true,org.gradle.jvmargs=-Xmx2048M"

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Clearing temporary variables
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
unset lowos

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Linux Path stuff
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

export PATH="$PATH:/sbin:/bin:/usr/bin:/usr/local/bin:/usr/sbin:"
export PATH="$PATH:$HOME/Scripts"
export PATH="$PATH:/usr/games"

export PATH="$PATH:/usr/lib/lapack"
export PATH="$PATH:/opt/local/bin"

export PATH="$PATH:$HOME/Tools/bin"

export PERLDB_OPTS=HistFile=$HOME/.perldb.hist
# Android stuff
export ANDROID_HOME=${HOME}/Tools/android-sdk-linux
export ANDROID_SDK=${HOME}/Tools/android-sdk-linux
export ANDROID_NDK=${HOME}/Tools/android-ndk-r10e
export ANDROID_SDK_HOME=$ANDROID_SDK
export ANDROID_NDK_HOME=$ANDROID_NDK

export ANDROID_NDK_ROOT=${HOME}/Tools/android-ndk-r10e
export ANDROID_TOOLS_DIR=$ANDROID_SDK/tools

export PATH=$PATH:$ANDROID_SDK/platform-tools
export PATH=$PATH:$ANDROID_NDK_HOME

export MODULESHOME=$HOME/Modules

if [[ -f "/etc/bash_completion" ]] ; then
    source "/etc/bash_completion"
fi

if [[ -f "/usr/share/bash-completion/bash_completion" ]] ; then
    source "/usr/share/bash-completion/bash_completion"
fi

if [[ -f "$HOME/.bash_stuff/modules/init/bash" ]] ; then
    source "$HOME/.bash_stuff/modules/init/bash"
fi

if [[ -f "${HOME}/.colors" ]] ; then
    oldIFS=${IFS}
    IFS=$(echo -ne "\b\n")
    for i in $(cat "$HOME/.colors" ); do 
        eval "$i"; 
    done
    if [[ "${oldIFS}"  != "" ]] ; then
        IFS=$oldIFS
    fi
fi

LONG_PROMPT='\[$RED\]\h \[$RESET\]\w '
SHORT_PROMPT='\[$RED\]\h \[$RESET\]\W '
STEALTH_PROMPT='\[$RED\]\h \[$RESET\] '
GIT_COLOR='\[$GREEN$BOLD\]'
SVN_COLOR='\[$YELLOW$BOLD\]'

if [[ "$(type -t __svn_ps1 )" == "function" ]] ; then
    LONG_PROMPT=${LONG_PROMPT}${SVN_COLOR}'$(__svn_ps1)'
    SHORT_PROMPT=${SHORT_PROMPT}${SVN_COLOR}'$(__svn_ps1)'
else

    echo "Can't find definition for __svn_ps1"
    function __svn_ps1() {
        ""
    }
fi

if [[ "$(type -t __git_ps1 )" == "function" ]] ; then
    LONG_PROMPT=${LONG_PROMPT}${GIT_COLOR}'$(__git_ps1 "(%s)")\[$RESET\]% '
    SHORT_PROMPT=${SHORT_PROMPT}${GIT_COLOR}'$(__git_ps1 "(%s)")\[$RESET\]% '
    STEALTH_PROMPT=${STEALTH_PROMPT}${GIT_COLOR}'$(__git_ps1 "(%s)")\[$RESET\]% '
    tty -s && export PS1=$LONG_PROMPT
else
    echo "Can't find definition for __git_ps1...ignoring"    
    LONG_PROMPT=${LONG_PROMPT}'\[$RESET\]% '
    SHORT_PROMPT=${SHORT_PROMPT}'\[$RESET\]% '
    STEALTH_PROMPT=${STEALTH_PROMPT}'\[$RESET\]% '
    tty -s && export PS1=$LONG_PROMPT
fi

if [ -f "$HOME/.ls_colors" ] ; then
    eval $( dircolors -b $HOME/.ls_colors )
else
    # Backup colors
    export LS_COLORS="no=00:fi=00:di=00;36:*.pdf=01;33:ln=01;36:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;21;01:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.svgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.dz=00;31:*.gz=00;31:*.bz2=00;31:*.tbz2=00;31:*.bz=00;31:*.tz=00;31:*.deb=00;31:*.rpm=00;31:*.jar=01;32:*.rar=00;31:*.ace=00;31:*.zoo=00;31:*.cpio=00;31:*.7z=00;31:*.rz=00;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=01;35:*.mng=00;35:*.pcx=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.m2v=00;35:*.mkv=00;35:*.ogm=00;35:*.mp4=00;35:*.m4v=00;35:*.mp4v=00;35:*.vob=00;35:*.qt=00;35:*.nuv=00;35:*.wmv=00;35:*.asf=00;35:*.rm=00;35:*.rmvb=00;35:*.flc=00;35:*.avi=00;35:*.fli=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.yuv=00;35:*.svg=00;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:"
fi

# Old mac colors
export LSCOLORS="Exfxcxdxbxegedabagacad"

if [[ -f "$HOME/.bash_stuff/cdargs/cdargs-bash.sh" ]] ; then
    source $HOME/.bash_stuff/cdargs/cdargs-bash.sh
fi

if [[ -f "/etc/bash_completion" ]] ; then
    source /etc/bash_completion
else
    echo "Can't find file /etc/bash_completion to source...please install"
fi

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# My Custom History settings
#
# 1. I want to save all history for posterity into $HOME/.bashcmd_history
#
# 2. I want to only save original commands
#
# 3. Ignore some things that I don't want to save
#
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
shopt -s histappend
export HISTTIMEFORMAT='+%c %z '
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTFILENAME=.bash_history
export HISTFILENEWNAME=bash_history
export HISTPREFIX=""
export HISTFILE=$HOME/${HISTFILENAME}
export HISTCONTROL="ignoredups:erasedups"
export HISTIGNORE="ls:ll:more *:lless *:history:history *:source .bashrc:clear_last_history:tmux *attach"
export HISTDIRECTORY=$HOME/.bashcmd_history 
export HIST_RESET_OFFSET=2000
export HIST_ROLLOVER_SIZE=10000

unset R_HOME

shopt -s histappend
if [ ! -d "$HISTDIRECTORY" ] ; then
    mkdir $HISTDIRECTORY
fi

function save_history() { 
    cp "$HISTFILE" "${HISTDIRECTORY}/${HISTPREFIX}${HISTFILENEWNAME}_$(date '+%Y_%m_%d_%H%M%S')"
}

function clear_last_history() {
    history -d $(history | tail -1 | perl -pne 's/^\s*(\d+)\b.*$/$1/;')
    history -d $(history | tail -1 | perl -pne 's/^\s*(\d+)\b.*$/$1/;')
}

function rollover_history() { 
    history -a
    if [[ $(history | /usr/bin/wc -l | /usr/bin/awk '{print $1}') -gt $HIST_ROLLOVER_SIZE ]] ; 
    then
        save_history
        tail -$HIST_RESET_OFFSET ${HISTFILE} > "${HISTFILE}.tmp"
        /bin/mv -f "${HISTFILE}.tmp" ${HISTFILE}
        history -c >/dev/null
        history -r >/dev/null
    fi
}
export PROMPT_COMMAND="rollover_history"

# Load the old history
history -n 

export ECLIPSE_PLUGIN_HOME=$HOME/Tools/eclipse/plugins

if [ -f "${ECLIPSE_PLUGIN_HOME}/org.junit_4.10.0.v4_10_0_v20120426-0900/junit.jar" ] ; then
    export CLASSPATH=${ECLIPSE_PLUGIN_HOME}/org.junit_4.10.0.v4_10_0_v20120426-0900/junit.jar
fi

if [ -f "/tools/mxlcad/gnutools/etc/bash_completion" ] ; then
  . /tools/mxlcad/gnutools/etc/bash_completion
fi

export MANPATH=/opt/local/man:$MANPATH:/opt/n1ge6/man:/usr/man
export MANPATH=$MANPATH:/Library/Frameworks/R.framework/Versions/2.12/Resources
export MANPATH="${HOME}/Downloads/llvm/docs/CommandGuide/man/man1:${HOME}/Downloads/root/man/man1:${HOME}/perl5/man/man1:/opt/novell/groupwise/client/java/man/man1:/opt/novell/man/man1:/usr/Modules/3.2.9/share/man/man1:/usr/local/share/man:/usr/share/man"

#
# Pager configuration
#
export PAGER=less
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s "
export LESS="-X -R"
export LC_ALL="C"
export LESSCHARSET=utf-8

export RI="--format ansi --width 100"

if [ -d "$HOME/.bash" ] ; then
    for i in `/bin/ls $HOME/.bash/*.sh` ; do
        . $i
    done
fi

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

export SDK_ROOT=/Developer/SDKs/android-sdk-mac_86
export PATH=$PATH:$SDK_ROOT/tools/
export PATH=$PATH:/opt/local/lib/mysql5/bin

# 
# Android
#

if [ -d "$ANDROID_TOOLS_DIR" ] ; then
    export PATH=$PATH:${HOME}/Tools/android-sdk-linux/tools
fi

if [ -f "/opt/local/etc/bash_completion" ]; then
    . /opt/local/etc/bash_completion
fi

if [ -f "/opt/local/etc/profile.d/cdargs-bash.sh" ]; then
    source /opt/local/etc/profile.d/cdargs-bash.sh
fi

export PERL5LIB="${HOME}/perl5/lib/perl5:${HOME}"


alias ack='/usr/bin/ack-grep'
alias aack='/usr/bin/ack-grep --color'

if [ "$DISPLAY" ] ; then
    export EDITOR="$(which emacs) -nw "
    export ALTERNATE_EDITOR="emacs"      
    export VISUAL="$(which emacs) -nw "
else 
    export ALTERNATE_EDITOR=""      
    export EDITOR="$(which emacs) -nw "
    export VISUAL="$(which emacs) -nw "
fi

export PATH=$PATH:/usr/share/apache-maven-3.0.5/bin
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

export TEXINPUTS="$HOME/Latex://;"
export POWERLINE_CONFIG_COMMAND=/usr/local/bin/powerline-config

fd=0
if [[ -t "$fd" || -p /dev/stdin ]]
then
    shopt -s direxpand
    shopt -s cdable_vars
    shopt -s cmdhist
    shopt -s cdspell
fi

if [ "$COLORTERM" == "gnome-terminal" ] || [ "$COLORTERM" == "xfce4-terminal" ]
then
    TERM=xterm-256color
    #TERM=screen-256color-italic
elif [ "$COLORTERM" == "rxvt-xpm" ]
then
    TERM=rxvt-256color
fi

sprompt on

export MODULEHOME=${HOME}/Modules
export MODULESHOME=${HOME}/Modules
if [ -f "${HOME}/Dropbox/Projects/SysAdmin/tcl/init/bash" ] ; then
   source ${HOME}/Dropbox/Projects/SysAdmin/tcl/init/bash
fi
export MODULEPATH=$HOME/Modules

if [ -n "$TMUX" ]; then
    function refresh {
        export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
        export $(tmux show-environment | grep "^DISPLAY")
        export $(tmux show-environment | grep "^DBUS_SESSION_BUS_ADDRESS")
        export $(tmux show-environment | grep "^GPG_AGENT_INFO" )
        export $(tmux show-environment | grep "^GNOME_KEYRING_CONTROL" )
    }
    

else
    function refresh { 
        echo -ne ""
    }
    function set_tmux_environment {
        for i in SSH_AUTH_SOCK DISPLAY DBUS_SESSION_BUS_ADDRESS GNOME_KEYRING_CONTROL GPG_AGENT_INFO ; 
        do
            cmd="tmux set-environment $i \$${i}"
            eval $cmd
        done
    }

fi

function reload {
    module purge
    module load preconfig/usb-development-latest-ai16
    cdb mcbridelib/..
    . sourceme.sh
    cd -
}

function cleantex {
    for i in *.tex
    do
        j=$(echo $i | perl -ne 's/\..*//g;print;')
        echo "Cleaning $j.tex"
        rm -f $j.{aux,pdf,pdf,dvi,log,out} 2> /dev/null

    done
    echo "Cleaning ~ files"
    rm -f *~ 2>/dev/null
}

function getkey {
    if [ "$2" == "" ] ; then
        echo "Usage: getkey KEY FILE"
        break
    else
        grep $1 $2 | perl -ane 'print $F[1];'
    fi
}

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

if [ -f ${HOME}/dotfiles/android_bc ] ; then
    source ${HOME}/dotfiles/android_bc
fi

if [ -f ${HOME}/Scripts/rand_tmux_color.rb ] ; then
    export TMUX_HOST_COLOUR=$(${HOME}/Scripts/rand_tmux_color.rb)
fi

alias tmux='TMUX_HOST_COLOUR=$(${HOME}/Scripts/rand_tmux_color.rb) tmux -2'

if [ -n "$(type -t module )" ] ; then
    module load r/3.1
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
