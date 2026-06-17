#!/bin/bash

USERID=$(id -u) #check if user is sudo user or not
R="\e[31m" #Red color
G="\e[32m" #Green color
Y="\e[33m" #yellow color
N="\e[0m" #normal is white color
LOG_FOLDER="/var/log/shellscripts-logs"
LOG_FILE=$(echo $0 |cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOG_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){     #function
    if [ $1 -ne 0 ]
    then
        echo -e "$2... $R Failed $N" # -e indiactes enable coloring and $R is red color and $N is normal color
        exit 1
    else
        echo -e "$2... $G Success $N" 
    fi    
}

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME
if [ $USERID -ne 0 ] #sudo user id is always 0
then
    echo "ERROR:: you must be Sudo User to execute this script"
    exit 1 #other than 0
fi

for PACKAGE in $@ #for loop
do
    dnf list installed $PACKAGE &>>LOG_FILE_NAME
    if [ $? -ne 0 ]
    then
        dnf install $PACKAGE -y &>>LOG_FILE_NAME
        VALIDATE $? "Installing $PACKAGE"
    else
        echo -e "$PACKAGE is already $Y Installed $N"
    fi
done
