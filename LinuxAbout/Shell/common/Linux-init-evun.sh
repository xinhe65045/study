#!/bin/bash
# -------------------------------------------------------------------
# Filename :  Linux-init-evun.sh
# Create Date：2016/06/20
# Description：This Scripts is initialization for Linux CentOS6.X.
# Notes：you must run this scripts by root user.
# -------------------------------------------------------------------
# Copyright: 2016 (c) changbin.miao@geely.com
# -------------------------------------------------------------------
# Update：2016/07/08
# Revision：4.10
# Revision description：add local yum configuation and some plms.

#welcome
cat << EOF
+--------------------------------------------------------------+
|         === Welcome to Linux System init ===                 |
|      === you must run this script by root user ===           |
+--------------------------------------------------------------+
EOF

# you mast run it with user root
if [ $(id -u) != "0" ]; then
    echo "Error: Please run this script by user root, exit..."
    exit 1
fi

if [ -f /var/log/Linux-system-init.lock ]
then
    echo "This Scripts is aleary run at `cat /var/log/Linux-system-init.lock` "
    exit $FILE_ERR
    fi 

# Optimization the ssh connect.
optimization_ssh()
{
    cp /etc/ssh/sshd_config{,.bak-$(date +%Y%m%d%H%M%S)}
    echo "Optimization the ssh..."
    [ -e /etc/ssh/sshd_config ] && sed -i '/GSSAPIAuthentication/s/.*/#&/' /etc/ssh/sshd_config
    echo "GSSAPIAuthentication no"  >>/etc/ssh/sshd_config
    #echo "PermitRootLogin no" >> /etc/ssh/sshd_config
    echo "UseDNS no"    >>/etc/ssh/sshd_config
    #echo "Port 51255" >> /etc/ssh/sshd_config
    echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config
    
    echo "Set the SSH off time:1800s..."
    #echo "ClientAliveInterval 600"  >> /etc/ssh/sshd_config
    #echo "ClientAliveCountMax 3"  >> /etc/ssh/sshd_config
    
    /etc/init.d/sshd restart
    #lsof -i tcp:51255
}

modify_timezone()
{
cp /etc/sysconfig/clock{,.bak-$(date +%Y%m%d%H%M%S)}
cat >>/etc/sysconfig/clock<<EOF
ZONE="Asia/Shanghai"
UTC=false
ARC=false
EOF
    cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    sed -i 's/^[ \t]*//' /etc/sysconfig/clock
}

#Timing synchronization time from the NTP server
sync_time()
{
    cp /etc/crontab{,.bak-$(date +%Y%m%d%H%M%S)}
    echo "Synchronization time..."
    echo "/usr/sbin/ntpdate 10.86.1.76"  >> /etc/rc.local
    echo "*/5 * * * * /usr/sbin/ntpdate 10.86.1.76 >> /home/timedate.log && hwclock -w && hwclock --show >> /home/timedate.log" >> /var/spool/cron/root
    echo "End synchronization time!!!"
}

# set the hint for the server
set_hint()
{
cat >>/root/.bash_profile<<EOF
alias grep='grep --color=auto'
echo "This is the $HOSTNAME (`ifconfig | egrep -A 1 "eth[0-9]" | tail -n 1 | awk '{print $2}' | sed 's/addr://g'`)"
w
df -Th
ps -ef |grep tomcat
EOF
.  /root/.bash_profile
}

# set the character for system.
modify_character()
{
    cp /etc/sysconfig/i18n{,.bak-$(date +%Y%m%d%H%M%S)}
    echo "set the character for system..."
    [ -e /etc/sysconfig/i18n ] && sed -i '/^LANG=/s/.*/LANG="zh_CN.UTF-8"/' /etc/sysconfig/i18n
    echo "End set the Character for this system!!!"   
}

# shutdown the selinux
disable_selinux()
{
    cp /etc/selinux/config{,.bak-$(date +%Y%m%d%H%M%S)}
    echo "Disable selinux..."
    [ -e /etc/selinux/config ] && sed -r -i '/^SELINUX=/s/.*/SELINUX=disabled/' /etc/selinux/config
    setenforce 0
    echo "End disable selinux!!!"    
}

# set the time when the command exec for history
modify_history()
{
    cp /etc/bashrc{,.bak-$(date +%Y%m%d%H%M%S)}
    echo "modify history command..."
    [ -e /etc/bashrc ] && echo "HISTFILESIZE=2000" >> /etc/bashrc
    echo "HISTFILESIZE=2000" >> /etc/bashrc
    echo "HISTSIZE=2000" >> /etc/bashrc
    echo "HISTTIMEFORMAT='<%F %T> : '" >> /etc/bashrc
    echo "End modify the history set!!!"    
}

# disable the iptables
disable_iptables()
{
    cp /etc/sysconfig/iptables{,.bak-$(date +%Y%m%d%H%M%S)}
    echo "Disable iptables..."
    [ -e /etc/sysconfig/iptables ] && iptables -F 
    service iptables save
    service iptables stop
    chkconfig iptables off
    echo "End disabled the iptables!!!"  
}

#Forbid the "Control-Alt-Delete"
disable_control_alt_delete()
{
    echo "Disable Control-Alt-Delete..."
    sed -i '/ca::ctrlaltdel:/{s/^/#/}' /etc/inittab   
    echo "End disable Control-Alt-Delete!!!"
}

# set the Linux start for command mode.
change_inittab()
{
    cp /etc/inittab{,.bak-$(date +%Y%m%d%H%M%S)}
    echo "Change inittab..."
    sed -r -i '/^id/s/.*/id:3:initdefault:/' /etc/inittab
    echo "End change inittab!!!"
}

# Create the default user evun.
user_add()
{
    useradd zabbix -s /sbin/nologin
    useradd evun
    echo "GeelyEvun!2$" | passwd --stdin evun  && history -c
#   chage -d 0 evun  #强制用户登录必须修改密码
}

#锁定不必要的用户
lock_user()
{
    cp /etc/passwd{,.bak-$(date +%Y%m%d%H%M%S)}
    echo "Lock users for system..."
    for user in adm lp sync shutdown halt mail news uucp operator games gopher ftp
    do
        usermod -L $user
    done
    echo "End lock users for system!!!"
}

#删除不必要的组
del_group()
{
    echo "Delete groups for system..."
    for group in adm lp mail uucp news games slipusers dip ppusers popusers
    do
        groupdel $group
    done
}

##lock file
lock_file()
{
    echo "lock the file ..."
    chattr +i /etc/passwd
    chattr +i /etc/inittab
    chattr +i /etc/group
    chattr +i /etc/shadow
    chattr +i /etc/gshadow
    mv /usr/bin/chattr /usr/bin/evunchattr
    #unlock the file   evunchattr -i /etc/passwd /etc/inittab /etc/group /etc/shadow /etc/gshadow
    echo "End lock the file passwd group shadow gshadow inittab"
}


#关闭不需要的服务
modify_chkconfig()
{
    echo "Modify chkconfig for the system..."
    for a in `chkconfig --list|grep 0:|awk '{print $1}'`
    do
        case "$a" in
            "acpid"    ) STATUS=on;;
            "crond"    ) STATUS=on;;
            "haldaemon" ) STATUS=on;;
            "klogd"    ) STATUS=on;;
            "lvm2-monitor" ) STATUS=on;;
            "messagebus"   ) STATUS=on;;
            "network" ) STATUS=on;;
            "syslog"  ) STATUS=on;;
            "rsyslog" ) STATUS=on;;
            "sshd"    ) STATUS=on;;
            "sysstat" ) STATUS=on;;
            "udev-post" ) STATUS=on;;
            "irqbalance" ) STATUS=on;;
            "xinetd" ) STATUS=on;;
            * ) STATUS=off;;
        esac
            /sbin/chkconfig --level 2345 $a $STATUS
    done
    echo "End modify chkconfig!!!"
}

#set the umask
change_profile()
{
    cp /etc/profile{,.bak-$(date +%Y%m%d%H%M%S)}
    echo "Change the /etc/profile file..."
    echo "umask 022" >>/etc/profile
    echo "TMOUT=6000" >>/etc/profile
    echo "export TMOUT" >>/etc/profile
    echo "End change profile!!!"
}

#optimization the kernel
sysctl_init()
{
    cp /etc/sysctl.conf{,.bak-$(date +%Y%m%d%H%M%S)}
    echo "Optimizing the kernel..."
    cat >>  /etc/sysctl.conf << EOF
#kernel
    kernel.sysrq = 0
    kernel.core_uses_pid = 1
    kernel.msgmnb = 65536
    kernel.msgmax = 65536
    kernel.shmmax = 68719476736
    kernel.shmall = 4294967296
#file
    fs.file-max = 1024000
#socket
    net.ipv4.ip_local_port_range = 1024 65000
    net.ipv4.ip_forward = 0
    net.ipv4.tcp_timestamps = 0
    net.ipv4.tcp_sack = 1
    net.ipv4.tcp_window_scaling = 1
    net.ipv4.conf.default.rp_filter = 1
    net.ipv4.conf.default.accept_source_route = 0
#socket mem
    net.ipv4.tcp_mem = 94500000 915000000 927000000
    net.ipv4.tcp_rmem = 4096        873800   41943040
    net.ipv4.tcp_wmem = 4096        163840   41943040
    net.core.wmem_default = 83886080
    net.core.rmem_default = 83886080
    net.core.rmem_max = 167772160
    net.core.wmem_max = 167772160
#conn
    net.core.somaxconn = 1024000
    net.core.netdev_max_backlog = 1624000
    net.ipv4.tcp_max_orphans = 3276800
#Timewait
    net.ipv4.tcp_max_tw_buckets = 1024000
    net.ipv4.tcp_tw_reuse = 1
    net.ipv4.tcp_tw_recycle = 1
#sync
    net.ipv4.tcp_syncookies = 1
    net.ipv4.tcp_max_syn_backlog = 1024000
    net.ipv4.tcp_synack_retries = 1
    net.ipv4.tcp_syn_retries = 1
#fin
    net.ipv4.tcp_fin_timeout = 1
#keepalive
    net.ipv4.tcp_keepalive_time = 30
EOF
    /bin/chown root:root /etc/sysctl.conf
	/bin/chmod 0600 /etc/sysctl.conf	
	sysctl -p
    echo "End optimizing the kernel!!!"
}

# set the socket limit
limit_handle()
{
	cp /etc/security/limits.conf{,.bak-$(date +%Y%m%d%H%M%S)}
	echo "Modified max num file handle limit..."
	echo "*	soft	nofile	65535"	>> /etc/security/limits.conf
	echo "*	hard	nofile	65535"	>> /etc/security/limits.conf
	echo "*	-	nproc	unlimited"	>> /etc/security/limits.conf
    echo "*  soft  nproc  unlimited" >>/etc/security/limits.d/90-nproc.conf  
	echo "session	required	/lib64/security/pam_limits.so" >>/etc/pam.d/login
    ulimit -SHn 65535
cat >> /etc/rc.local <<EOF
ulimit -HSn 65535
ulimit -s 65535
EOF
echo "End modified maximum file handle limit!!!"
}

#config the local yum 
yum_conf ()
{
    echo "config the local yum ..."
    mkdir /etc/yum.repos.d/bak
    mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak
    wget -P /etc/yum.repos.d/ http://10.86.87.142/evunsoft/yum/CentOS6-evun.repo 
    yum clean all
    yum makecache
    yum -y install ntpdate sysstat dstat iotop ntop cronolog nmon nethogs nmap nc
    yum -y remove ntp
    echo "End config the local yum !"
}

#定义函数
init_server()
{
    optimization_ssh
    sync_time
    set_hint
    modify_character
    modify_timezone
    disable_selinux
    modify_history
    disable_iptables
    disable_control_alt_delete
    change_inittab
#    user_add
    lock_user
    del_group
    lock_file
    modify_chkconfig
    change_profile
    sysctl_init
    limit_handle
    yum_conf
    echo "All done!!"
}

# call the function init_server.
echo "Now going to the function safety!"
init_server
echo "Back from the function!"
echo "`date +%Y%m%d%H%M`"  >  /var/log/Linux-system-init.lock
