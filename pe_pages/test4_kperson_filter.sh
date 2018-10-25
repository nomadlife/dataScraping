# < test3_kperson.csv csvlook > test3_kperson_csvlook.csv
# < test3_kperson.csv cols -c last_solved body "sed -e 's/.*problem.//'" |csvcut -c rank,solved,last_solved | csvlook | head
# < test3_kperson.csv cols -c last_solved body "sed -e 's/.last\ solved.*//'" | header -r name,rank,solved |csvcut -c rank,name,solved | csvlook | head
# < test3_kperson.csv csvcut -c rank,solved,last_solved,rank | header -r rank,solved,last,rank2  | csvlook | head
# < test3_kperson.csv csvcut -c rank,solved,last_solved,last_solved | header -r rank,solved,last,name  |cols -c last body "sed -e 's/.*problem.//'" | head
# < test3_kperson.csv csvcut -c id,rank,solved,last_solved,last_solved | header -r id,rank,solved,last,name  |cols -c last body "sed -e 's/.*problem.//'" |cols -c name body "sed -e 's/.last\ solved.*//'" | head
# < test3_kperson.csv csvcut -c rank,solved,last_solved,last_solved | header -r rank,solved,last,name  |cols -c last body "sed -e 's/.*problem.//'" |cols -c name body "sed -e 's/.last\ solved.*//'" | csvcut -c rank,name,solved,last | head | csvlook
# < test3_kperson.csv csvcut -c rank,solved,last_solved,last_solved | header -r rank,solved,recent,name  |cols -c recent body "sed -e 's/.*problem.//'" |cols -c name body "sed -e 's/.last\ solved.*//'" | csvcut -c rank,name,solved,recent > test4_kperson.csv
# < test3_kperson.csv csvcut -c rank,solved,last_solved,last_solved | header -r rank,solved,recent,name | cols -c recent body "sed -e 's/.*problem.//'" | cols -c recent body "sed -e 's/days.*//'" |cols -c name body "sed -e 's/.last\ solved.*//'" | csvcut -c rank,name,solved,recent > test4_kperson.csv
# < test3_kperson.csv csvcut -c rank,solved,last_solved,last_solved | header -r rank,solved,recent,name | cols -c recent body "sed -e 's/.*problem.//'" | cols -c recent body "sed -e 's/\ days.*//'" |cols -c name body "sed -e 's/.last\ solved.*//'" | csvcut -c rank,name,solved,recent > test4_kperson.csv
# < test3_kperson.csv csvcut -c rank,solved,last_solved,last_solved | header -r rank,solved,recent,name | cols -c recent body "sed -e 's/.*problem.//' -e 's/\ days.*//'" |cols -c name body "sed -e 's/.last\ solved.*//'" | csvcut -c rank,name,solved,recent > test4_kperson.csv
< test3_kperson.csv csvcut -c rank,solved,last_solved,last_solved | header -r rank,solved,recent,name | cols -c recent body "sed -e 's/.*problem.//' -e 's/\ days.*//' -e 's/\ day.*//' -e 's/within.*/0/'" |cols -c name body "sed -e 's/.last\ solved.*//'" | csvcut -c rank,name,solved,recent > test4_kperson.csv
< test4_kperson.csv csvlook > test4_kperson_look.csv