< 18071300-problems.csv sed -n '52,101p' | sort -t "," -nrk3,3 | header -a id,subject,solved | csvlook > 18071300-problems-51-101-look.csv
