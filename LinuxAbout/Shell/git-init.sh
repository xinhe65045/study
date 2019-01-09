#!/bin/sh

prefix=http://git.evun.cn/gap2/
basePath=`dirname $0`

repos[0]=gap
repos[1]=gap-service-app
repos[2]=gap-platform-home
repos[3]=gap-service-tenant
repos[4]=gap-service-user
repos[5]=gap-platform-developer
repos[6]=gap-platform-admin
repos[7]=gap-service-auth
repos[8]=gap-common
repos[9]=gap-web-mc
repos[10]=gap-web-uc
repos[11]=gap-platform-oss
repos[12]=gap-service-sms
repos[13]=gap-web-oc
repos[14]=gap-service-storage
repos[15]=doc

# clone函数
function doClone(){
	if [ ! -d ./${1} ]; then
    	git clone ${prefix}/${1}.git
	fi
}

function initAll(){	
	for repo in ${repos[*]}
	do
	    doClone $repo
	done
}

function doPull(){
	if [ ! -d ./${1} ]; then
    	git clone ${prefix}/${1}.git
	else 
		cd ./${1}
		echo "pull ${1}"
		git pull
		echo "==================================================================================="
		echo ""
		cd ..
	fi
}


function pullAll(){
	for repo in ${repos[*]}
	do
	    doPull $repo
	done
}

function mvnuciAll(){
	pullAll
	cd gap
	mvn -U clean install
}

function doTest(){
	for repo in ${repos[*]}
	do
	    echo $repo
	done
}

# 跳转至当前目录
cd ${basePath}



case $1 in
 
        init)
          initAll
        ;;
       
        pull)  
          pullAll
        ;;
       
        test)
           doTest   
        ;;

        mvnci)
			mvnuciAll
		;;
       
        *)
           pwd
        ;;
esac    
exit 0
