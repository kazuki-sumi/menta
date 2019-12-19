#!/bin/bash
# */1 * * * * sh /home/servicecheck.sh

PROCESSNAME01=nginx

count=`pgrep $PROCESSNAME01 | wc -l`
if [ $count == 0 ]; then
 echo "nginxのプロセスが死んでいるので起動します"
 sudo systemctl start nginx
else
 echo "nginxは生きている!"
fi

