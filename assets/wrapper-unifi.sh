#!/bin/bash

set -e

if [ -z "$JVM_MAX_HEAP" ]; then
  JVM_MAX_HEAP=1G
fi
echo "JVM_MAX_HEAP : $JVM_MAX_HEAP"

BASEDIR=/usr/lib/unifi
DATADIR=$BASEDIR/data
LOGDIR=$BASEDIR/logs
RUNDIR=$BASEDIR/run

# Find the classpath
echo "--[ Find the classpath ]--"
cd $BASEDIR/lib/
CLASSPATH=
for i in $(ls /usr/lib/unifi/lib/*.jar); do
  echo Add $i to classpath
  CLASSPATH="$CLASSPATH:$i"
done

# Execute
echo "--[ Execute main app ]--"
cd $BASEDIR
/usr/bin/java \
  -Dunifi.datadir=${DATADIR} \
  -Dunifi.logdir=${LOGDIR} \
  -Dunifi.rundir=${RUNDIR} \
  -classpath $CLASSPATH \
  -Xmx$JVM_MAX_HEAP \
  com.ubnt.ace.Launcher start
