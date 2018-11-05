#!/usr/bin/env bash

docker ps -a|grep php72 |awk '{print $1}'|xargs docker kill >/dev/null 2>&1
docker ps -a|grep php72 |awk '{print $1}'|xargs docker rm >/dev/null 2>&1

#启动php72
SVR_IP=$(/sbin/ifconfig | grep "inet addr" | grep -v "192.168" | grep -v "127.0.0.1" | sed -n 's/^.*addr:\(1*.*\) [[:space:]]Bcast:.*/\1/p' | head -1 2>/dev/null)

docker run --name php72 \
-d \
-v /data/wwwroot:/data/wwwroot \
-v /var/log:/www_logs/   \
-p 9002:9000 \
--add-host=xx.xx.com:$SVR_IP \
-v /data/docker/php72/etc:/usr/local/etc \
--restart=always \
registry.cn-beijing.aliyuncs.com/leojen/php71
