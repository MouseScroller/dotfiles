#!/bin/bash
function is_option_key [[ "${@}" =~ ^(\-.*|\+.*) ]]
function is_key_value [[ "${@}" == *=* ]]


declare -r BASH_BINARY="$(which bash)"
declare -r REDRAW_COMMAND="toggle-preview+toggle-preview"
declare -r REDRAW_KEY="µ"
declare -r DEFAULT_PREVIEW_POSITION="right:60%:wrap"


function preview(){

	local UEBERZUG_FIFO="$(mktemp --dry-run --suffix "fzf-$$-ueberzug")"
	local PREVIEW_ID="preview$UEBERZUG_FIFO"

	trap finalise EXIT
	parse_options "${@}"
	start_ueberzug
	export -f draw_preview calculate_position

	#fzf --preview "preview_file {}" \

        fzf --preview "preview_file {}" \
		--preview-window "${DEFAULT_PREVIEW_POSITION}" \
		--bind "${REDRAW_KEY}:${REDRAW_COMMAND}" \
		--bind "enter:execute(xdg-open {} 2>/dev/null)" "${@}"
}


function preview_file {

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
		fi

		if [[ $media =~ Audio ]]
		then
			echo "=======> Audio"
			audio=$(printf "$media" | rg -U "^Audio(\n.+)*" | grep -oP "^Format.*|^Sampling rate.*|^Bit depth.*");
			printf "$audio\n";
		fi
	fi
}



function map_options {
    local -n options="${1}"
    local -n options_map="${2}"

    for ((i=0; i < ${#options[@]}; i++)); do
        local key="${options[$i]}" next_key="${options[$((i + 1))]:---}"
        local value=true
        is_option_key "${key}" || \
            continue
        if is_key_value "${key}"; then
            <<<"${key}" \
                IFS='=' read key value
        elif ! is_option_key "${next_key}"; then
            value="${next_key}"
        fi
        options_map["${key}"]="${value}"
    done
}


function parse_options {
    declare -g -a script_options=("${@}")
    declare -g -A mapped_options
    map_options script_options mapped_options
    declare -g -x PREVIEW_POSITION="${mapped_options[--preview-window]%%:[^:]*}"
}


function start_ueberzug {
    mkfifo "${UEBERZUG_FIFO}"
    <"${UEBERZUG_FIFO}" \
        ueberzug layer --parser bash --silent &
    # prevent EOF
    3>"${UEBERZUG_FIFO}" \
        exec
}


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
	echo $1
    calculate_position
    >"${UEBERZUG_FIFO}" declare -A -p cmd=( \
        [action]=add [identifier]="${PREVIEW_ID}" \
        [x]="${X}" [y]="${Y}" \
        [width]="${COLUMNS}" [height]="${LINES}" \
        [scaler]=fit_contain [scaling_position_x]=0.5 [scaling_position_y]=0.5 \
        [path]="${@}")
        # add [synchronously_draw]=True if you want to see each change
}

function finalise {
	echo $UEBERZUG_FIFO
	3>&- exec
	&>/dev/null rm "${UEBERZUG_FIFO}"
	&>/dev/null kill $(jobs -p)
}


