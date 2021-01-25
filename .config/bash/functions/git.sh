
# get current branch in git repo
function parse_git_branch() {
	BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=$(parse_git_status)
		echo "[${BRANCH}${STAT}]"
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
			first=1
			for(i in f){
				if(i == " "){
					continue
				}
				if(first){
					printf " "
					first=0
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

