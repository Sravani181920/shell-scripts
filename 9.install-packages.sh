#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]
then
    echo "ERROR:: you must be Sudo User to execute this script"
    exit 1
fi
dnf list installed mysql
if [ $? -ne 0 ]
then
    dnf install mysql -y
    if [ $? -ne 0 ]
    then
        echo "Installing mysql... Failed"
        exit 1
    else
        echo "Installing mysql... Success"
else
    echo "mysql is already installed.."
fi

dnf list installed git
if [ &? -ne 0 ]
then
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "Installing git... Failed"
        exit 1
    else
        echo "Installing git... Success"
else
    echo "Git is already installed"
fi