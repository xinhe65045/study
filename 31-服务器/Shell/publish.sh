#!/bin/sh

function publish(){
	 echo "coping $2 !"

	 cp ${1} ./publish/

	 echo "copied $2 !"

}

rm -rf /app/evun/dms-next/publish/*

## ============================================【】============================================ ##

# 通知子系统
publish Notify/notify-service/target/notify-service.jar notify-service

# DMS认证子系统
publish DMS-Passport/passport-service/target/dms-passport-service.jar dms-passport-service

# DCS认证子系统
# publish DCS-Passport/passport-service/target/dcs-passport-service.jar dcs-passport-service


# DMS分析子系统
publish DMS-Analyze/analyze-service/target/dms-analyze-service.jar dms-analyze-service

# DCS分析子系统
publish DCS-Analyze/analyze-service/target/dcs-analyze-service.jar dcs-analyze-service

## ============================================【】============================================ ##

# DMS基础数据
publish DMS-BaseInfo/baseinfo-service/target/dms-baseinfo-service.jar dms-baseinfo-service

# DMS售前子系统
publish DMS-PreSales/presales-service/target/dms-presales-service.jar dms-presales-service

# DMS售后子系统



# DCS基础数据

# DCS售前子系统

# DCS售后子系统

## ============================================【】============================================ ##

# Timer

# AppCenter
publish AppCenter/appcenter-service/target/appcenter-service.jar appcenter-service
publish AppCenter/appcenter-web/target/appcenter.war appcenter-web

# OpenApi

