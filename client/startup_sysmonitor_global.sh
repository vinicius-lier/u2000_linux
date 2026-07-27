
# single1.0 Ìí¼ÓÒ»²ãclientÄ¿Â¼ 20110429
# cd $OSS_ROOT/client
# cd $OSS_ROOT/client/client
usage="Usage: `basename $0`"

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
app_name=`basename $0`

if [ "$workfolder" = "/" ]
then
	echo "The shell $app_name can not run at / ."
	exit 1
fi

if [ "$DISPLAY" = "" ]
then
    echo "DISPLAY variable was not set, can not start client."
fi

cd $workfolder

cd client

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
    #echo "Successed."
    
    FORCEDEFVIS=0x20
    export FORCEDEFVIS
    
    /usr/bin/nohup $_RUNJAVA/bin/java -Dprocname=sysmonitor -classpath ./startuploader.jar -Dnet.sf.ehcache.skipUpdateCheck=true -XX:MinHeapFreeRatio=10 -XX:MaxHeapFreeRatio=40 -XX:NewRatio=12 -XX:MaxNewSize=32m -Dsun.java2d.pmoffscreen=false -Dserialize=false -Xms8m -Xmx64m -Xverify:none -Dparsertype=2 -XX:MetaspaceSize=6m -XX:MaxMetaspaceSize=128m -XX:CompressedClassSpaceSize=64m -Dsun.java2d.noddraw=true -Dhelpapp=run_help.bat -Dsubsystem=sysmonitor -Dsun.zip.disableMemoryMapping=true -Dimap.isOpenSystemMonitorFrame=true -Djava.library.path=../../cau/lib:./update/lib:../lib -XX:+HeapDumpOnOutOfMemoryError -Dorg.omg.CORBA.ORBSingletonClass=org.openorb.CORBA.ORBSingleton -DExtesnionRigestry.debug=false -DLoginHandler=com.swimap.iview.systemmonitor.login.SysMonitorLoginHandler -Dsm.serverinfosrc=MonitorModule -Dsm.defaultport=31030 -Dsm.defaultsslport=31080 -DExtesionRegistry.cacheUse=false -Dscript.name="$0" -Dfile.encoding=UTF-8 com.swimap.startup.Startup -debuglevel 1 -showtrace false -enabledebug false -tracefile DebugTrace.txt %* >/dev/null 2>&1 &
fi

