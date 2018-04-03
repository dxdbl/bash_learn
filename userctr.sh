#!/bin/bash
#######################################################
# 问题地址 : https://www.shiyanlou.com/challenges/3883
# @free -g可以直接以GB格式查看内存，同理 free -m
# 
# 
# 
#######################################################

UserCtr=$1
TeacherName=$2
StudentName=$3
StudentNumber=$4

Usage(){
cat<<EOF
--Usage:
        $0 [add/del] [Teacher'sName] [Student'sName] [The number of Students]
        ex.
        $0 add teacher stu 3
--
        add:useradd username
        del:userdel username
        [Teacher'sName]:teacher's name
        [Student'sName]:student's name,just only the beginning of a lowercase letter 
        [The number of Students],only [1-10]
EOF
}

if [ $# -eq 4 ];then
        if [ $1 == "add" ];then
                #echo "add"
                if [[ "$2" =~ ^[a-z]+$  &&  "$3" =~ ^[a-z]+$  && "$4" -ge 1 && "$4" -le 10 ]];then
                        #create user $2
                        id $2 >>/dev/null 2>&1
                        if [ $? -ne 0 ];then
                                useradd $2
                                TeacherPasswd=$(date|md5sum|cut -c 1-6)
                                echo $TeacherPasswd|passwd --stdin $2 >>/dev/null 2>&1
                                echo "User [$2] create successfully."
                                echo "$2:$TeacherPasswd"
                        else
                                echo "The user [$2] is exist."
                        fi
                        for ((num=1;num<=$4;num++));do
                                id ${3}${num} >>/dev/null 2>&1
                                if [ $? -ne 0 ];then
                                        useradd ${3}${num}
                                        StudentPasswd=$(echo $RANDOM|md5sum|cut -c 1-6)
                                        echo $StudentPasswd|passwd --stdin ${3}${num} >>/dev/null 2>&1
                                        echo "User [${3}${num}] create successfully."
                                        echo "${3}${num}:$StudentPasswd"
                                else
                                        echo "The user [${3}${num}] is exist."
                                fi
                        done
                else
                        echo "Parameter error!"
                        exit 10000
                fi
        elif [ $1 == "del" ];then
                echo "Please delete user manually."
        else
                echo "Parameter error!Please input [add] or [del]."
                exit 10086
        fi
else
        Usage
fi
