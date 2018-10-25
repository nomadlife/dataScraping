#!/bin/sh
if [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  exit 2
fi

TODAY=$(date +"%y%m%d")
FILE=${1:-list-problems-$TODAY.csv}

if [ -f "$FILE" ];
then
   echo "File $FILE exist."
else

< page1.html scrape -be 'table#problems_table > tr:not(:first-child)' | xml2json \
| jq -c '.html.body.tr[] | {id: .td[0]."$t",subject: .td[1][]."$t",solved:.td[2][]."$t"}' \
| json2csv -p -k id,subject,solved > $FILE

for i in 2 3
do
< page${i}.html scrape -be 'table#problems_table > tr:not(:first-child)' | xml2json \
| jq -c '.html.body.tr[] | {id: .td[0]."$t",subject: .td[1][]."$t",solved:.td[2][]."$t"}' \
| json2csv -k id,subject,solved >> $FILE
done
fi