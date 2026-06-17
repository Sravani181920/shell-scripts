#!/bin/bash
X=$!, Y=$2, Z=$3
echo "All variables passed are:$@"
echo "Number of variables are: $#"
echo "Script name is: $0"
echo "Present working directory is: $PWD"
echo "Home directory of current user is: $HOME"
echo "Which user is running the script: $USER"
echo "Process id of current script is: $$"
sleep 10
echo "Process id of last command in background is: $!"