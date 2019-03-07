忘了从哪里弄来的，CentOS6安装新版Git的利器：

#安装Git  
yum install -y epel-release  
rpm -ivh https://centos6.iuscommunity.org/ius-release.rpm  
yum list git2u  
yum install -y git2u  
git --version  

可以说是见到过的最简单的办法了

如果是CentOS7，记得更改rpm :  
rpm -ivh https://centos7.iuscommunity.org/ius-release.rpm  
