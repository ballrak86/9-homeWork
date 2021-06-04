#!/bin/bash
#####################################################
#                   functions                       #
#####################################################
findXIp(){
echo "Адреса клиентов которые сделали запрос" >> /tmp/$HOSTNAME
grep $pastHour $fullFileName | cut -f1 -d' ' | sort |  uniq -c | sort -rn >> /tmp/$HOSTNAME
echo -e "\n\n" >> /tmp/$HOSTNAME
}

findYIp(){
echo "Что запросили клиенты" >> /tmp/$HOSTNAME
grep $pastHour $fullFileName | grep "HTTP/1.1" | cut -f2 -d'"' | cut -f2 -d' ' | sort | uniq -c | sort -nr >> /tmp/$HOSTNAME
echo -e "\n\n" >> /tmp/$HOSTNAME
}

findErrorCode(){
echo "Коды ошибок 4ХХ и 5ХХ и их количество" >> /tmp/$HOSTNAME
grep $pastHour $fullFileName | grep 'HTTP/1.1" [45]' | sed 's|.*HTTP/1.1" \([0-9][0-9][0-9]\).*|\1|' | sort | uniq -c | sort -nr >> /tmp/$HOSTNAME
echo -e "\n\n" >> /tmp/$HOSTNAME
}

findAllCode(){
echo "Все коды ответов и их количество" >> /tmp/$HOSTNAME
grep $pastHour $fullFileName | grep 'HTTP/1.1"' | sed 's|.*HTTP/1.1" \([0-9][0-9][0-9]\).*|\1|' | sort | uniq -c | sort -nr >> /tmp/$HOSTNAME
echo -e "\n\n" >> /tmp/$HOSTNAME
}

#####################################################
#                    programm                       #
#####################################################
> /tmp/$HOSTNAME
fullFileName=$1
eMail=$2
pid_file=$3
pastHour=$(date "+%d/%b/%Y:%H" -d '-1 hour')
echo "$$" > $pid_file
findXIp
findYIp
findErrorCode
findAllCode
echo "${pastHour}:00:00 - ${pastHour}:59:59" |  mutt -s "$HOSTNAME" -i /tmp/$HOSTNAME -- $eMail
rm -f $pid_file