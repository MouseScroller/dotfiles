# ~/.bashrc

source $HOME/.config/bash/aliases.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

complete -cf sudo

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $HOME/.config/bash/settings.sh

numlockx

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

source $HOME/.config/bash/functions.sh

export PS1="\t[${COLOR_PURPLE}\h${COLOR_NC}]\u: ${COLOR_LIGHT_CYAN}\w${COLOR_NC} \`parse_git_branch\`${COLOR_NC}\\n\$ "


# Auto-completion
# ---------------
source "/usr/share/fzf/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/share/fzf/key-bindings.bash"
