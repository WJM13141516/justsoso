#!/bin/bash
#-------------------------------------------
#这是一个注释
#此版本加入pushplus的推送设置，新增一个需要隐藏的变量token
#token可以在pushplus官网免费获取
# http://www.pushplus.plus/
#若要运行此文件，请将.github/workflow/autopush.yml开启
#
#-------------------------------------------
uid=$1
upw=$2
token=$3
uidarr=(${uid//,/ }) #字符串预处理
upwarr=(${upw//,/ })
num=${#uidarr[@]}
title="今日已填报"
smbtn="进入健康状况上报平台"
url1="https://jksb.v.zzu.edu.cn/vls6sss/zzujksb.dll/login"
url2="https://jksb.v.zzu.edu.cn/vls6sss/zzujksb.dll/jksb"
url3="http://www.pushplus.plus/send"
for((i=0;i<num;i++))
do
curl -d "uid=${uidarr[i]}&upw=${upwarr[i]}&smbtn=$smbtn&hh28=907" -s $url1 -o temp.txt
udata=$(sed -n '11p' temp.txt)
udata=${udata#*ptopid=}
udata=${udata%\"\}\}*}
ptopid="${udata%&*}"
sid="${udata#*&sid=}" #登录获取ptopid和sid
sleep 2
curl -d "ptopid=$ptopid&sid=$sid&fun2=" -s $url2 -o temp1.txt #获取fun18
udata=$(sed -n '33p' temp1.txt)
udata=${udata#*fun18\"}
udata=${udata#*value=\"}
fun18="${udata%%\"*}" 
sleep 2
curl -d "did=1&men6=a" -d "fun18=$fun18&ptopid=$ptopid&sid=$sid" -s $url2 -o /dev/null #进入确认界面
sleep 2
curl -d "@myvs.txt" -d "fun18=$fun18&ptopid=$ptopid&sid=$sid" -s $url2 -o temp.txt #打卡
udata=$(sed -n '24,26p' temp.txt)
echo "$udata" > result.html
content=$(sed -n "24p" temp.txt | awk -F'<li>' '{ print $2}' | awk -F'</li>' '{ print $1}' ) #获取推送内容
json="{\"token\":\"$token\",\"title\":\"$title\",\"content\":\"$content\" }" #建立json文件
curl -H "Content-Type:application/json" -X POST  -d "$json"  $url3 #push
done


