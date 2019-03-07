- java 线程dump
    ```jstack pid```

- java 堆dump
    ```jmap -dump:live,format=b,file=dump.hprof 24971```

- 查找某个类名出现在那些包下
    ```find . -name "*.jar"|awk '{print "jar -tvf "$1}'|awk '{print $0 "|grep XXX |xargs echo && echo " $NF".txt"}'|sh```

- svn版 　git clean
    ```svn st | grep '^?' | awk '{print $2}' | xargs rm -rf```

