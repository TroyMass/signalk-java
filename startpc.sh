#!/bin/bash
#
# start script for freeboard on a linux pc or maybe on a mac too
#
#SIGNALK_HOME=/home/pi/freeboard
SIGNALK_HOME=`pwd`

#
cd $SIGNALK_HOME
mkdir -p signalk-static/logs

#temporary until linux-arm.jar is in purejavacom.jar
export LD_LIBRARY_PATH=$SIGNALK_HOME/jna

#start server

#NOTE: you may need to explicitly set your JAVA_HOME for your environment
#
#JAVA_HOME=/home/pi/jdk1.8.0
#JAVA_HOME=/home/robert/java/jdk1.7.0_07
#export JAVA_HOME

JAVA=java
if [ -n "$JAVA_HOME" ]; then
	JAVA=$JAVA_HOME/bin/java
fi

EXT="-Djava.util.Arrays.useLegacyMergeSort=true"
MEM="-Xmx32m -XX:PermSize=32m -XX:MaxPermSize=48m"

LOG4J=-Dlog4j.configuration=file://$SIGNALK_HOME/conf/log4j2.json
HAWTIO=-Dhawtio.authenticationEnabled=false
cd $SIGNALK_HOME
echo "Starting offline: mvn $EXT $LOG4J $HAWTIO exec:java 2>&1 &" >>signalk-static/logs/start.log 2>&1 &
mvn -Dexec.args="'$EXT' '$LOG4J' '$HAWTIO'" exec:java 
#>>signalk-static/logs/start.log 2>&1 &
