#!/bin/sh
#######################################################
# 问题地址 : https://www.shiyanlou.com/challenges/3883
# @free -g可以直接以GB格式查看内存，同理 free -m
# 
# 
# 
#######################################################

#获取cpu个数
cpu_num=`cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l`
echo "cpu num: "$cpu_num

#内存（memory total），单位为 GB
memory_total_kb=`cat /proc/meminfo | grep "MemTotal" | awk {'print $2'} `
memory_total_gb=`echo "sclae=2; $memory_total_kb/ 1024 / 1024" | bc`
echo "memory total: "${memory_total_gb}G

#memory free 单位为 MB
memory_free_kb=`cat /proc/meminfo | grep "MemFree" | awk {'print $2'} `
memory_free_gb=`echo "sclae=2; $memory_free_kb / 1024" | bc`
echo "memory free: "${memory_free_gb}M

#disk_size
disk_size=`df -h | sed -n 3p | awk '{print $1}'`
echo "disk size: "$disk_size

#系统位数（system bit）
system_bit=`getconf LONG_BIT`
echo "system bit: "$system_bit

#当前系统正在运行的进程数（process）
process_num=`ps auxw | wc -l`
echo "process: "$process_num

#查看已安装的软件包数量（software num）
yum_installed_num=`yum list installed |wc -l`
echo "software num: "$yum_installed_num

#eth0的ip地址（ip）
eth0_ip=`ifconfig eth0 | sed -n 2p | awk -F ":" '{print $2}' | awk '{print $1}'`
echo "ip: "$eth0_ip

