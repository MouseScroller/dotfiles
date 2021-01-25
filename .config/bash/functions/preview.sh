#!/bin/bash
function is_option_key [[ "${@}" =~ ^(\-.*|\+.*) ]]
function is_key_value [[ "${@}" == *=* ]]


declare -r BASH_BINARY="$(which bash)"
declare -r REDRAW_COMMAND="toggle-preview+toggle-preview"
declare -r REDRAW_KEY="µ"
declare -r DEFAULT_PREVIEW_POSITION="right:60%:wrap"


function preview(){

	#local UEBERZUG_FIFO="$(mktemp --dry-run --suffix "fzf-$$-ueberzug")"
	#local PREVIEW_ID="preview$UEBERZUG_FIFO"

	#trap finalise EXIT
	#start_ueberzug
    #parse_options "${@}"

	if [ -n "$1" ]; then
		$HOME/.config/bash/scripts/preview_file.sh "$1"
	else
		fzf --preview "$HOME/.config/bash/scripts/preview_file.sh {} $UEBERZUG_FIFO $PREVIEW_ID" \
			--preview-window "${DEFAULT_PREVIEW_POSITION}" \
			--bind "${REDRAW_KEY}:${REDRAW_COMMAND}" \
			--bind "enter:execute(xdg-open {} 2>/dev/null)+accept" \
			"${@}"
	fi
}

function is_option_key [[ "${@}" =~ ^(\-.*|\+.*) ]]
function is_key_value [[ "${@}" == *=* ]]

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

function finalise {
	echo $UEBERZUG_FIFO
	3>&- exec
	&>/dev/null rm "${UEBERZUG_FIFO}"
	&>/dev/null kill $(jobs -p)
}


