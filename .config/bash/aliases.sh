
if [ -x /usr/bin/colormgr ]; then

	alias grep="grep --color=auto"
	alias ls="ls --color=auto"

	export COLOR_NC='\e[0m' # No Color
	export COLOR_WHITE='\e[1;37m'
	export COLOR_BLACK='\e[0;30m'
	export COLOR_BLUE='\e[0;34m'
	export COLOR_LIGHT_BLUE='\e[1;34m'
	export COLOR_GREEN='\e[0;32m'
	export COLOR_LIGHT_GREEN='\e[1;32m'
	export COLOR_CYAN='\e[0;36m'
	export COLOR_LIGHT_CYAN='\e[1;36m'
	export COLOR_RED='\e[0;31m'
	export COLOR_LIGHT_RED='\e[1;31m'
	export COLOR_PURPLE='\e[0;35m'
	export COLOR_LIGHT_PURPLE='\e[1;35m'
	export COLOR_BROWN='\e[0;33m'
	export COLOR_YELLOW='\e[1;33m'
	export COLOR_GRAY='\e[0;30m'
	export COLOR_LIGHT_GRAY='\e[0;37m'
fi

if ! type fd 1>/dev/null; then
	alias fd=fdfind
fi

alias igrep="grep --ignore-case"
alias pgrep='ps -ef | grep -v grep | grep'

alias more=less
alias cls=clear
alias cd..="cd .."
alias cd...="cd ../.."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias calc="bc -l"
alias ll="ls -lhA"
alias e='nvim'
alias log='less +F'
alias cp='cp -i'
export LANG="en_US.UTF-8"

alias fix_screen='xrandr --output DP-0 --primary --pos 0x0 --mode 2560x1440 --left-of HDMI-0 --output HDMI-0 --pos 2560x360 --mode 1920x1080 --verbose'

export FZF_DEFAULT_OPTS=' --tiebreak=end'

export FZF_DEFAULT_COMMAND="fd -L --type file"

#bash
HISTCONTROL=erasedups:ignorespace:ignoredups
HISTFILE=~/.config/bash/.bash_history
HISTSIZE=-1
HISTFILESIZE=-1
#less
export LESSHISTFILE=/dev/null

HISTIGNORE="celluloid *:vlc *:media_compress *:rm *:view_shutdown *:du -sh:vcut *:mp4_download *:mp3_download *:touch:mkdir:?:??:???"

export DOWNLOADS=/mnt/storage/downloads/

