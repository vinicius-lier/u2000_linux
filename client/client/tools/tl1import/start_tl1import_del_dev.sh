#!/bin/bash

. $OSS_ROOT/server/svc_profile.sh

getWorkPath()
{
	dir=`dirname $0`
	ispointstart=`echo $dir | awk -F/ '{print $1}'`
	if [ "$ispointstart" = "." ]
	then
	    dir=`echo $dir | sed 's/^.//'`
	    workfolder="`pwd`$dir"
	elif [ "$ispointstart" = ".." ]
	then
	    workfolder="`pwd`/$dir"
	else
	    workfolder="$dir"
	fi
	return 0
}
getWorkPath
echo "workfolder"=$workfolder

#IP Address
echo -e "Please input the IP address:\n>_\b\c"
read NBITL1_IP

#Port
echo -e "Please input the port:\n>_\b\c"
read NBITL1_Port
if [ "$NBITL1_Port" = "" ]
then
	NBITL1_Port=9819
fi

#Username
echo -e "Please input the username:\n>_\b\c"
read NBITL1_username
if [ "$NBITL1_username" = "" ]
then
	NBITL1_username=admin
fi

#Password
stty -echo
echo -e "Please input the password:\n>_\b\c"
read NBITL1_Password
echo -e "\n"
stty echo

#Protocol
echo -e "Please input the protocol(SSL or Telnet):\n>_\b\c"
read NBITL1_Protocol
if [ "$NBITL1_Protocol" = "" ]
then
	NBITL1_Protocol=Telnet
fi

#NBI TL1 the dir of tl1import_del_dev xlsx 
tl1import_deldev_dir=$OSS_ROOT/client/client/template/tl1import/en/deleteDeviceforDT

cd $tl1import_deldev_dir
filenamelist=(`find . -name "*.xlsx" -type f | sort`)
threads_Number=${#filenamelist[*]} 

tmp_fifofile="/tmp/$$.fifo"
mkfifo $tmp_fifofile

#File identifier 6(fd6) to fifo file
exec 10<>$tmp_fifofile

rm $tmp_fifofile

#echo $threads_Number enter to fd6
for ((i=0;i<$threads_Number;i++));
do
  echo
 
done >&10

for ((j=0;j<$threads_Number;j++));
do
  filename_temp=${filenamelist[$j]}
  filename=`echo "$filename_temp" | cut -d "/" -f2`
  read -u10
  {
    cd $workfolder
    bash tl1import_del_dev.sh $NBITL1_IP $NBITL1_Port $NBITL1_username $NBITL1_Password $NBITL1_Protocol $tl1import_deldev_dir/$filename
    echo >&10
  }&
done

wait
#Close fd6
exec 10>&-
