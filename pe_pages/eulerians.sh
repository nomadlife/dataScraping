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
	
	BASE="$FOLDER/$TODAY-eulerians"
	OUTPUT="$BASE.csv"
	OUTPUTLOOK="$BASE-look.csv"

	< $FOLDER/Statistics\ -\ Project\ Euler.html scrape -be 'table#country_table > tbody>tr:not(:first-child)' | xml2json \
	| jq -c '.html.body.tr[] | {id:.id,rank:.td[0]."$t",name1:.td[1].table.tbody.tr.td[0].div."$t",name2:.td[1].table.tbody.tr.td[0].div.i."$t",country:.td[2].a.img.alt,score:.td[3]."$t",language:.td[5].a."$t"}' \
	| json2csv -p -k rank,name1,name2,country,score \
	| cols -c name1,name2 tr -d ',' | header -r name,rank,country,score \
	| csvcut -c rank,name,country,score > $OUTPUT

	< $OUTPUT csvlook > $OUTPUTLOOK
	
	echo "process completed"
	echo $RAW
	echo $OUTPUT

}

TODAY=${1:-$(date +"%y%m%d")}
FOLDER="source_pages/$TODAY"
if [ $# -eq 0 ]; then
  echo "You can input target date like \"yymmdd\""
  echo "Default value is today"
fi
yes_or_no "Target Date : "$TODAY" proceed?" && check


