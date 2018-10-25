< Statistics\ -\ Project\ Euler-k1.html scrape -be 'table#main_table > tbody>tr:not(:first-child)' | xml2json \
| jq -c '.html.body.tr[] | {id,rank:.td[0]."$t",solved:.td[3]."$t",level:.td[4].a."$t",language:.td[5].a."$t",last_solved:.td[1].table.tbody.tr.td[0].div.span."$t"}' \
| json2csv -p -k rank,id,solved,last_solved > test_kperson_raw.csv

< Statistics\ -\ Project\ Euler-k2.html scrape -be 'table#main_table > tbody>tr:not(:first-child)' | xml2json \
| jq -c '.html.body.tr[] | {id,rank:.td[0]."$t",solved:.td[3]."$t",level:.td[4].a."$t",language:.td[5].a."$t",last_solved:.td[1].table.tbody.tr.td[0].div.span."$t"}' \
| json2csv -k rank,id,solved,last_solved >> test_kperson_raw.csv

< Statistics\ -\ Project\ Euler-k3.html scrape -be 'table#main_table > tbody>tr:not(:first-child)' | xml2json \
| jq -c '.html.body.tr[] | {id,rank:.td[0]."$t",solved:.td[3]."$t",level:.td[4].a."$t",language:.td[5].a."$t",last_solved:.td[1].table.tbody.tr.td[0].div.span."$t"}' \
| json2csv -k rank,id,solved,last_solved >> test_kperson_raw.csv

< Statistics\ -\ Project\ Euler-k4.html scrape -be 'table#main_table > tbody>tr:not(:first-child)' | xml2json \
| jq -c '.html.body.tr[] | {id,rank:.td[0]."$t",solved:.td[3]."$t",level:.td[4].a."$t",language:.td[5].a."$t",last_solved:.td[1].table.tbody.tr.td[0].div.span."$t"}' \
| json2csv -k rank,id,solved,last_solved >> test_kperson_raw.csv


< test_kperson_raw.csv csvcut -c rank,solved,last_solved,last_solved | header -r rank,solved,recent,name \
| cols -c recent body "sed -e 's/.*problem.//' -e 's/\ days.*//' -e 's/\ day.*//' -e 's/within.*/0/'" |cols -c name body "sed -e 's/.last\ solved.*//'" \
| csvcut -c rank,name,solved,recent > test_kperson.csv
< test_kperson.csv tail -n +2 | sort -t"," -nk4 | header -a rank,name,solved,recent > test_kperson_sorted.csv