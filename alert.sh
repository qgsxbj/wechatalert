#!/bin/sh
process_name="AleiyeBigDataServer"
server_arry="NameNode,ResourceManager,SecondaryNameNode,kafka,Elasticsearch,apsc-monitor-service-4.0.2-SNAPSHOT.war,apsc-tableau-4.0.1-SNAPSHOT.war,apsc-eureka-server-4.0.1-SNAPSHOT.war,apsc-gateway-4.0.2-SNAPSHOT.war,apsc-security-4.0.2-SNAPSHOT.war,apsc-monitor-collect-4.0.1-SNAPSHOT.war,apsc-gateway-oauth-4.0.2-SNAPSHOT.war,AleiyeDBCollectorMain,impala,kudu"

OLD_IFS="$IFS"
IFS=","
arr=($server_arry)
IFS="$OLD_IFS"
for s in ${arr[@]}
do
	status=-1
  	#ps命令根据进程名和服务名判断进程是否正常，正常status为0 异常status为1
  	ps -ef|grep $s | grep -v "grep" > /dev/null
  	if [ $? -eq 0 ];then
    		status=0
  	else
    		status=1
    		python3 /home/leoqin/monitor/alert/alertwehchat.python $process_name $s 
  	fi
  	echo $process_name $s status is $status
done
