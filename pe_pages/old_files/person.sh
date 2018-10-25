#!/usr/bin/env bash
FILE="$1"
scrape -be 'table#main_table > tbody>tr:not(:first-child)' | xml2json | jq -c '.html.body.tr[] | {rank:.td[0]."$t",solved:.td[3]."$t",level:.td[4].a."$t",last_solved:.td[1].table.tbody.tr.td[0].div.span."$t"}' | json2csv -p -k rank,solved,level,last_solved >> $FILE 
