zabbix_server=$1
local_ip=$2
sed -i /^Server=/c\Server=${zabbix_server} /usr/local/zabbix/etc/zabbix_agentd.conf
sed -i /^ServerActive=/c\ServerActive=${zabbix_server} /usr/local/zabbix/etc/zabbix_agentd.conf
sed -i /^Hostname=/c\Hostname=${local_ip} /usr/local/zabbix/etc/zabbix_agentd.conf
sed -i /Timeout=3/c\Timeout=30 /usr/local/zabbix/etc/zabbix_agentd.conf
sed -i 260i\Include=/usr/local/zabbix/etc/zabbix_agentd.conf.d/*.conf /usr/local/zabbix/etc/zabbix_agentd.conf
sleep 2
rm -rf zabbix-*.rpm
rm -rf agentd_*.sh
