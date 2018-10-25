TODAY=$(date +"%y%m%d")
for i in 1 2 3
do
curl -s 'https://projecteuler.net/archives;page='${i} > $TODAY-page${i}.html
done