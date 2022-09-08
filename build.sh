#!/bin/sh

branch="dev"
#进程关键字
processName="insurance-after"
#项目启动命令
projectCmd=target/${processName}-1.0-SNAPSHOT.jar
startCmd="java -jar $projectCmd"
#进去fish
#fish

#拉取代码
git checkout .
git pull origin ${branch}
expect "appUsername for"
send "cd xiaozhongting\r"
expect "Password for"
send "cd zx27892509\r"

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

# 后台启动项目
echo $startCmd
nohup $startCmd &