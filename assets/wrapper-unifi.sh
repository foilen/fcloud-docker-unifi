#!/bin/bash

set -e

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
  com.ubnt.ace.Launcher start
