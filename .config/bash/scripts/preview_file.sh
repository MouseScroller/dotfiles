
function calculate_position {
    # TODO costs: creating processes > reading files
    #      so.. maybe we should store the terminal size in a temporary file
    #      on receiving SIGWINCH
    #      (in this case we will also need to use perl or something else
    #      as bash won't execute traps if a command is running)
    < <(</dev/tty stty size) \
        read TERMINAL_LINES TERMINAL_COLUMNS

    case "${PREVIEW_POSITION:-${DEFAULT_PREVIEW_POSITION}}" in
        left|up|top)
            X=1
            Y=1
            ;;
        right)
            X=$((TERMINAL_COLUMNS - COLUMNS - 2))
            Y=1
            ;;
        down|bottom)
            X=1
            Y=$((TERMINAL_LINES - LINES - 1))
            ;;
    esac
}
function draw_preview {
	echo "0 ${0}"
	echo "1 ${1}"
	echo "2 ${2}"
	echo "3 ${4}"
	echo "4 ${5}"
	echo "5 ${6}"
    calculate_position
    >"${1}" declare -A -p cmd=( \
        [action]=add [identifier]="${2}" \
        [x]="${X}" [y]="${Y}" \
        [width]="${COLUMNS}" [height]="${LINES}" \
        [scaler]=fit_contain [scaling_position_x]=0.5 [scaling_position_y]=0.5 \
        [path]="${@}")
}

type=$(file $1)
if [[ $type =~ text ]] || [[ $type =~ JSON ]]
then
	(highlight -O ansi -l -t=4 $1 || cat $1) 2> /dev/null | head -500;
else
	media=$(mediainfo $1 | sed "s/%/%%/g");

	general=$(printf "$media" | rg -U "^General(\n.+)*" | grep -oP "^Complete Name.*|^Format.*|^File size.*|^Duration.*|Overall bit rate.*");
	printf "$general\n";

	if [[ $media =~ Video ]]
	then
		echo "=======> Video"
		video=$(printf "$media" |  rg -U "^Video(\n.+)*" | grep -oP "^Format/Info.*|^Codec ID.*|^Width.*|^Height.*|^Display aspect ratio.*|^Frame rate.*|^Bit depth.*");
		printf "$video\n";
	fi

	if [[ $media =~ Image ]]
	then
		echo "=======> Image"
		image=$(printf "$media" | rg -U "^Image(\n.+)*" | grep -oP "^Format/Info.*|^Width.*|^Height.*|^Bit depth.*");
		printf "$image\n";
		if [[ $2 ]]
		then
			export -f draw_preview
			#draw_preview $1 $2 $3;
		fi
	fi

	if [[ $media =~ Audio ]]
	then
		echo "=======> Audio"
		audio=$(printf "$media" | rg -U "^Audio(\n.+)*" | grep -oP "^Format.*|^Sampling rate.*|^Bit depth.*");
		printf "$audio\n";
	fi
fi

