#!/bin/bash

DB="stuff"
DB_COMMAND="psql -U postgres"

function db {
	if [[ -z "$1" ]]; then
		eval "$DB_COMMAND" "$DB"
	else
		eval "$DB_COMMAND" "$DB" -c '"$*"'
	fi
}

function dbj {
	result=$($DB_COMMAND "$DB" -c "select array_to_json(array_agg(r)) from ($*) r")

	if [[ "$?" == "0" ]];then
		printf "%s" "$result" | sed '3p;d'
	fi
	echo ""
}


function run_migrations {

	local res=$(dbj "SELECT id FROM migrations ORDER BY id DESC LIMIT 1" 2>/dev/null | jq '.[0].id' 2>/dev/null)

	if ! [[ "$res" =~ ^[0-9]+$ ]] ; then
		res="0"
	else
		res=$((res+1))
	fi

	for num in $(seq "$res" 1000);
	do
		file=$(compgen -G "$BASH_HOME/scripts/migration/$num-*.sql")
		if [[ "$?" == 0 ]]; then

			filename=$(basename -- "$file")
			filename=${filename//.sql/}
			filename=${filename//$num-/}

			db "DROP table IF EXISTS tmp ;"

      { log=$(db < "$file" 2>&1 >&3 3>&-); } 3>&1


      if [[ "$log" =~ "ERROR:" ]]; then
        echo -e "[===\n$log\n===]"
        echo "Migration faild $num"
        num=$((num-1))
        break
      else
			  db "INSERT INTO migrations (id, name) VALUES ($num, '$filename');"
			  db "COMMIT TRANSACTION;"
        echo "Migration run $num"
      fi
		else
			echo "Run all migrations before $num"
			break
		fi
	done
}

