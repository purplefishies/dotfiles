if [[ -n "${DOCKER_CONTAINER_NAME}" ]] ; then
    case "$DOCKER_CONTAINER_NAME" in
        "ryo")
            # Config for first Docker container
            export PROMPT_COLOR=37
            export PATH="$PATH:/usr/local/cuda/bin"
            export PATH="$PATH:/usr/lib/lapack"
            export PATH="$PATH:/opt/local/bin"
            export NEWLINE=$'\n'
            ;;
        "myros2")
            # Config for second Docker container
            export PROMPT_COLOR=204
            export PATH="$PATH:/usr/bin"
            export PATH="$PATH:/bin"
            export PATH="$PATH:/usr/local/bin"
            export PATH="$PATH:/opt/local/bin"
            export NEWLINE=$'\n'
            source /opt/ros/humble/setup.zsh 
            ;;

        "aevex")
            # Config for Aevex container
            export NEWLINE=$''
            export PROMPT_COLOR=56
            export PATH="$PATH:/usr/bin"
            export PATH="$PATH:/bin"
            export PATH="$PATH:/usr/local/bin"
            ;;
        *)
            # Default Docker config
            ;;
    esac

elif [[ $(uname) == *CYGWIN* ]] ; then
    export PROMPT_COLOR=147
    export PATH="/cygdrive/c/CMake/bin:/bin:/usr/bin:/usr/local/bin:/usr/sbin:"
    export PATH="$PATH:$HOME/Scripts"
    export PATH="$PATH:/usr/games"
    export PATH="$PATH:/usr/local/cuda/bin"
    export PATH="$PATH:/usr/lib/lapack"
    export PATH="$PATH:/opt/local/bin"
    export PATH="$PATH:/cygdrive/c/Program Files/Go/bin"
    export PATH="$PATH:/cygdrive/c/Users/jdamon/AppData/Local/Programs/Microsoft VS Code"
    export PATH="$PATH:/cygdrive/c/Windows/System32/WindowsPowerShell/v1.0"
    export PATH="$PATH:/cygdrive/c/Users/jdamon/AppData/Local/Programs/mongosh"
    export PATH="$PATH:/cygdrive/c/Program Files/MongoDB/Tools/100/bin"
    export PATH="$PATH:/cygdrive/c/Program Files/usbipd-win"
    export PATH="$PATH:/cygdrive/c/Users/jdamon/AppData/Local/Pandoc"
    export PATH="$HOME/.fzf/bin:$PATH"
    export PATH="$PATH:/cygdrive/c/Users/jdamon/AppData/Local/BeyondCompare4"
    export PATH="$PATH:$(cygpath -u 'C:\Windows\System32')"
    export PATH="$PATH:$(cygpath -u 'C:\Program Files\Docker\Docker\resources\bin')"
    export PATH="$PATH:/cygdrive/c/Program Files/Recoll"
    export PATH="$PATH:/cygdrive/c/Program Files/Recoll"
    export PATH="$PATH:$HOME/vcpkg";
    export PATH="$PATH:$HOME/.cargo/bin";
    export PATH="$PATH:$HOME/.local/bin";
    export PATH="$PATH:$HOME/perl5/bin";
    export PATH="/home/JDamon/Tools/clang+llvm-18.1.8-x86_64-pc-windows-msvc/bin:$PATH"
    export PATH="$HOME/.local/bin:$PATH"                # Needed for pygmentize
    export PYGMENTIZE_STYLE=native
    export PYGMENTIZE_TERMINAL=terminal16m
    export PROMPT_STRING="%m"
    export LESSOPEN="|$HOME/Scripts/lesspipe_pygmentize.sh %s 2>/dev/null"
elif [[ $(uname) == *Linux* ]] ; then
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$VERSION_ID" in
            22.04*) 
                export DISTRO_NAME="ubuntu22" 
                export PROMPT_COLOR=29
                export PYGMENTIZE_TERMINAL=terminal16m
                ;;
            20.04*) 
                export DISTRO_NAME="ubuntu20" 
                export PROMPT_COLOR=44
                export PYGMENTIZE_TERMINAL=terminal16m
                export PROMPT_STRING="t30-dev-%m"
                export PATH="$HOME/.local/bin:$PATH"                # Needed for pygmentize
                ;;
            *)
        esac
    fi
    export PATH="/usr/bin:/usr/sbin:/usr/local/bin:/opt/local/bin:/usr/local/cuda/bin:/usr/games"
    export PATH="$PATH:/mnt/c/Users/jdamon/AppData/Local/Programs/Microsoft VS Code/bin"
    export PATH="$PATH:$HOME/vcpkg";
    export PATH="$PATH:$HOME/Scripts"
    export PATH="$PATH:$HOME/.cargo/bin";
    export PATH="$PATH:$HOME/.local/bin";
    export PATH="$PATH:$HOME/perl5/bin";
    export PATH="$PATH:/usr/local/go/bin";

    export PYGMENTIZE_STYLE=native
    export LESSOPEN="|$HOME/Scripts/lesspipe_pygmentize.sh %s 2>/dev/null"

elif [[ $(uname) == *Darwin* ]] ; then
    # MacOS stuff

fi
