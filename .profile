# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login

export PATH="$HOME/.rvm/bin:/usr/bin:/bin:/sbin:" # Add RVM to PATH for scripting
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

echo "$(/home/jdamon/Scripts/rquestions.rb  ${HOME}/Projects/Learning/ThingsToLearn.tex )" | fold  -w 50 -s  | cowsay -f tux -n | lolcat

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


