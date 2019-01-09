#!/bin/bash
cd `dirname $0`

# 定义变量
BIN_DIR=`pwd`
cd ..

SERVER_NAME=`sed '/service.application.name/!d;s/.*=//' $BIN_DIR/service.properties | tr -d '\r'`
JAR_FILE_NAME=`sed '/service.application.file/!d;s/.*=//' $BIN_DIR/service.properties | tr -d '\r'`
SERVER_PORT=`sed '/service.port/!d;s/.*=//' $BIN_DIR/service.properties | tr -d '\r'`
XMX_OPTS=`sed '/service.java.xmx/!d;s/.*=//' $BIN_DIR/service.properties | tr -d '\r'`

cd $BIN_DIR

if [ -z "$SERVER_NAME" ]; then
   SERVER_NAME=`hostname`
fi

# 停止当前应用
PIDS=`ps -ef | grep java | grep "$BIN_DIR" |awk '{print $2}'`
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

sleep 5
# 启动应用
echo -e "Starting the $SERVER_NAME ...\c"

nohup java  -Xms256M -Xmx$XMX_OPTS -Dserver.port=$SERVER_PORT -Dmanagement.port=-1 -Dapp.profile=test -classpath $BIN_DIR -jar $JAR_FILE_NAME &

COUNT=0
while [ $COUNT -lt 1 ]; do   
    echo -e ".\c"
    sleep 1 
    if [ -n "$SERVER_PORT" ]; then
        COUNT=`netstat -an | grep $SERVER_PORT | wc -l`
    else
        COUNT=`ps -f | grep java | grep "$BIN_DIR" | awk '{print $2}' | wc -l`
    fi
    if [ $COUNT -gt 0 ]; then
        break
    fi
done
 
echo "OK!"
PIDS=`ps -f | grep java | grep "$BIN_DIR" | awk '{print $2}'`
echo "PID: $PIDS"
echo "STDOUT: $STDOUT_FILE"
