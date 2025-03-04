# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export XDG_CONFIG_HOME=$HOME/.config

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
##ZSH_THEME="robbyrussell"
#ZSH_THEME="robbyrussell"
ZSH_THEME="dst"
## Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" "candy" "dst" )

alias ztheme='(){ export ZSH_THEME="$@" && source $ZSH/oh-my-zsh.sh }'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=$HOME/.zsh_history
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_FUNCTIONS 
export HISTORY_IGNORE="ls|ll|more *|lless *|history|history *|source .bashrc|clear_last_history|tmux *attach|reboot|restart|sudo*reboot"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

eval $(dircolors -b $HOME/.ls_colors )
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git zshmarks git-prompt virtualenv)
plugins=(git zshmarks git-prompt virtualenv zsh-syntax-highlighting zsh-autosuggestions docker) 
setopt correct
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


bindkey '^G' emacs-forward-word
bindkey '^F' emacs-backward-word
bindkey '^B' backward-kill-word
bindkey '^N' kill-word
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
if [[ -f "$HOME/.bash_stuff/cdargs/cdargs-bash.sh" ]] ; then
    source $HOME/.bash_stuff/cdargs/cdargs-bash.sh
elif [[ -f "/usr/share/doc/cdargs/examples/cdargs-bash.sh" ]] ; then
    source "/usr/share/doc/cdargs/examples/cdargs-bash.sh"
fi

if [[ -f /etc/profile.d/fzf.zsh ]] ; then
    source /etc/profile.d/fzf.zsh
fi

if [[ -f "$HOME/.functions" ]] ; then
    source "$HOME/.functions"
fi
    

if [[ -f /etc/profile.d/fzf-completion.zsh ]] ; then
    source /etc/profile.d/fzf-completion.zsh
fi
NEWLINE=$'\n'
# export PROMPT="
# %(?, ,%{$fg[red]%}FAIL%{$reset_color%}
# )
# %{%{$reset_color%}%{%F{147}%}%m%{$reset_color%} %{$reset_color%}%1d $(git_super_status)
# $(prompt_char) "
#export RPROMPT="%{%F{29}[%*]%}%{$reset_color%}"
#export PROMPT="%(?, ,%{$fg[red]%}FAIL%{$reset_color%}${NEWLINE})${NEWLINE}%{%F{197}%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}: %{$fg_bold[blue]%}%1d%{$reset_color%}$(git_prompt_info)${NEWLINE}%% "
#export RPROMPT="%{%F{29}[%*]%}%{$reset_color%}"
#export RPROMPT="%{$fg[green]%}%*%{$reset_color%}"

function build_prompt_path {
    local PWD_PATH="%~" # This will display the path in a shortened form (like ~/Private/...)
    local URI_PATH=$(/home/jdamon/Scripts/uri $(pwd)) # Use your script to generate the URI for the current directory
    local HYPERLINK="\e]8;;$URI_PATH\a$PWD_PATH\e]8;;\a" # Create hyperlink using the URI
    echo -n "$HYPERLINK"
}


export RPROMPT='%{%F{167}%}%*%{$reset_color%}'
export PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%}${NEWLINE})${NEWLINE}%{%F{197}%}$(virtualenv_info)%{$reset_color%}%{%F{147}%}%m%{$reset_color%}%{$reset_color%} %{%F{255}%}%~%{$reset_color%} $(git_super_status)${NEWLINE}%F{241}%% %F{reset_color}'
#export PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%}${NEWLINE})${NEWLINE}%{%F{197}%}$(virtualenv_info)%{$reset_color%}%{%F{147}%}%m%{$reset_color%}%{$reset_color%} %{%F{255}%}$(build_prompt_path)%{$reset_color%} $(git_super_status)${NEWLINE}%F{241}%% %F{reset_color}'
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_BRANCH="%{%F{35}%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{✚%G%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[blue]%}%{-%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}%{…%G%}"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[blue]%}%{⚑%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%G%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SEPARATOR="->"



function emacs {
         EMACSRUNNING=$(ps -ef |grep emacs | grep -v -P "(emacsclient|grep)" | wc -l)
         if [[ $EMACSRUNNING == 0 ]] ; then
            /usr/bin/emacs "$@"
         else
            emacsclient "$@" >/dev/null 2>&1
         fi       
}

function emacsclient {
    if [[ -S /tmp/emacs1000/server ]] ; then
        export EMACS_SOCKET_NAME=/tmp/emacs1000/server
    fi
    /usr/bin/emacsclient "$@"
}

export LESSOPEN="|  /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS="-X -R"
export LESSCHARSET=utf-8


source /home/jdamon/completion.zsh
source /home/jdamon/key-bindings.zsh

bindkey '^W' kill-region


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
#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#export PATH="/home/jdamon/.cask/bin:$PATH"
export PATH="${PATH}:$HOME/.jlenv/bin"
export PATH=$PATH:$HOME/vcpkg

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin:$HOME/Tools/stockfish/16:"

alias rm='trash'
# Man
export MANPATH=/usr/share/man:/usr/man:/usr/local/share/man


# 
export TOOLSDIR=$HOME/Tools
export MODULEPATH=$HOME/Modules

if [[ -f /usr/share/lmod/lmod/init/zsh ]] ; then
    source /usr/share/lmod/lmod/init/zsh 
fi

if [[ -f $HOME/.alias ]] ; then
    source $HOME/.alias
fi


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

export TEXINPUTS="$HOME/Latex://;"

[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
