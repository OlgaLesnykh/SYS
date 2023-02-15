#!/bin/bash
result="/var/log/syslog"
echo "Enter ip address:"
read ip_addr
echo "Enter port number:"
read port
	telnet $ip_addr $port &> $result & sleep 10
if cat $result |grep Unable; then
	echo "Port unable";
else
	echo "Port available";
fi;
