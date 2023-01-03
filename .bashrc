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

# Needed for ssh/ing without running .bashrc commands
[[ $- == *i* ]] || return


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


# Diff Application
export DIFF_APP=bcompare

# Chess
export CHESS_DIR=/media/jdamon/NAS/Chess
export FEN_PUZZLES=${CHESS_DIR}/FenPuzzles
export PGN_GAMES=${CHESS_DIR}/PGNGames

if [[ -d $CHESS_DIR ]] ; then

    if [[ ! -d $FEN_PUZZLES ]] ; then
        mkdir -p $FEN_PUZZLES
    fi

    if [[ ! -d $PGN_GAMES ]] ; then
        mkdir -p $PGN_GAMES
    fi
fi

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Loading functions...
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if [ -f $HOME/.functions ] ; then
    source $HOME/.functions
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
export GRADLE_OPTS="-Dorg.gradle.daemon=true,org.gradle.jvmargs=-Xmx2048M"

# Perl 
export PERLDB_OPTS=HistFile=$HOME/.perldb.hist

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Linux Path stuff
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
export PATH="$PATH:/sbin:/bin:/usr/bin:/usr/local/bin:/usr/sbin:"
export PATH="$PATH:$HOME/Scripts"
export PATH="$PATH:/usr/games"
export PATH="$PATH:/usr/local/cuda/bin"
export PATH="$PATH:/usr/lib/lapack"
export PATH="$PATH:/opt/local/bin"
export PATH="$PATH:$HOME/Tools/bin"

# Android stuff
export PATH=$PATH:$ANDROID_SDK/platform-tools
export PATH=$PATH:$ANDROID_NDK_HOME
export PATH=$PATH:$SDK_ROOT/tools/
export PATH=$PATH:/opt/local/lib/mysql5/bin
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/home/jdamon/.cask/bin:$PATH"
export PATH="${PATH}:$HOME/.jlenv/bin"




# bash completion 
if [[ -f "/etc/bash_completion" ]] ; then
    source "/etc/bash_completion"
fi

if [[ -f "/usr/share/bash-completion/bash_completion" ]] ; then
    source "/usr/share/bash-completion/bash_completion"
fi

if [[ -f "$HOME/.bash_stuff/modules/init/bash" ]] ; then
    source "$HOME/.bash_stuff/modules/init/bash"
fi

if [[ -f "$HOME/.bash_stuff/cdargs/cdargs-bash.sh" ]] ; then
    source $HOME/.bash_stuff/cdargs/cdargs-bash.sh
elif [[ -f "/usr/share/doc/cdargs/examples/cdargs-bash.sh" ]] ; then
    source "/usr/share/doc/cdargs/examples/cdargs-bash.sh"
fi

if [[ -f "/etc/bash_completion" ]] ; then
    source /etc/bash_completion
else
    echo "Can't find file /etc/bash_completion to source...please install" >> $HOME/bash_errors.log
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


TITLEBAR="\[\033]0;\u@\H: \w\007\]"
LONG_PROMPT=$TITLEBAR
MYGREEN=$(printf "\033[38;5;42m\n")
if [[ -f /.dockerenv ]] || grep -Eq '(lxc|docker)' /proc/1/cgroup; 
then 
    LONG_PROMPT=${LONG_PROMPT}'\[$MYGREEN\](docker-\h)\[$RESET\] \W '
else
    LONG_PROMPT="${LONG_PROMPT}\h \W"
fi

if [[ "$(type -t __svn_ps1 )" == "function" ]] ; then
    LONG_PROMPT=${LONG_PROMPT}${SVN_COLOR}'$(__svn_ps1)'
    SHORT_PROMPT=${SHORT_PROMPT}${SVN_COLOR}'$(__svn_ps1)'
else
    echo "Can't find definition for __svn_ps1" >> $HOME/bash_errors.log
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
    echo "Can't find definition for __git_ps1...ignoring" >> $HOME/bash_errors.log
    LONG_PROMPT=${LONG_PROMPT}'\[$RESET\]% '
    SHORT_PROMPT=${SHORT_PROMPT}'\[$RESET\]% '
    STEALTH_PROMPT=${STEALTH_PROMPT}'\[$RESET\]% '
    tty -s && export PS1=$LONG_PROMPT
fi

# LS colors 
if [ -f "$HOME/.ls_colors" ] ; then
    eval $( dircolors -b $HOME/.ls_colors )
else
    export LS_COLORS="no=00:fi=00:di=00;36:*.pdf=01;33:ln=01;36:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;21;01:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.svgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.dz=00;31:*.gz=00;31:*.bz2=00;31:*.tbz2=00;31:*.bz=00;31:*.tz=00;31:*.deb=00;31:*.rpm=00;31:*.jar=01;32:*.rar=00;31:*.ace=00;31:*.zoo=00;31:*.cpio=00;31:*.7z=00;31:*.rz=00;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=01;35:*.mng=00;35:*.pcx=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.m2v=00;35:*.mkv=00;35:*.ogm=00;35:*.mp4=00;35:*.m4v=00;35:*.mp4v=00;35:*.vob=00;35:*.qt=00;35:*.nuv=00;35:*.wmv=00;35:*.asf=00;35:*.rm=00;35:*.rmvb=00;35:*.flc=00;35:*.avi=00;35:*.fli=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.yuv=00;35:*.svg=00;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:"
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
export HISTIGNORE="ls:ll:more *:lless *:history:history *:source .bashrc:clear_last_history:tmux *attach:reboot:restart:sudo*reboot"
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

export DEFAULT_TIMEOUT=2
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
    
    if [[ $(type -t timeout3) == "file" ]]
    then
       eval $(timeout3 -d 0 -i 0.1 -t ${DEFAULT_TIMEOUT} git_stats.rb)
    fi
}
export PROMPT_COMMAND="rollover_history"

# Load the old history
history -n 


# Pager configuration
export PAGER=less
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s "
export LESS="-X -R"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESSCHARSET=utf-8

# Ack 
export ACK_PAGER="less"

# Ruby ri command
export RI="--format ansi --width 100"

# Man
export MANPATH=/usr/share/man:/usr/man:/usr/local/share/man


export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}
export SDK_ROOT=/Developer/SDKs/android-sdk-mac_86

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

if [ -f ${HOME}/dotfiles/android_bc ] ; then
    source ${HOME}/dotfiles/android_bc
fi

if [[ -f $HOME/.local_bash ]] ;  then
    source $HOME/.local_bash
fi

if [ -f ${HOME}/Scripts/rand_tmux_color.rb ] ; then
    export TMUX_HOST_COLOUR=$(${HOME}/Scripts/rand_tmux_color.rb)
fi



alias ack='/usr/bin/ack-grep'
alias aack='/usr/bin/ack-grep --color'

if [[ -f "$HOME/.emacs.d/key-bindings.el" ]] ; then
    EXTRA=" --eval '(load-file  (concat (getenv \"HOME\") \"/.emacs.d/bash-edit.el\"))' "
else 
    EXTRA=""
fi

if [ "$DISPLAY" ] ; then
    export EDITOR="$(which emacs) ${EXTRA} -q -nw "
    export ALTERNATE_EDITOR="emacs -q "      
    export VISUAL="$(which emacs) ${EXTRA} -q -nw "
else 
    export ALTERNATE_EDITOR=""      
    export EDITOR="$(which emacs) ${EXTRA} -q -nw "
    export VISUAL="$(which emacs) ${EXTRA} -q -nw "
fi

export TEXINPUTS="$HOME/Latex://;"

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

function virtualenv_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && echo -ne "(venv:$venv) "
}

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1
VENV="\$(virtualenv_info)";

export LONG_PROMPT="${VENV}${LONG_PROMPT}"
export PS1=${LONG_PROMPT}

if [ -n "$(type -t cprompt 2>/dev/null)" ] && [ "$(type -t cprompt 2>/dev/null)" = function ]
then 
    cprompt devel
fi
export MODULEPATH=$HOME/Modules

# Tmux refresh environment
if [ -n "$TMUX" ]; then
    function refresh {
        export $(tmux show-environment | grep "^SSH_AUTH_SOCK")  > /dev/null 2>&1
        export $(tmux show-environment | grep "^DISPLAY")  > /dev/null 2>&1
        export $(tmux show-environment | grep "^DBUS_SESSION_BUS_ADDRESS")  > /dev/null 2>&1
        export $(tmux show-environment | grep "^GPG_AGENT_INFO" )  > /dev/null 2>&1
        export $(tmux show-environment | grep "^GNOME_KEYRING_CONTROL" ) > /dev/null 2>&1
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
        rm -f $j.{aux,pdf,pdf,dvi,log,out,bib} 2> /dev/null

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


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/jdamon/.sdkman"
[[ -s "/home/jdamon/.sdkman/bin/sdkman-init.sh" ]] && source "/home/jdamon/.sdkman/bin/sdkman-init.sh"


alias developer-dev="docker run -v $HOME/catkin_ws/src/:/home/developer/catkin_ws/src -w /home/developer/catkin_ws/ -u developer -it docker.cloudsmith.io/automodality/dev/amros-melodic:latest"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash



