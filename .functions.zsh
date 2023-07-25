function save { 
    # echo "Number $#"
    if [[  $# -lt  2 ]] ; then
        echo "Usage save TYPE FILE|DIRECTORY"
    else
        for i in {2..$#..1}
        do
            fname="${!i}"
            nname=$(echo "$fname" | perl -ne 's/^(.*)\..*$/$1/g;print;')
            if [[ "$nname" == "$1" ]] ; then
                suffix=""
            else
                suffix=$(echo "$fname" | perl -ne 's/^.*(\..*)$/$1/g;print;')
            fi
            # nname=$(basename "$i" .fen)
            # /bin/cp -f -p  "$i" "$FEN_PUZZLES/${nname}_$(fen_name "$1").fen"
            
            dir=$(grep -P "^$1" $HOME/.cdargs | perl -ne 's/^\S+\s+(\S.*)$/$1/g;print;' 2>/dev/null)
            if [[ -z $dir || $dir == "" ]] ; then
                echo "Can't determing SAVEDIR from '$1'"
            else
                if [[ -d "$fname" ]] ; then
                    /bin/cp -vf -p -r "$fname" "${dir}/${nname}_$(uniq_dir_name "$fname")"
                elif [[ -f "$fname" ]] ; then
                    /bin/cp -vf -p -r "$fname" "${dir}/${nname}_$(fen_name "$fname")${suffix}"
                else
                    echo "Can't find type of file ${fname}"
                fi

            fi
        done
    fi
    # /bin/cp -f -p "$2" ${dir}
}
