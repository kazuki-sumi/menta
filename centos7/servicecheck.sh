services=("nginx")

count=`ps aux | grep $services | grep -v grep | wc -l`
if [ $count == 0 ]; then
 echo "nginxのプロセスが死んでいるので起動します"
 sudo systemctl start nginx
else
 echo "nginxは生きている!"
fi

