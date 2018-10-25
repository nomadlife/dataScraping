if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments. arguemnt default adapted"
  exit 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  exit 2
fi

FILE=${1:-default.csv}

if [ -f "$FILE" ];
then
   echo "File $FILE exist."
else

< Statistics\ -\ Project\ Euler-k1.html scrape -be 'table#main_table > tbody>tr:not(:first-child)' | xml2json | jq -c '.html.body.tr[] | {rank:.td[0]."$t",solved:.td[3]."$t",last_solved:.td[1].table.tbody.tr.td[0].div.span."$t"}' | json2csv -p -k rank,solved,last_solved > $FILE
for i in 2 3 4
do
< Statistics\ -\ Project\ Euler-k${i}.html scrape -be 'table#main_table > tbody>tr:not(:first-child)' | xml2json | jq -c '.html.body.tr[] | {rank:.td[0]."$t",solved:.td[3]."$t",last_solved:.td[1].table.tbody.tr.td[0].div.span."$t"}' | json2csv -k rank,solved,last_solved >> $FILE
done

fi