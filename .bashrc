# ~/.bashrc
source "$HOME"/.config/bash/aliases.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source "$HOME"/.config/bash/init.sh

if [ -f "$HOME"/.systemrc ]
then
	source "$HOME"/.systemrc
fi

