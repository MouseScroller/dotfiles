
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

for file in $DIR/functions/*
do
	source $file;
done

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_status`
		echo "[${BRANCH} ${STAT}]"
	else
		echo ""
	fi
}

function parse_git_status {
	git status -s --porcelain=v1 2>/dev/null |
	awk '{
			char1 = substr($0,1,1)
			if(f[char1]["r"]==0 && f[char1]["a"]==0 && char1 != " "){
				f[char1]["a"] = 1
				f[char1]["r"] = 0
			} else if(char1 != " ") {
				f[char1]["a"]++
			}
			char2 = substr($0,2,1)
			if(f[char2]["r"]==0 && f[char2]["a"]==0 && char2 != " "){
				f[char2]["a"] = 0
				f[char2]["r"] = 1
			} else if (char2 != " ") {
				f[char2]["r"]++
			}
		}
		END{
			for(i in f){
				if(i == " "){
					continue
				}
				#print "["i"]" " A:"f[i]["a"] " R:"f[i]["r"]
				if(i == "?"){
					printf "\033[36m"i f[i]["a"]
				} else if(f[i]["a"] > 0 && f[i]["r"] > 0){
					printf "\033[36m"i f[i]["a"]+f[i]["r"]
				} else if(f[i]["a"] > 0 && f[i]["r"] == 0){
					printf "\033[32m"i f[i]["a"]
				} else if(f[i]["a"] == 0 && f[i]["r"] > 0){
					printf "\033[31m"i f[i]["r"]
				}
			}
		printf "\033[0m"
		}
	'
}

# get current status of git repo
function parse_git_dirty {
	status=$(git status 2>/dev/null)
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

