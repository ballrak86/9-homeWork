#!/bin/bash
echo "Введите путь к каталогу, в котором находится файл apache (по умолчанию /var/log/)"
read directoryLog
if [ -z "$directoryLog" ];then directoryLog="/var/log/";fi

echo "Введите имя файла лога apache (по умолчанию access_log)"
read fileLog
if [ -z "$fileLog" ];then fileLog="access_log";fi

fullName=$(find $directoryLog -name $fileLog)

while [ -z "$rootMail" ]
do
echo "Введите email на который вы будете получать письма, он не может быть пустым"
read rootMail
done

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
chmod +x $SCRIPT_DIR/parsingHttpdLog.sh
chmod +x $SCRIPT_DIR/trap.sh
echo "0 * * * * root $SCRIPT_DIR/trap.sh $fullName $rootMail" >> /etc/crontab

echo "Для отправки почты используется mutt, просьба настройте его у себя. Спасибо"