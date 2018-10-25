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
	
	BASE="$FOLDER/$TODAY-countries"
	OUTPUT="$BASE.csv"
	OUTPUTLOOK="$BASE-look.csv"

	< $FOLDER/Countries.html scrape -be 'table#country_table > tbody>tr:not(:first-child)' | xml2json \
	| jq -c '.html.body.tr[] | {country:.td[0].a."$t",user:.td[1]."$t",abovelv1:.td[2]."$t",mean:.td[3]."$t"}' \
	| json2csv -p -k country,user,abovelv1,mean > $OUTPUT

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


