#!/bin/bash

#!/bin/bash

USERID=$(id -u) #check if user is sudo user or not

VALIDATE(){     #function
    if [ $1 -ne 0 ]
    then
        echo "$2... Failed"
        exit 1
    else
        echo "$2... Success"
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
    echo "Git is already installed"
fi