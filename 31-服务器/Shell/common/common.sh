
查询ip地址与主机名
ifconfig | grep "addr:" | grep -v 127.0.0.1 | awk '{split($0,arr);print arr[2]}'| awk '{split($0,arr1,":");printf arr1[2]" "}' && hostname

查询日志文件中某个字符串出现的次数（其中$1/3表示）
for i in `ls | grep catalina-`
    do
        echo "$i" | awk '{printf substr($0,10,length-13)"访问次数: "}'
        cat "$i" | grep dcs. |wc -l | awk '{print int($1/3)}'
    done


linux下获取占用CPU资源最多的10个进程，可以使用如下命令组合：
ps aux|head -1;ps aux|grep -v PID|sort -rn -k +3|head


linux下获取占用内存资源最多的10个进程，可以使用如下命令组合：
ps aux|head -1;ps aux|grep -v PID|sort -rn -k +4|head

批量全局安装
for i in `ls /app/evun/sweet/sweet-ui/node_modules/`
    do
        if [ -a "/usr/local/lib/node_modules/$i" ]; then 
            echo "$i global installed"
        else
        	echo "$i global installing"
            npm install -g "$i"
        fi
    done

生成mybatis mapper 列表
# 1、cd mybatis 目录
for i in `ls .`
    do
        echo  "<mapper resource=\"META-INF/mybatis/$i\"/>"
    done

批量清理maven
for i in `ls .`
    do
        if [[ -d $i ]]; then
            cd $i
            mvn clean
            cd ..
        fi
    done