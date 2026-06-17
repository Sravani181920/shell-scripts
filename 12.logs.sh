#!/bin/bash

USERID=$(id -u) #check if user is sudo user or not
R="\e[31m" #Red color
G="\e[32m" #Green color
Y="\e[33m" #yellow color
N="\e[0m" #normal is white color
LOG_FOLDER="/var/log/shellscrits-logs"
LOG_FILE=$(echo $0 |cut -d "." -f1)
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOG_FOLDER/$LOG_FILE-$TIME_STAMP.log"
VALIDATE(){     #function
    if [ $1 -ne 0 ]
    then
        echo -e "$2... $R Failed $N" # -e indiactes enable coloring and $R is red color and $N is normal color
        exit 1
    else
        echo -e "$2... $G Success $N" 
    fi    
}

echo "Script started executing at: $TIME_STAMP" &>>$LOG_FILE
if [ $USERID -ne 0 ] #sudo user id is always 0
then
    echo "ERROR:: you must be Sudo User to execute this script"
    exit 1 #exit status 1 is for failure and 0 is for success
fi

dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]
then
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "Installing mysql" #function call
else
    echo "mysql is already installed.."
fi

dnf list installed git &>>$LOG_FILE
if [ $? -ne 0 ]
then
    dnf install git -y &>>$LOG_FILE
    VALIDATE $? "Installing git" #function call
else
    echo -e "Git is already $Y installed $N"
fi