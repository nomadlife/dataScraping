#!/bin/sh
usage()
{
  echo 'Usage : Script -s <server> -i <instance> -u <user> -p <password>'
  echo '                  <query> -w <warning value> -c <critical value>'
  exit
}

TODAY=$(date +"%y%m%d%H%M%S")
echo $TODAY

BASE="testoutput"
FILE="test-kperson"
NAME="$BASE/$FILE"


# if [ "$#" -ne 13 ]
# then
  # usage
# fi

while [ "$1" != "" ]; do
case $1 in
        -s )           shift
                       SERVER=$1
                       ;;
        -i )           shift
                       INSTANCE=$1
                       ;;
        -u )           shift
                       USER=$1
                       ;;
        -p )           shift
                       PASSWORD=$1
                       ;;
        -w )           shift
                       WARNINGVAL=$1
                       ;;
        -c )           shift
                       CRITICVAL=$1
                       ;;
        * )            QUERY=$1
    esac
    shift
done

# extra validation suggested by @technosaurus
if [ "$SERVER" = "" ]
then
    usage
fi
if [ "$INSTANCE" = "" ]
then
    usage
fi
if [ "$USER" = "" ]
then
    usage
fi
if [ "$PASSWORD" = "" ]
then
    usage
fi
if [ "$QUERY" = "" ]
then
    usage
fi
if [ "$WARNINGVAL" = "" ]
then
    usage
fi
if [ "$CRITICVAL" = "" ]
then
    usage
fi

echo "ALL IS WELL. SERVER=$SERVER,INSTANCE=$INSTANCE,USER=$USER,PASSWORD=$PASSWORD,QUERY=$QUERY,WARNING=$WARNINGVAL,CRITIC=$CRITICVAL"




