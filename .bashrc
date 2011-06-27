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


#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Variables that I use for configuring my setup.
# 1. Why use Sed ... when Perl is available ??
#
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

PERL="/opt/local/bin/perl"
MY_OS=`uname -s`
MY_TEST="test"

MY_ID=`/usr/bin/id | /opt/local/bin/perl -ne 's/^\S+=\d+\((\S+?)\).*/$1/; print;'`
my_version_num=`echo $BASH_VERSION | /opt/local/bin/perl -ne 's/^(\d+)\..*/$1/; print ; '`
MY_CAD="${HOME}/Scripts/CAD"
BASH_VRS=`echo $BASH_VERSION | sed 's/^\([0-9]\)\..*/\1/'`
ECHO="/usr/local/bin/echo"

WHITE=$(tput setaf 7 )
RED=$(tput setaf 1 )
GREEN=$(tput setaf 2 )
RESET=$(tput sgr0 )
BOLD=$(tput bold)


if [ 1 ] ; then
# Before
    MY_PROMPT='$RED\h ${WHITE}\w % '
else 
    MY_PROMPT="${RED}\h ${WHITE}\w % "
fi


LONG_PROMPT='\[$RED\]\h \[$RESET\]\w \[$GREEN$BOLD\]$(__git_ps1 "(%s)")\[$RESET\]% '
SHORT_PROMPT='\[$RED\]\h \[$RESET\]\W \[$GREEN$BOLD\]$(__git_ps1 "(%s)")\[$RESET\]% '

export PS1="${RED}\h \w ${WHITE} % "


unset path_string




# Loading functions...
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

source $HOME/.functions

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Loading Aliases....
#
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

if [ "${HOME}/.alias" -nt "${HOME}/.bash_alias" ] ; then
    if [ -f "${HOME}/.bash_alias" ]; then
        rm "${HOME}/.bash_alias"
    fi
    ldalias "${HOME}/.alias"
elif [ -f "${HOME}/.bash_alias" ]; then
    source ${HOME}/.bash_alias >&1 >/dev/null
else
    ldalias "${HOME}/.alias"
fi

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 
# Setting up the PATH environment and Environmental variables
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

test -f ${HOME}/.env && ldenv ${HOME}/.env



sprompt

export SWIFT_MDIR=/Users/jdamon/p4/depot/SQA/nSWIFT/
export TQTEST_MDIR=/Users/jdamon/p4/depot/SQA/TQTEST/


#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Clearing temporary variables
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
unset lowos

alias hsp='/cad/avanti/2003.03-SP1/linux/hspice'



export PATH="/usr/firefox:"
#export PATH="$PATH:/usr/java/jdk1.5.0_12/bin"
#export JAVA_HOME="/usr/java/jdk1.5.0_12"
#export JAVA_HOME="/usr/java/jdk1.6.0_02"
export GROOVY_HOME="/usr/java/groovy-1.0"
#export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$GROOVY_HOME/bin:$PATH"
export PATH=$PATH:/usr/java/jswat-4.2/bin
export PATH=$PATH:/usr/local/lib/xcircuit-3.4/man//
export PATH=$PATH:/usr/local/root/bin
#export PATH=$PATH:/Library/PostgreSQL/8.4/bin
export PATH=$PATH:/usr/local/pgsql/bin/
export PATH=$PATH:$HOME/Scripts


export PATH=$PATH:"/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/sw/bin:/usr/X11R6/bin:/Library/PostgreSQL/bin:/usr/lib/lapack:"

export PATH="$PATH:/usr/lib/lapack"
export PATH="$PATH:/opt/local/bin"
export PATH="$PATH:/System/Library/Frameworks/Python.framework/Versions/2.6/bin"
export PATH="$PATH:/Developer/Tools/Qt"

#
# Pager configuration
#
export PAGER=less
export LESS=-X


export LS_COLORS="no=00:fi=00:di=00;36:*.pdf=01;33:ln=01;36:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.svgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.dz=00;31:*.gz=00;31:*.bz2=00;31:*.tbz2=00;31:*.bz=00;31:*.tz=00;31:*.deb=00;31:*.rpm=00;31:*.jar=01;32:*.rar=00;31:*.ace=00;31:*.zoo=00;31:*.cpio=00;31:*.7z=00;31:*.rz=00;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=01;35:*.mng=00;35:*.pcx=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.m2v=00;35:*.mkv=00;35:*.ogm=00;35:*.mp4=00;35:*.m4v=00;35:*.mp4v=00;35:*.vob=00;35:*.qt=00;35:*.nuv=00;35:*.wmv=00;35:*.asf=00;35:*.rm=00;35:*.rmvb=00;35:*.flc=00;35:*.avi=00;35:*.fli=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.yuv=00;35:*.svg=00;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:"

export LSCOLORS="Exfxcxdxbxegedabagacad"


#source settings.sh
#source $HOME/.bash_stuff/

source $HOME/.bash_stuff/cdargs/cdargs-bash.sh
source /etc/bash_completion

histdir=$HOME/.hist
if [[ ! -d $histdir ]]  ; then
    mkdir -p $histdir
fi

export HISTFILESIZE=10000
export HISTSIZE=5000
export HISTFILE=$HOME/.bash_history
export HISTCONTROL="ignoredups:erasedups"
export HISTIGNORE="mark*:ls:ll:history:history *:source .bashrc"
#export HIST_START=$(date '+%H%M%S')
shopt -s histappend
export PROMPT_COMMAND="history -a"

# Load the old history
history -n 

#if [ -f ${histdir}/histfile.$PPID ] ; then
#    export HISTFILE=${histdir}/histfile.$PPID
#else 
#    export HISTFILE=${histdir}/histfile.$$
#fi

export EDITOR=emacs
export PGDATA=$HOME/PostgreSQL
export R_HOME=/usr/lib/R

export CLASSPATH="/Developer/SDKs/android-sdk-mac_86/platforms/android-8/android.jar:"
export CLASSPATH="${CLASSPATH}:/usr/share/java/junit-4.6/junit.jar"


if [ -f /tools/mxlcad/gnutools/etc/bash_completion ] ; then
  . /tools/mxlcad/gnutools/etc/bash_completion
fi

export MANPATH=/opt/local/man:$MANPATH:/opt/n1ge6/man:/usr/man
export MANPATH=$MANPATH:/Library/Frameworks/R.framework/Versions/2.12/Resources
export LESS=-X
export LC_ALL="C"
export LESSCHARSET=utf-8

stty eof ""

export RI="--format ansi --width 100"

export SVN_EDITOR=xemacs


if [ -d $HOME/.bash ] ; then
    for i in `/bin/ls $HOME/.bash/*.sh` ; do
        . $i
    done
fi



export PERL6LIB=$HOME/Programming/Perl/lib:/tools/mxlcad/CPAN/lib/perl5/site_perl:/tools/mxlcad/CPAN/lib/perl5/5.8.5:/tools/mxlcad/CPAN/lib:/tools/mxlcad/Perl:/tools/mxlcad/CPAN/:/tools/mxlcad/tools/share/filepp/modules:/tools/mxlcad/cadtools/lib/:

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

export GREP_OPTIONS="--color=auto"
export SDK_ROOT=/Developer/SDKs/android-sdk-mac_86
export PATH=$PATH:$SDK_ROOT/tools/
export PATH=$PATH:/opt/local/lib/mysql5/bin


export MODULEPATH=/Users/jdamon/Dropbox/SysAdmin/Modules
MODULEHOME=/Users/jdamon/Dropbox/SysAdmin/Modules
if [ -f /Users/jdamon/Dropbox/SysAdmin/tcl/init/bash.sh ] ; then
    source /Users/jdamon/Dropbox/SysAdmin/tcl/init/bash.sh
fi

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

if [ -f /opt/local/etc/profile.d/cdargs-bash.sh ]; then
    source /opt/local/etc/profile.d/cdargs-bash.sh
fi

export PERL5LIB="${HOME}/perl5/lib/perl5:${HOME}"
export GIT_EXTERNAL_DIFF=/opt/local/bin/opendiff.sh

#export PATH

alias prove='/usr/bin/prove.bak'