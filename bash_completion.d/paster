# paster(1) completion
# Copyright 2008 Piotr Ożarowski <piotr@debian.org>

# This script can be distributed under the same license as the
# pastescript or bash packages.

have paster &&
_paster()
{
    local cur prev paster_options commands
    
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}
    paster_options='-h --help -v --version --plugin'
    commands="$(python -c 'from paste.script.command import get_commands; print " ".join(get_commands().keys())' 2>/dev/null)"


    case ${COMP_WORDS[1]} in
	-h|--help|-v|--version)
	    COMPREPLY=()
	    ;;
	help)
	    COMPREPLY=( $( compgen -W "$commands" | grep "^$cur" ) )
	    ;;
	serve)
	    COMPREPLY=( $( compgen -G "${cur}*.ini" -W "$(paster help serve 2>/dev/null | grep -o '\-\{1,2\}[a-zA-Z][-a-zA-Z]*')" | grep "^$cur" ) )
	    ;;
	*)
	    COMPREPLY=( $( compgen -W "$paster_options $commands" | grep "^$cur" ) )
	    ;;
    esac

    return 0

}
[ "$have" ] && complete -F _paster paster
