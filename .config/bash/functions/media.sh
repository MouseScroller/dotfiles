function sound_length () {

	folder="0"
	for var in "$@"
	do
		if [ "--folder" == "$var" ]; then
			folder="1"
		fi
	done

	for file in *;
	do
		if [ -f "$file" ] || { [ "$folder" == "1" ] && [ -d "$file" ]; }; then

			time=$(media_length "$file")

			if [[ "$time" != "0" ]]; then
				len=$(echo "scale=3 ; $time/60" | bc -l)
				echo -e "$len min\t $(du -sh "$file")"
			fi
		fi
	done
}

function media_length () {

	if [ -f "$1" ]; then
		time=$(ffprobe -i "$1" -show_format -v quiet | sed -n "s/duration=//p")
	elif [ -d "$1" ]; then
		time=0
		for f in "$1"/*;
		do
			if [ -f "$f" ]; then
				t=$(ffprobe -i "$f" -show_format -v quiet | sed -n "s/duration=//p")
				if [[ "$t" != "" ]] && [[ "$t" != "N/A" ]]; then
					time=$(bc <<< "$time+$t")
				fi
			fi
		done
	fi

	if [[ "$time" != "" ]] && [[ "$time" != "N/A" ]]; then
		echo "${time//\.[0-9]*/}"
	else
		echo "0"
	fi
}

function vcut(){

	if [[ -z "$2" ]]; then
		echo "requires at least two args (file) (start) (end)"
		return 1
	fi

	local file="$1"
	local start="$2"
	local end=""

	if [ ! -f "$file" ]; then
		echo "$file no found"
		return 1
	fi

	if [[ -n "$3" ]]; then
		end="-to $3"
	fi

	local filename=$(basename -- "$file")
	local extension="${filename##*.}"
	local file_copy="/tmp/$file.tmp.$extension"

	du -sh "$file"

	ffmpeg -ss "$start" $end -i "$file" -c copy "$file_copy" 2>/dev/null

	if [[ "$?" == "0" ]]; then
		mv "$file_copy" "$file"
	else
		echo "Cut failed"
	fi

	du -sh "$file"
}

function media_compress(){

	if [[ -z "$1" ]]; then
		echo "requires at least one arg (file)"
		return 1
	fi

	for var in "$@"
	do
		local file="$var"

		if [ ! -f "$file" ]; then
			echo "$file no found"
			return 1
		fi

		local filename=$(basename -- "$file")
		local extension="${filename##*.}"
		local file_copy="/tmp/$file.tmp.$extension"


		du -sh "$file"

		size=$(du -b "$file" | cut -f 1)

		ffmpeg -i "$file" -vcodec libx265 -crf 24 "$file_copy" 2>/dev/null

		if [[ "$?" == "0" ]]; then

			size2=$(du -b "$file_copy" | cut -f 1)
			du -sh "$file_copy"
			if [ "$size" -gt "$size2" ]; then
				mv "$file_copy" "$file"
			else
				echo "Compress pointless"
				rm -f "$file_copy"
			fi
		else
			echo "Compress failed"
			rm -f "$file_copy"
		fi
	done
}
function trap_view_shutdown_sigint(){
	trap - SIGINT
	export trap_view_shutdown_triggerd="1"
	if [[ `basename $PWD` != "keep" ]]; then
		echo "move file"
		mv "$1" keep/
		store_id "$1" "K"
	fi
	kill "$pid"
	echo "keep file"

	pgrep firefox | awk '{print $2}' | xargs kill 2>/dev/null
	pgrep vlc | awk '{print $2}' | xargs kill 2>/dev/null

	shutdown -h now
}


function view_shutdown (){
	if [ -f "$1" ]; then
		pid=0;

		trap 'trap_view_shutdown_sigint "$1"' SIGINT

		vlc $1 &
		pid="$!"
		sleep 2
		cls
		echo "$1"
		export trap_view_shutdown_triggerd=""
		wait
		trap - SIGINT
		ret="$?"
		if [[ "$ret" == "0" && "$trap_view_shutdown_triggerd" != "1" && `basename $PWD` != "keep" ]]; then
			echo "remove file"
			rm "$1"
			store_id "$1" "W"
		fi

		pgrep firefox | awk '{print $2}' | xargs kill 2>/dev/null
		pgrep vlc | awk '{print $2}' | xargs kill 2>/dev/null

		shutdown -h now
	else
		echo "Argument missing"
	fi
}

STORE_FILE=~/dev/db/test_db/test
YTDL_OPTIONS=" --no-call-home --limit-rate 4M --restrict-filenames"

function todo_view_now(){

	for var in "$@"
	do

		response=`yt-dlp $YTDL_OPTIONS --get-id --get-filename "$var"`

		readarray -t info <<<"$response"
		id="[${info[0]}]"
		name="${info[1]}"

		if [[ -z "$id" || -z "$name" ]]; then
			echo "ERROR geting info for [$var]";
			return
		fi

		if (( ${#name} > 150 )); then
			name="$(echo "$name" | cut -c 1-100)-$id.%(ext)s"
		fi

		yt-dlp "$var" $YTDL_OPTIONS -o - | vlc -

	done
}

function mp4_download(){

	media_download "video" "$@"
}
function mp3_download(){

	media_download "audio" "$@"
}

function media_download(){


	local SUB_TITLES=' -f bestvideo[height<=2000]+bestaudio/best[height<=2000] --sub-langs en,de --write-subs'
	local type="$1"

	shift 1

	local force="0"
	for var in "$@"
	do
		if [[ "$var" == "--force" ]]; then
			force="1"
			continue
		fi

		response=`yt-dlp $YTDL_OPTIONS --get-id --get-filename "$var"`

		readarray -t info <<<"$response"
		local id="[${info[0]}]"
		local name="${info[1]}"

		if [[ -z "$id" || -z "$name" ]]; then
			echo "ERROR geting info for [$var]";
			return
		fi

		if (( ${#name} > 150 )); then
			name="$(echo "$name" | cut -c 1-100)-$id.%(ext)s"
		fi

		local state=$(check_store_id "$id")
		if [[ "$state" != "0" ]]; then
			echo -n "$id known state $state | $name";
			if [[ "$force" == "0" ]]; then
				echo " skipping";
				continue
			else
				echo " redownloading";
				if [ -f "$name" ]; then
					rm -f "$name"
				fi
			fi
		fi

		local SETTINGS=""
		if [[ "$type" == "audio" ]]; then
			SETTINGS="--audio-quality 0 --extract-audio --audio-format mp3"
		elif [[ "$type" == "video" ]]; then
			if [[ "$var" == *"youtube"* ]]; then
				SETTINGS="$SUB_TITLES"
			fi
		fi

		yt-dlp "$var" $YTDL_OPTIONS $SETTINGS -o "$name"

		if [[ "$?" == "0" ]]; then
			store_id "$id" "D"
		fi

		langfiles=$(compgen -G "./*$id*.vtt") # language file exists
		if [[ "$?" == "0"  ]]; then
			for langfile in $langfiles
			do
				ffmpeg -i "$name" -i "$langfile" -c:s webvtt -c:v copy -c:a copy "tmp_$name" -v quiet
				mv "tmp_$name" "$name"
				rm "$langfile"
			done
		fi
	done
}


function check_store_id(){
	id=$(echo "$1" | grep -oP -- "(?<=\[)(.*)(?=\])")

	state="$2"

	line=$(grep -- "\[$id\]" "$STORE_FILE")

	if [[ "$?" != "0" ]]; then
		echo "0"
	else
		echo "$line" | awk '{print $1}'
	fi
}

function store_id(){
	id=$(echo "$1" | grep -oP -- "(?<=\[)(.*)(?=\])")

	state="$2"

	grep -- "$id" "$STORE_FILE" 1>/dev/null

	if [[ "$?" == "0" ]]; then
		sed -i "s/.\t\[$id\]/$state\t\[$id\]/" $STORE_FILE
	else
		echo -e "$state\t[$id]" >> $STORE_FILE
	fi
}
