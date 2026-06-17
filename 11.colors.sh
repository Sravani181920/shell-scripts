#!/bin/bash

USERID=$(id -u) #check if user is sudo user or not
R="\e[31m" #Red color
G="\e[32m" #Green color
Y="\e[33m" #yellow color
N="\e[0m" #normal is white color

VALIDATE(){     #function
    if [ $1 -ne 0 ]
    then
        echo -e "$2... $R Failed $N" # -e indiactes enable coloring and $R is red color and $N is normal color
        exit 1
    else
        echo -e "$2... $G Success $N"
    fi    
}
if [ $USERID -ne 0 ] #sudo user id is always 0
then
    echo "ERROR:: you must be Sudo User to execute this script"
    exit 1 #exit status 1 is for failure and 0 is for success
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    dnf install mysql -y
    VALIDATE $? "Installing mysql" #function call
else
    echo "mysql is already installed.."
fi

dnf list installed git
if [ $? -ne 0 ]
then
    dnf install git -y
    VALIDATE $? "Installing git" #function call
else
    echo -e "Git is already $Y installed $N"
fi