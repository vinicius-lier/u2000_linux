# single1.0 添加一层client目录 20110429
# cd $OSS_ROOT/client
# cd $OSS_ROOT/client/client
# cd ../

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

_CLIENT_INIT_PATH=$workfolder

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

getWorkPath

temp_oldpath=""
if [ -f "oldpath.properties" ]; then
temp_oldpath=`cat oldpath.properties | awk -F= '{if($1=="oldPath") print $2}'`
fi

if [ "$temp_oldpath" != "$workfolder" ]; then
    #echo "Fix dir have been changed, remove configuration dir."
    rm -rf oldpath.properties
    rm -rf configuration
    echo "oldPath=$workfolder" > oldpath.properties
fi

# V1R3C00 B026 TR6 2011-2-23 16:55 为了加快客户端启动速度，在T5220机器上使用并行GC，其他机器使用串行GC
#default value
_GCTYPE="+UseSerialGC"
#check if the machine sparc type is t5220,if so,modify the default value
uname -a | grep -v grep | grep "SPARC-Enterprise-T5220" > /dev/null 2>&1
if [ $? -eq 0 ]
then
    _GCTYPE="+UseParallelOldGC"
fi


if [ "$_RUNJAVA" = "" ]; then
    echo "Error: Environment IMAP_JAVA_HOME not exist."
else
    
    FORCEDEFVIS=0x20
    export FORCEDEFVIS
    
    PATH=$PATH:/usr/sfw/bin
    export PATH
    LD_LIBRARY_PATH=$_CLIENT_INIT_PATH/client/thirdparty/webrender/work_${LOGNAME}_1/.webrendererswing6/sparc-solaris32:$LD_LIBRARY_PATH:/usr/sfw/lib
    export LD_LIBRARY_PATH
    
    /usr/bin/nohup  $_RUNJAVA/bin/java -Dprocname=client -classpath ./startuploader.jar -Dnet.sf.ehcache.skipUpdateCheck=true -Xverify:none -Dparsertype=2 -Xms128m -Xmx600m -XX:MaxMetaspaceSize=600m   -XX:CompressedClassSpaceSize=300m -XX:MaxHeapFreeRatio=40 -XX:MinHeapFreeRatio=25 -XX:${_GCTYPE} -XX:NewRatio=12 -XX:MaxNewSize=32m -Dsun.java2d.pmoffscreen=false -Dserialize=false -DSingleFileChooserPath=true -DskipObjFileCheck=true -DloadJarExtPaths=false -Dexsubsystem=cmdclient -Dsun.awt.xembedserver=true -Dsun.zip.disableMemoryMapping=true -Dsun.java2d.noddraw=true -Dhelpapp=run_help.bat -XX:+HeapDumpOnOutOfMemoryError -Djava.library.path=../../cau/lib:./update/lib:../lib:../script/lib/core/itf -DExtesnionRigestry.debug=false -DExtesionRegistry.cacheUse=true -Dscript.name="$0" -DSpecification.Verify=true -Dfile.encoding=UTF-8 com.swimap.startup.Startup -debuglevel 1 -showtrace false -enabledebug true -tracefile DebugTrace.txt $* >/dev/null 2>&1 &
fi


