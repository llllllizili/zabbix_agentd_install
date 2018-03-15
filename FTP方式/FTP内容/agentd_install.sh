zabbix_server=$1
local_ip=$2
echo "start to install..."
sleep 1
#os5
cat /etc/*release | grep -q -i "centos\|rhel\|red hat\|redhat"
if [[ $? -eq 0 ]];then
    cat /etc/*release | grep -q -i "5\."
    if [[ $? -eq 0 ]];then
        sleep 1
        wget -cq ftp://"$zabbix_server"/pub/agent/x64/zabbix-3.0.14-1.el5.x86_64.rpm
        rpm -ivh zabbix-3.0.14-1.el5.x86_64.rpm
        echo "modify the agentd configuration"
        bash agentd_conf.sh "$zabbix_server" "$local_ip"
        if [[ $? -ne 0 ]];then
            echo -e "\033[31m FAILED! \033[0m"
            exit
        fi
        sleep 1
        /etc/init.d/zabbix_agentd start
        chkconfig zabbix_agentd on
        
        echo -e "\033[32m SUCCESSFUL! \033[0m"
        exit
    fi
fi
#os6
cat /etc/*release | grep -q -i "centos\|rhel\|red hat\|redhat"
if [[ $? -eq 0 ]];then
    cat /etc/*release | grep -q -i "6\."
    if [[ $? -eq 0 ]];then
        sleep 1
        wget -cq ftp://"$zabbix_server"/pub/agent/x64/zabbix-3.0.14-1.el6.x86_64.rpm
        rpm -ivh zabbix-3.0.14-1.el6.x86_64.rpm
        echo "modify the agentd configuration"
        bash agentd_conf.sh "$zabbix_server" "$local_ip"
        if [[ $? -ne 0 ]];then
            echo -e "\033[31m FAILED! \033[0m"
            exit
        fi
        sleep 1
        /etc/init.d/zabbix_agentd start
        chkconfig zabbix_agentd on
        echo -e "\033[32m SUCCESSFUL! \033[0m"
        exit
    fi
fi
#os7
cat /etc/*release | grep -q -i "centos\|rhel\|red hat\|redhat"
if [[ $? -eq 0 ]];then
    cat /etc/*release | grep -q -i "7\."
    if [[ $? -eq 0 ]];then
        sleep 1
        wget -cq ftp://"$zabbix_server"/pub/agent/x64/zabbix-3.0.14-1.el7.x86_64.rpm
        rpm -ivh zabbix-3.0.14-1.el7.x86_64.rpm
        echo "modify the agentd configuration"
        bash agentd_conf.sh "$zabbix_server" "$local_ip"
        if [[ $? -ne 0 ]];then
            echo -e "\033[31m FAILED! \033[0m"
            exit
        fi
        sleep 1
        systemctl daemon-reload
        /etc/init.d/zabbix_agentd start
        chkconfig zabbix_agentd on
        echo -e "\033[32m SUCCESSFUL! \033[0m"
        exit
    fi
fi
#notice
cat /etc/*release | grep -q -i "centos\|rhel\|red hat\|redhat"
if [[ $? -ne 0 ]];then
    echo  -e "\033[31m FAILED! \033[0m not support the os release"
fi
