#!/bin/bash

# Set path to github directory
HRIC_DIRECTORY=$(pwd)
echo " " >> ~/.bashrc
echo "# HRI Cacti Docker Directory" >> ~/.bashrc
echo "export hricacti_DIRECTORY=$HRIC_DIRECTORY" >> ~/.bashrc

# Source docker utility functionssourc
source $HRIC_DIRECTORY/Docker/bash_utils

# source bash rc
. ~/.bashrc