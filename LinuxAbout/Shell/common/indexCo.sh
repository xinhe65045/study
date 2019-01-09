#!/bin/sh

# 跳转至当前目录
cd `dirname $0`

function show()
{
 
    for i in `ls | grep catalina-`
    do
        echo "$i" | awk '{printf substr($0,10,length-13)"首页访问次数: "}'
        cat "$i" | grep /dms/indexCo.do |wc -l | awk '{print int($1/3)}' 
    done
 
}

show