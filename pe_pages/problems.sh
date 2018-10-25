#!/bin/sh

NOW=${1:-$(date +"%y%m%d")}
FOLDER="source_pages"
BASE="$FOLDER/$NOW-problems"
OUTPUT="$BASE.csv"
OUTPUTLOOK="$BASE-look.csv"

curl -s 'https://projecteuler.net/archives;page=1' \
| scrape -be 'table#problems_table > tr:not(:first-child)' | xml2json \
| jq -c '.html.body.tr[] | {id: .td[0]."$t",subject: .td[1][]."$t",solved:.td[2][]."$t"}' \
| json2csv -p -k id,subject,solved > $OUTPUT
chmod o+w $OUTPUT

for i in 2 3
do
curl -s 'https://projecteuler.net/archives;page='${i} \
| scrape -be 'table#problems_table > tr:not(:first-child)' | xml2json \
| jq -c '.html.body.tr[] | {id: .td[0]."$t",subject: .td[1][]."$t",solved:.td[2][]."$t"}' \
| json2csv -k id,subject,solved >> $OUTPUT
done

echo $OUTPUT" file created."
< $OUTPUT csvlook > $OUTPUTLOOK
echo $OUTPUTLOOK" file created."
