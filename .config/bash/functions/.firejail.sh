#!/bin/bash




function get_downloads(){

	program=$1

	fids=$(firejail --list | grep -oP "(\d+)(?=.*$program)")

	# grep -v "^d"
	#files=$(firejail --ls="$fid" ~ | grep -v "^d" | grep -v )

	#firejail --get="$fid" "~/$file"

}

function put_downloads(){

	file=$1

	fids=$(firejail --list | grep -oP "(\d+)(?=.*)")


	#firejail --put="$fid" "$file" ~

}
