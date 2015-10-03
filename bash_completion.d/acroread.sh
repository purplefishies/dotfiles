# _filedir : to handle file and directories with spaces in their names.
if ! type _filedir &> /dev/null ; then

_filedir()
{
	local IFS=$'\t\n' xspec #glob

	#glob=$(set +o|grep noglob) # save glob setting.
	#set -f		 # disable pathname expansion (globbing)

	xspec=${1:+"!*.$1"}	# set only if glob passed in as $1
	COMPREPLY=( ${COMPREPLY[@]:-} $( compgen -f -X "$xspec" -- "$cur" ) \
		    $( compgen -d -- "$cur" ) )
	#eval "$glob"    # restore glob setting.
}
fi

_acroread()
{
  	local cur prev opts files
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	#prev="${COMP_WORDS[COMP_CWORD-1]}"
	first="${COMP_WORDS[1]}"
	#
	#  The basic options we'll complete.
	#
	opts="--display --screen --sync -geometry -help -man -iconic -setenv -tempFile -tempFileTitle -toPostScript -openInNewWindow -installCertificate -v -version"

	#
	#  Complete the arguments to some of the basic commands.
	#
	case "${first}" in
	-toPostScript)
	if [[ "${cur}" == -* ]]; then
	local running="-binary -start -end -pairs -optimizeForSpeed -landscape -reverse -odd -even -commentsOff -annotsOff -stampsOff -markupsOn -level2 -level3 -printerhalftones -saveVM -size -shrink  -expand -transQuality -printerName -nUp -booklet -rotateAndCenter -choosePaperByPDFPageSize"
	COMPREPLY=( $(compgen -W "${running}" -- "${cur}") )
	return 0
	fi
	;;

	-installCertificate)
	if [[ "${cur}" == -* ]]; then
	  if [ $COMP_CWORD -eq 2 ]; then
	    local running="-PEM -DER"
	    COMPREPLY=( $(compgen -W "${running}" -- "${cur}") )
	    return 0
	  fi
	fi
	;;

	*)
	;;
	esac


	if [[ "${cur}" == -* ]] ; then
	  COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))  
	  return 0
	fi

	if [ $COMP_CWORD -eq 1 -o "${COMPREPLY+set}" != "set" ]; then
        _filedir '[pP][dD][fF]'
	fi

}
complete -o filenames -o nospace -F _acroread acroread
