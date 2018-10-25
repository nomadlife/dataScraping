# csv sorting
# < test4_kperson.csv tail -n +2 | sort -t"," -k4,4 -n | head
# < test4_kperson.csv tail -n +2 | sort -t"," -nk 4 | head
# < test4_kperson.csv tail -n +2 | sort -t"," -nrk 4 | head
# < test4_kperson.csv tail -n +2 | sort -t"," -nrk4 | head
# < test4_kperson.csv tail -n +2 | sort -t"," -nk4 | header -r rank,name,solved,recent > test5_kperson.csv
< test4_kperson.csv tail -n +2 | sort -t"," -nk4 | header -a rank,name,solved,recent > test5_kperson.csv
< test5_kperson.csv csvlook > test5_kperson_look.csv