#!/bin/bash --login
cd `dirname $0`

# 定义变量
BIN_DIR=`pwd`
cd ..
DEPLOY_DIR=`pwd`
CONF_DIR=$BIN_DIR

SERVER_NAME=`sed '/dubbo.application.name/!d;s/.*=//' $BIN_DIR/dubbo.properties | tr -d '\r'`
JAR_FILE_NAME=`sed '/dubbo.application.file/!d;s/.*=//' $BIN_DIR/dubbo.properties | tr -d '\r'`
PROFILE_NAME=`sed '/dubbo.application.profile/!d;s/.*=//' $BIN_DIR/dubbo.properties | tr -d '\r'`
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

# 定义java环境
LIB_DIR=$DEPLOY_DIR
LIB_JARS=`ls $LIB_DIR|grep .jar|awk '{print "'$LIB_DIR'/"$0}'|tr "\n" ":"`
 
JAVA_OPTS=" -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Dspring.profiles.active=$PROFILE_NAME -Ddubbo.shutdown.hook=true -Ddubbo.service.shutdown.wait=6000 "
JAVA_DEBUG_OPTS=""
if [ "$1" = "debug" ]; then
    JAVA_DEBUG_OPTS=" -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n "
fi
JAVA_JMX_OPTS=""
if [ "$1" = "jmx" ]; then
    JAVA_JMX_OPTS=" -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false "
fi
JAVA_MEM_OPTS=""
BITS=`java -version 2>&1 | grep -i 64-bit`
if [ -n "$BITS" ]; then
    JAVA_MEM_OPTS=" -server -Xmx2g -Xms2g -Xmn256m -XX:PermSize=128m -Xss256k -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection -XX:LargePageSizeInBytes=128m -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 "
else
    JAVA_MEM_OPTS=" -server -Xms1g -Xmx1g -XX:PermSize=128m -XX:SurvivorRatio=2 -XX:+UseParallelGC "
fi


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


# 启动应用
echo -e "Starting the $SERVER_NAME ...\c"

nohup java $JAVA_OPTS $JAVA_MEM_OPTS $JAVA_DEBUG_OPTS $JAVA_JMX_OPTS -classpath $CONF_DIR:$LIB_JARS -jar $JAR_FILE_NAME > /dev/null &

# nohup java $JAVA_OPTS $JAVA_MEM_OPTS $JAVA_DEBUG_OPTS $JAVA_JMX_OPTS -classpath $CONF_DIR:$LIB_JARS -jar $JAR_FILE_NAME > $STDOUT_FILE 2>&1 &

COUNT=0
while [ $COUNT -lt 1 ]; do   
    echo -e ".\c"
    sleep 1 
    if [ -n "$SERVER_PORT" ]; then
        if [ "$SERVER_PROTOCOL" == "dubbo" ]; then
            COUNT=`echo status | nc -i 1 127.0.0.1 $SERVER_PORT | grep -c OK`
        else
            COUNT=`netstat -an | grep $SERVER_PORT | wc -l`
        fi
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
