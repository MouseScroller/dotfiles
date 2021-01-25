

complete -cf sudo

BASH_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

for file in "$BASH_HOME"/functions/*.sh
do
	source "$file";
done
file=""


source "$BASH_HOME/settings.sh"

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

RETURN_CODE=0
trap 'RETURN_CODE=$?' ERR

PROMPT_COMMAND='__promt'

function __promt(){

	printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}" # window header
	if [[ "$RETURN_CODE" != "0" ]]
	then
		PS1="${COLOR_RED}${RETURN_CODE}${COLOR_NC}|\t[${COLOR_PURPLE}\h${COLOR_NC}]\u: ${COLOR_LIGHT_CYAN}\w${COLOR_NC} \`parse_git_branch\`${COLOR_NC}\\n\$ "
		RETURN_CODE=0
	else
		PS1="\t[${COLOR_PURPLE}\h${COLOR_NC}]\u: ${COLOR_LIGHT_CYAN}\w${COLOR_NC} \`parse_git_branch\`${COLOR_NC}\\n\$ "
	fi
}

#PATH=/mnt/storage/development/dependency/.npm/bin/:$PATH

source "/usr/share/fzf/completion.bash" 2> /dev/null
source "/usr/share/fzf/key-bindings.bash"

