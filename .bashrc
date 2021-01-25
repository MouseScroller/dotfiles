# ~/.bashrc
source ~/.config/bash/aliases.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.config/bash/init.sh

if [ -f ~/.systemrc ]
then
	source ~/.systemrc
fi

