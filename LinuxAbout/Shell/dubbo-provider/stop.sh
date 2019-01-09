#!/bin/bash --login
cd `dirname $0`

# 定义变量
BIN_DIR=`pwd`
cd ..
DEPLOY_DIR=`pwd`
CONF_DIR=$BIN_DIR

SERVER_NAME=`sed '/dubbo.application.name/!d;s/.*=//' $BIN_DIR/dubbo.properties | tr -d '\r'`
JAR_FILE_NAME=`sed '/dubbo.application.file/!d;s/.*=//' $BIN_DIR/dubbo.properties | tr -d '\r'`
SERVER_PROTOCOL=`sed '/dubbo.protocol.name/!d;s/.*=//' $BIN_DIR/dubbo.properties | tr -d '\r'`
SERVER_PORT=`sed '/dubbo.protocol.port/!d;s/.*=//' $BIN_DIR/dubbo.properties | tr -d '\r'`
LOGS_FILE=`sed '/dubbo.log4j.file/!d;s/.*=//' $BIN_DIR/dubbo.properties | tr -d '\r'`

cd $BIN_DIR

if [ -z "$SERVER_NAME" ]; then
   SERVER_NAME=`hostname`
fi

LOGS_DIR=""
if [ -n "$LOGS_FILE" ]; then
    LOGS_DIR=`dirname $LOGS_FILE`
else
    LOGS_DIR=$BIN_DIR/logs
fi
if [ ! -d $LOGS_DIR ]; then
    mkdir $LOGS_DIR
fi
STDOUT_FILE=$LOGS_DIR/stdout.log

# 停止当前应用
PIDS=`ps -ef | grep java | grep "$CONF_DIR" |awk '{print $2}'`
if [ -z "$PIDS" ];then
   echo "WARN: The $SERVER_NAME does not started!"
   # exit 1
   else

      if [ -n "$PIDS" ]; then
         echo "INFO: The $SERVER_NAME stoping by kill command!"
         for PID in $PIDS ; do
            kill -9 $PID > /dev/null 2>&1
         done
      fi
      
      COUNT=0
      while [ $COUNT -lt 1 ]; do
         sleep 1
         COUNT=1
         for PID in $PIDS ; do
            PID_EXISTS=`ps -f -p $PID | grep java`
            if [ -n "$PID_EXISTS" ]; then
               COUNT=0
         break
            fi
         done
      done

      echo "application container stoped!"
    
fi
