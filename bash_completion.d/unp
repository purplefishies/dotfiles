# bash completion for unp

have unp &&
_unp()
{
    local cur
    COMPREPLY=()
    cur="$(_get_cword)"
    case "$cur" in
        -*)
        COMPREPLY=( $( compgen -W '-u' -- "$cur" ) )
        ;;
        *)
            _filedir '@(zip|ZIP|jar|JAR|exe|EXE|pk3|war|wsz|ear|zargo|xpi|Z|gz|tgz|Gz|dz|lha|LHa|lhz|deb|ar|bz2|tbz2|rpm|shar|rar|arj|cab|ace|tnef|uu|mime|hqx|sea|zoo|pmd|cpio|afio|lzop|tar|lz|xz|lzma)'
        ;;
    esac
    return 0
} &&
complete -F _unp $filenames unp

