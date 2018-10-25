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
	
	BASE="$FOLDER/$TODAY-person-usa"
	RAW="$BASE-raw.csv"
	OUTPUT="$BASE.csv"
	SORTED="$BASE-sorted.csv"
	RAWLOOK="$BASE-raw-look.csv"
	OUTPUTLOOK="$BASE-look.csv"
	SORTEDLOOK="$BASE-sorted-look.csv"

	< $FOLDER/Statistics\ -\ Project\ Euler-u1.html scrape -be 'table#main_table > tbody>tr:not(:first-child)' | xml2json \
	| jq -c '.html.body.tr[] | {id,rank:.td[0]."$t",solved:.td[3]."$t",level:.td[4].a."$t",language:.td[5].a."$t",last_solved:.td[1].table.tbody.tr.td[0].div.span."$t"}' \
	| json2csv -p -k rank,id,solved,last_solved > $RAW

	for i in 2 3 4 5 6 7 8 9 10
	do
	< $FOLDER/Statistics\ -\ Project\ Euler-u${i}.html scrape -be 'table#main_table > tbody>tr:not(:first-child)' | xml2json \
	| jq -c '.html.body.tr[] | {id,rank:.td[0]."$t",solved:.td[3]."$t",level:.td[4].a."$t",language:.td[5].a."$t",last_solved:.td[1].table.tbody.tr.td[0].div.span."$t"}' \
	| json2csv -k rank,id,solved,last_solved >> $RAW
	done

	< $RAW csvcut -c rank,solved,last_solved,last_solved | header -r rank,solved,recent,name \
	| cols -c recent body "sed -e 's/.*problem.//' -e 's/\ days.*//' -e 's/\ day.*//' -e 's/within.*/0/'" |cols -c name body "sed -e 's/.last\ solved.*//'" \
	| csvcut -c rank,name,solved,recent > $OUTPUT
	< $OUTPUT tail -n +2 | sort -t"," -nk4 | header -a rank,name,solved,recent > $SORTED

	< $RAW csvlook > $RAWLOOK
	< $OUTPUT csvlook > $OUTPUTLOOK
	< $SORTED csvlook > $SORTEDLOOK
	
	echo "process completed"
	echo $RAW
	echo $OUTPUT
	echo $SORTED
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