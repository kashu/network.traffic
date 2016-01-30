#!/bin/bash
#Author: kashu
#My Website: https://kashu.org
#Date: 2015-05-10
#Filename: network_traffic.sh
#Description: Display realtime network traffic of $NIC.

if [ -n "$1" ]; then
  NIC="$1"
else
  NIC=eth0
fi

while : ; do
  TIME=`date "+%Y-%m-%d %H:%M:%S"`
  rx_before=`ip -s li sh $NIC|grep -m1 -A1 'RX'|awk '/[[:digit:]]/{print $1}'`
  tx_before=`ip -s li sh $NIC|grep -m1 -A1 'TX'|awk '/[[:digit:]]/{print $1}'`
  #rx_before=`ifconfig $NIC|awk '/RX b/{print $2}'|cut -d':' -f2`
  #tx_before=`ifconfig $NIC|awk '/TX b/{print $6}'|cut -d':' -f2`
  sleep 1
  rx_after=`ip -s li sh $NIC|grep -m1 -A1 'RX'|awk '/[[:digit:]]/{print $1}'`
  tx_after=`ip -s li sh $NIC|grep -m1 -A1 'TX'|awk '/[[:digit:]]/{print $1}'`
  #rx_after=`ifconfig $NIC|awk '/RX b/{print $2}'|cut -d':' -f2`
  #tx_after=`ifconfig $NIC|awk '/TX b/{print $6}'|cut -d':' -f2`
  rx_result=$(((rx_after-rx_before)/1024))
  tx_result=$(((tx_after-tx_before)/1024))
  printf "%-11s%-9s%-15s%-5s   %-15s%-5s\n" \
  `echo "$TIME D_Rate:$rx_result KB/s U_Rate:$tx_result KB/s"`
done
