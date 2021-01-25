DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

password="1"
bash_history="0"
dotfiles="1"
package="0"


if [[ "$password" == "1" ]]
then
	echo "## Password db backup"

	backup_file="$HOME/backup/pass.kdbx"
	if [[ -e "$backup_file" ]]
	then
		backup_folders="~/backup/ /mnt/7C7F-17AF/backup/ /mnt/storage/backup/ /mnt/save/backup/"
		hash="H$(md5sum $backup_file | awk '{print $1}')"
		echo "Backing up to "
		for folder in $backup_folders
		do
			if [[ -d "$folder" ]]
			then
				echo -n " - $folder"
				found=""
				for file in `ls $folder*`
				do
					f="H$(md5sum "$file" | awk '{print $1}')"
					if [[ "$hash" == "$f" ]]
					then
						found="y"
						break;
					fi
				done

				if [[ -z "$found" ]]
				then
					d=$(date +"%Y_%m_%d_%s")
					cp "$backup_file" "$folder$d.key.kdbx"

					echo " copyed"
				else
					echo " already exists"
				fi
			fi
		done
		echo ""

	else
		echo "# ERROR no pass db"
	fi
else
	echo "# DISABLED Password db backup"
fi

if [[ "$bash_history" == "1" ]]
then
	echo "## compress bash_history"
	bashhistory="$HOME/.config/bash/.bash_history"

	$HOME/.config/bash/scripts/filter_for_last.awk "$bashhistory" > "$bashhistory.bak"

	cp "$bashhistory.bak" "$bashhistory"

	sed -i '/--version/d' "$bashhistory"
	sed -i '/--help/d' "$bashhistory"
	sed -i '/^man/d' "$bashhistory"
	sed -i '/^type/d' "$bashhistory"
	sed -i '/^file/d' "$bashhistory"
	sed -i '/^view_shutdown/d' "$bashhistory"
else
	echo "# DISABLED compress bash_history"
fi

if [[ "$package" == "1" ]]
then
	echo "## create package list"
	pacman -Qqett | sort | uniq
else
	echo "# DISABLED create package list"
fi

if [[ "$dotfiles" == "1" ]]
then
	echo "## dotfiles backup"
	dot_repo="/mnt/storage/development/dotfiles"

	#\cp -rL "$dot_repo/links" "$dot_repo/repo"
else
	echo "# DISABLED dotfiles backup"
fi
