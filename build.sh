#!/usr/bin/sh   

#进程关键字
processName="insurance-after"
#项目启动命令
projectCmd=target/${processName}-1.0-SNAPSHOT.jar
startCmd="java -jar $projectCmd"
#拉取代码
git checkout .
echo "------- 拉取代码 ---------"
expect <<EOF  
spawn git pull
expect "Username*"
send "xiaozhongting\r"
expect "Password for*"
send "zx27892509\r"
expect eof
EOF

#编译
if mvn package; then
  echo "----------- mvn package 成功 -----------"
else
    echo "----------- mvn package 失败 ----------"
    exit
fi

# 关闭之前的进程
ps aux | grep ${processName}
processId=$(ps aux | grep ${processName}  |awk '{print $2}' | tr "\n" " ")  
echo $processId
kill -9 ${processId}

# # 后台启动项目
echo $startCmd
nohup $startCmd &