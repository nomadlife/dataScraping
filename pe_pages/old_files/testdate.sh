for i in 1 2 3
do
echo ${i}
done 

TODAY=$(date +"%y%m%d")
FILE=list-kperson-$TODAY.csv
echo $TODAY
echo $FILE
if [ -f "$FILE" ];
then
   echo "File $FILE exist."
else
   echo "File $FILE does not exist"
fi