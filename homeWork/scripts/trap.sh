#!/bin/bash
pid_file="/tmp/pidScript"
while [ -f $pid_file ]
  do
   echo "Идет фоновый процесс - ждем 300 секунд"
   sleep 300
done
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
$SCRIPT_DIR/parsingHttpdLog.sh $1 $2 $pid_file