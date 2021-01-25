#!/bin/bash

usb="/mnt/7C7F-17AF"
musik_store="/mnt/Games/media/mp3/musik/current"

echo "Music changes"

declare -A musik_list


for file in `ls -1 $musik_store`
do
	hash=$(md5sum "$musik_store/$file" | grep -oP "^\S*")
	musik_list["H$hash"]=$file;
done

for file in `ls -1 $usb/musik`
do
	hash=$(md5sum $usb/musik/$file | grep -oP "^\S*")
	if [ -z ${musik_list["H$hash"]} ]
	then
		rm "$usb/musik/$file";
		echo "Remove $usb/musik/$file";
	else
		musik_list["H$hash"]="";
		unset musik_list["H$hash"]
	fi
done

for file in ${musik_list[@]}
do
	cp "$musik_store/$file" "$usb/musik/$file"
	echo "Copyed $file"
done

for file in `ls -1 $usb/musik/*.mp3`
do
	rand=$RANDOM
	mv "$file" "$usb/musik/$rand.mp3"
done

rm -vf $usb/*.MP3
rm -vf $usb/*.mp3


rm -fr "$usb/.Trash-1000"
