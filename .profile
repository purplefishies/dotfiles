# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login

export HOME=/home/jdamon
export PATH="$HOME/.rvm/bin:/usr/bin:/bin:/sbin:/usr/games:$HOME/Scripts" # Add RVM to PATH for scripting
eval $(rvm env )


# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

#echo "$(/home/jdamon/Scripts/rquestions.rb  ${HOME}/Projects/Learning/ThingsToLearn.tex )" 
#fortune | fold  -w 50 -s  | cowsay -f tux -n | lolcat -t -p 2

fortune $(/bin/ls -d ~/Dropbox/Quotes.txt /usr/share/games/fortunes | sort -R | head -1) | fold  -w 50 -s  | cowsay -f tux -n | lolcat -t -p 2

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting



[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
