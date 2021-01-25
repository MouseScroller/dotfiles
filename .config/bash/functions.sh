
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $DIR/functions/preview.sh
source $DIR/functions/view_shutdown.sh

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits="${COLOR_BROWN}>${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="${COLOR_YELLOW}*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="${COLOR_GREEN}+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="${COLOR_CYAN}?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="${COLOR_RED}x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="${COLOR_CYAN}!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo -e " ${bits}${COLOR_NC}"
	else
		echo ""
	fi
}

