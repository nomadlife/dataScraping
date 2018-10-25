# < Statistics\ -\ Project\ Euler-k1.html scrape -be 'table#main_table > tbody>tr:not(:first-child)' | xml2json \
# | jq -c '.html.body.tr[] | {id,rank:.td[0]."$t",solved:.td[3]."$t",level:.td[4].a."$t",language:.td[5].a."$t",last_solved:.td[1].table.tbody.tr.td[0].div.span."$t"}' \
# | json2csv -p -k rank,id,solved,last_solved \
# | csvcut -c rank,solved,last_solved,last_solved | header -r rank,solved,recent,name \
# | cols -c recent body "sed -e 's/.*problem.//'" | cols -c recent body "sed -e 's/\ days.*//'" |cols -c name body "sed -e 's/.last\ solved.*//'" \
# | csvcut -c rank,name,solved,recent > test_kperson.csv

< Statistics\ -\ Project\ Euler-k1.html scrape -be 'table#main_table > tbody>tr:not(:first-child)' | xml2json \
| jq -c '.html.body.tr[] | {id,rank:.td[0]."$t",solved:.td[3]."$t",level:.td[4].a."$t",language:.td[5].a."$t",last_solved:.td[1].table.tbody.tr.td[0].div.span."$t"}' \
| json2csv -p -k rank,id,solved,last_solved \
| csvcut -c rank,solved,last_solved,last_solved | header -r rank,solved,recent,name \
| cols -c recent body "sed -e 's/.*problem.//' -e 's/\ days.*//' -e 's/\ day.*//' -e 's/within.*/0/'" |cols -c name body "sed -e 's/.last\ solved.*//'" \
| csvcut -c rank,name,solved,recent \
| tail -n +2 | sort -t"," -nk4 | header -a rank,name,solved,recent > test6_kperson.csv

< test6_kperson.csv csvlook > test6_kperson_look.csv