# 基本教程
- SA包含在$JAVA_HOME/lib/sa-jdi.jar中，包括三个工具:
```
    1.CLHSDB:命令行版本
    java -cp .:$JAVA_HOME/lib/sa-jdi.jar sun.jvm.hotspot.CLHSDB

    2.HSDB:图形界面版本
    java -cp .:$JAVA_HOME/lib/sa-jdi.jar sun.jvm.hotspot.HSDB

    3.JSDB:Javascript引擎版本
    java -cp .:$JAVA_HOME/lib/sa-jdi.jar sun.jvm.hotspot.tools.soql.JSDB
```

- 用途
```
    SA的一个限制是它只实现了调试snapshot的功能,因此要么要让被调试的目标进程完全暂停，要么就调试core dump;另外注意，SA调试通常要求拥有root权限，否则会报错；
```

- 调试本地进程
    - 获取要调试的进程ID:
    ```
        ps -ef|grep java
        jps -mvl
    ```

    - attch进程
    ```
        java -cp .:$JAVA_HOME/lib/sa-jdi.jar sun.jvm.hotspot.CLHSDB
        attach PID
        或
        sudo java -cp .:$JAVA_HOME/lib/sa-jdi.jar sun.jvm.hotspot.HSDB
        通过菜单"File"->"Attach to HotSpot process"，录入PID
    ```

- 调试远程进程
    - 远程机器上启动rmiregistry服务；
    ```
        rmiregistry -J-d64 -J-Xbootclasspath/p:${JAVA_HOME}/lib/sa-jdi.jar
                        或
        rmiregistry -J-Xbootclasspath/p:${JAVA_HOME}/lib/sa-jdi.jar
    ```
    - 启动debug server:
    ```
        客户端通过机器名称连接到debug server进行调试，默认情况下，当只启动一个debug server时，机器名称为ip地址；
        java -d64 -classpath ${JAVA_HOME}/lib/sa-jdi.jar sun.jvm.hotspot.jdi.SADebugServer <pid>
                    或
        java -d64 -classpath ${JAVA_HOME}/lib/sa-jdi.jar sun.jvm.hotspot.jdi.SADebugServer <java executable> <core file>
    ```

- 调试core dump
    ```
        java -cp .:$JAVA_HOME/lib/sa-jdi.jar sun.jvm.hotspot.CLHSDB $JAVA_HOME/bin/java core-file-name
        注意：为了使Java程序能够产生core dump,必须设置ulimit -c unlimited,另外在Linux或Solaris下可以通过kill -6 <pid>手工产生core dump。
    ```

    
# DEMO
- 如何查看HotSpot VM的运行时数据(占小狼)http://www.jianshu.com/p/a28ae76ac3b4
