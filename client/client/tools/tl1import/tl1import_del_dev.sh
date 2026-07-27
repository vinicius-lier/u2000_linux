#!/bin/bash

_SYSTEMTYPE=`uname`
_RUNJAVA=""
if [ "$_SYSTEMTYPE" = "Linux" ]; then
    #echo "Linux"
	  if [ -f "../../jre/bin/java" ]; then
        _RUNJAVA=../../jre
    elif [ -f "../../OSSJRE/jre_linux/bin/java" ]; then
        _RUNJAVA=../../OSSJRE/jre_linux
	  elif [ -f "$IMAP_JAVA_HOME/bin/java" ]; then
        _RUNJAVA=$IMAP_JAVA_HOME
    else
        _RUNJAVA=""
    fi
else
    #echo "Solaris"
	  if [ -f "../../jre/bin/java" ]; then
        _RUNJAVA=../../jre
    elif [ -f "../../OSSJRE/jre_sol/bin/java" ]; then
        _RUNJAVA=../../OSSJRE/jre_sol
	  elif [ -f "$IMAP_JAVA_HOME/bin/java" ]; then
        _RUNJAVA=$IMAP_JAVA_HOME
    else
        _RUNJAVA=""
    fi
fi

if [ "$_RUNJAVA" = "" ]; then
    echo "Error: Environment IMAP_JAVA_HOME not exist."
else
    echo "start tl1import:" $6
    $_RUNJAVA/bin/java -Xms32m -Xmx640m -classpath $OSS_ROOT/client/lib/baseutil.jar:$OSS_ROOT/client/lib/imapsslbase.jar:$OSS_ROOT/client/lib/iview.jar:$OSS_ROOT/client/lib/startup.jar:$OSS_ROOT/client/client/productlib/access/domainIndependent/access_frame.jar:$OSS_ROOT/client/client/productlib/access/domainIndependent/nemgr_frame.jar:$OSS_ROOT/client/lib/3rd_tools/* com.huawei.n2000bms.tl1import.shell.TL1ImportToolMain  $* >/dev/null 2>&1
    
    errcode=$?
    if [ $errcode = 0 ]; then
        echo "Operate success."
	  elif [ $errcode = 1 ]; then
        echo "Input error."
	  elif [ $errcode = 2 ]; then
        echo "Input error."
	  elif [ $errcode = 3 ]; then
        echo "Certificate verification failure."
	  elif [ $errcode = 4 ]; then
        echo "Login failed."
    else
        echo "Operate failed, errcode is:"$errcode
    fi
fi
