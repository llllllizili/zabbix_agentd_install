#/usr/bin/bash
#ip= ip addr |grep inet |egrep -v "inet6|127.0.0.1" |awk '{print $2}' |awk -F "/" '{print $1}'


# get server ip
read -p  "zabbix server ip：" zabbix_server
if [ ! -n "$zabbix_server" ]; then
    echo "you have not input server ip, exit"
    exit 1
fi

#download agentd.conf
wget -cq ftp://"$zabbix_server"/pub/agentd_conf.sh
wget -cq ftp://"$zabbix_server"/pub/agentd_install.sh

# get agent ip
read -p  "local ip: " local_ip
if [ ! -n "$local_ip" ]; then
    echo "you have not input local ip, exit"
    exit 1
fi

bash agentd_install.sh "$zabbix_server" "$local_ip"
