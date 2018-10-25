#!/bin/sh

if [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  exit 2
fi

yes_or_no (){
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

check (){
	if [ -d "$FOLDER" ];
		then
			task
		else
			echo "Folder $FOLDER not exist."
			#< Statistics\ -\ Project\ Euler-k1.html scrape -be 'table#main_table > tbody>tr:not(:first-child)' | xml2json > $NAME.json
	fi
}

task (){
	
	BASE="$FOLDER/$TODAY-person-korea"
	RAW="$BASE-raw.csv"
	OUTPUT="$BASE.csv"
	SORTED="$BASE-sorted.csv"
	RAWLOOK="$BASE-raw-look.csv"
	OUTPUTLOOK="$BASE-look.csv"
	SORTEDLOOK="$BASE-sorted-look.csv"	
	
	< $RAW csvlook > $RAWLOOK
	< $OUTPUT csvlook > $OUTPUTLOOK
	< $SORTED csvlook > $SORTEDLOOK
	
	echo "process completed"
	echo $RAWLOOK
	echo $OUTPUTLOOK
	echo $SORTEDLOOK
}

TODAY=${1:-$(date +"%y%m%d")}
FOLDER="source_pages/$TODAY"
if [ $# -eq 0 ]; then
  echo "You can input target date like \"yymmdd\""
  echo "Default value is today"
fi
yes_or_no "Target Date : "$TODAY" proceed?" && check



