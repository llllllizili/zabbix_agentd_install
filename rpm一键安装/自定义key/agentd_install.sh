#/usr/bin/bash
#ip= ip addr |grep inet |egrep -v "inet6|127.0.0.1" |awk '{print $2}' |awk -F "/" '{print $1}'

# get server ip

echo -e "\n NOTICE! Check the package net-tools is installed \n "
read -p  "zabbix server ip：" zabbix_server
if [ ! -n "$zabbix_server" ]; then
    echo "you have not input server ip, exit"
    exit 1
fi

# get agent ip
read -p  "local ip: " local_ip
if [ ! -n "$local_ip" ]; then
    echo "you have not input local ip, exit"
    exit 1
fi

echo "start to install..."
sleep 1
#version centos7
#cat /etc/*release | egrep -i "centos|rhel|red hat|redhat"

echo "check os version..."
sleep 1

#os6
cat /etc/*release | grep -q -i "centos\|rhel\|red hat\|redhat"
if [[ $? -eq 0 ]];then
    cat /etc/*release | grep -q -i "6\."
    if [[ $? -eq 0 ]];then
        sleep 1
        rpm -ivh zabbix-3.0.14-1.el6.x86_64.rpm
        echo "modify the agentd configuration"
        sleep 1
        sed -i "/^Server=/c\Server=${zabbix_server}" /usr/local/zabbix/etc/zabbix_agentd.conf
        sed -i "/^ServerActive=/c\ServerActive=${zabbix_server}" /usr/local/zabbix/etc/zabbix_agentd.conf
        sed -i "/^Hostname=/c\Hostname=${local_ip}" /usr/local/zabbix/etc/zabbix_agentd.conf
        sed -i "/Timeout=3/c\Timeout=30" /usr/local/zabbix/etc/zabbix_agentd.conf
        sed -i "260i\Include=/usr/local/zabbix/etc/zabbix_agentd.conf.d/*.conf" /usr/local/zabbix/etc/zabbix_agentd.conf
        /etc/init.d/zabbix_agentd start
        chkconfig zabbix_agentd on
        echo "SUCCESSFUL !"
        exit
    fi
fi

#os7
cat /etc/*release | grep -q -i "centos\|rhel\|red hat\|redhat"
if [[ $? -eq 0 ]];then
    cat /etc/*release | grep -q -i "7\."
    if [[ $? -eq 0 ]];then
        sleep 1
        rpm -ivh zabbix-3.0.14-1.el7.centos.x86_64.rpm
        echo "modify the agentd configuration"
        sleep 1
        sed -i "/^Server=/c\Server=${zabbix_server}" /usr/local/zabbix/etc/zabbix_agentd.conf
        sed -i "/^ServerActive=/c\ServerActive=${zabbix_server}" /usr/local/zabbix/etc/zabbix_agentd.conf
        sed -i "/^Hostname=/c\Hostname=${local_ip}" /usr/local/zabbix/etc/zabbix_agentd.conf
        sed -i "/Timeout=3/c\Timeout=30" /usr/local/zabbix/etc/zabbix_agentd.conf
        sed -i "260i\Include=/usr/local/zabbix/etc/zabbix_agentd.conf.d/*.conf" /usr/local/zabbix/etc/zabbix_agentd.conf
        systemctl daemon-reload
        /etc/init.d/zabbix_agentd start
        chkconfig zabbix_agentd on
        echo "SUCCESSFUL !"
        exit
    fi
fi

#os5
cat /etc/*release | grep -q -i "centos\|rhel\|red hat\|redhat"
if [[ $? -eq 0 ]];then
    cat /etc/*release | grep -q -i "5\."
    if [[ $? -eq 0 ]];then
        sleep 1
        rpm -ivh zabbix-3.0.14-1.el7.centos.x86_64.rpm
        echo "modify the agentd configuration"
        sleep 1
        sed -i "/^Server=/c\Server=${zabbix_server}" /usr/local/zabbix/etc/zabbix_agentd.conf
        sed -i "/^ServerActive=/c\ServerActive=${zabbix_server}" /usr/local/zabbix/etc/zabbix_agentd.conf
        sed -i "/^Hostname=/c\Hostname=${local_ip}" /usr/local/zabbix/etc/zabbix_agentd.conf
        sed -i "/Timeout=3/c\Timeout=30" /usr/local/zabbix/etc/zabbix_agentd.conf
        sed -i "260i\Include=/usr/local/zabbix/etc/zabbix_agentd.conf.d/*.conf" /usr/local/zabbix/etc/zabbix_agentd.conf
        /etc/init.d/zabbix_agentd start
        chkconfig zabbix_agentd on
        echo "SUCCESSFUL !"
        exit
    fi
fi

#notice
cat /etc/*release | grep -q -i "centos\|rhel\|red hat\|redhat"
if [[ $? -ne 0 ]];then
    echo  "FAILED ! not support the os release"
fi
