if [ "$#" = 0 ]
then
    echo $DEFAULT
fi

if [ "$#" -gt 0 ]
then
    echo "There's Beans"
fi

if [ "$1" = "cool" ]
then
echo "Cool Beans"
fi

ARG=${1:-default.csv}
echo $ARG