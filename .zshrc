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
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=$HOME/.zsh_history

export HISTTIMEFORMAT="[%F %T] "

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_FUNCTIONS 
export HISTFILESIZE=1000000000
export HISTCONTROL=ignorespace
export HISTSIZE=1000000000
export HISTORY_IGNORE="ls*|ll*|more *|fortune|lless *|pwd|history|history *|source .bashrc|clear_last_history|tmux *attach|reboot|restart|sudo*reboot|ssh"

export MODULEPATH=$HOME/Modules

if [[ -f  $HOME/Tools/Modules/init/zsh ]] ; then
    source $HOME/Tools/Modules/init/zsh
fi

if [[ -f $HOME/.alias ]] ; then
    source $HOME/.alias
fi


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

eval $(dircolors -b $HOME/.ls_colors )
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#export GIT_PROMPT_MODE="OLD"
export GIT_PROMPT_MODE="NEW"

if [[ "${GIT_PROMPT_MODE}" == "OLD" ]] ; then
    plugins=(git git-prompt virtualenv zshmarks)
else 
    if [[ -n $(command -v fzf) ]] ; then
        echo "fzf found, loading oh-my-zsh fzf plugin"
        plugins=(git virtualenv fzf zshmarks zsh-autosuggestions docker)
    else
        echo "no fzf was found in the path"
        plugins=(git virtualenv zshmarks zsh-autosuggestions docker)
    fi
fi

setopt correct
source $ZSH/oh-my-zsh.sh
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; 
export PERL5LIB;

if [[ -f /.dockerenv ]] ; then
   echo -ne ""
   export PATH="$PATH:/usr/share/cmake-3.28.0-rc1-linux-aarch64/bin"
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


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
export TEXINPUTS="$HOME/Latex://;"
if [[ -f "$HOME/.bash_stuff/cdargs/cdargs-bash.sh" ]] ; then
    source $HOME/.bash_stuff/cdargs/cdargs-bash.sh
elif [[ -f "/usr/share/doc/cdargs/examples/cdargs-bash.sh" ]] ; then
    source "/usr/share/doc/cdargs/examples/cdargs-bash.sh"
fi
if [[ -f $HOME/.bash_alias  ]] ; then
    source $HOME/.bash_alias
fi

NEWLINE=$'\n'

if [[ "${GIT_PROMPT_MODE}" == "OLD" ]] ; then
    export RPROMPT='%{%F{167}%}%*%{$reset_color%}'
    export PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%}${NEWLINE})${NEWLINE}%{%F{197}%}$(virtualenv_prompt_info)%{$reset_color%}%{%F{147}%}%m%{$reset_color%}%{$reset_color%} %{%F{255}%}%1d%{$reset_color%} $(git_super_status)${NEWLINE}%F{241}%% %F{reset_color}'

else
    docker_command_name="docker"
    if ! docker_loc="$(type -p "$docker_command_name")" || [[ -z $docker_loc ]]; then
        if [[ -z $DOCKER_CONTAINER_NAME ]] ; then
            export DOCKER_CONTAINER_NAME="docker"
        fi
        DOCKERPROMPT="%{$reset_color%}%{%F{23}%}🐳:${DOCKER_CONTAINER_NAME} %F{reset_color}"
        unsetopt HIST_SAVE_BY_COPY
    else
        nodocker=1
        DOCKERPROMPT=""
    fi
    export TERM=xterm-256color
    export RPROMPT='%{%F{167}%}%*%{$reset_color%}'
    export PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%}${NEWLINE})${NEWLINE}%{%F{197}%}${DOCKERPROMPT}$(virtualenv_prompt_info)%{$reset_color%}%{%F{147}%}%m%{$reset_color%}%{$reset_color%} %{%F{255}%}%1d%{$reset_color%} $(gitprompt)${NEWLINE}%F{241}%% %F{reset_color}'
    export ZSH_GIT_PROMPT_SHOW_STASH=1
    export ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[blue]%}✚"
fi

if [[ -f $HOME/.bash_cygwin ]] ; then
    source $HOME/.bash_cygwin
fi

if [[ -f $HOME/.bash_work ]]
then
    source $HOME/.bash_work
fi

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
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[yellow]%}%{⚑%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%G%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SEPARATOR="->"

#source $HOME/completion.zsh
#source $HOME/key-bindings.zsh
#bindkey '^[[A' fzf-history-widget
#bindkey "^A" beginning-of-line
#bindkey "^[A" accept-and-hold
#bindkey "^[OA" up-line-or-beginning-search
#bindkey "^[[1;2A" up-line-or-history
bindkey '^W' kill-region

export XDG_CONFIG_HOME=$HOME/.config

if [[ -f $HOME/.functions ]] 
then
    source $HOME/.functions
fi
