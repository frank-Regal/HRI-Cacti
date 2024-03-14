# Set path to current github directory
CUR_DIR=$(pwd)

# Setup username and id
USERNAME=$(whoami)
CURR_ID=$(id -u)

# Write to bashrc
echo " " >> ~/.bashrc
echo "# HRI Cacti Docker Directory" >> ~/.bashrc
echo "export HRI_CACTI_GIT_DIR=$CUR_DIR" >> ~/.bashrc
echo "source $CUR_DIR/Docker/bash_utils" >> ~/.bashrc
echo "export UNAME=$USERNAME" >> ~/.bashrc
echo "export UID_GID=$CURR_ID" >> ~/.bashrc