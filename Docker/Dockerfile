FROM ros:noetic-ros-base-focal

SHELL ["/bin/bash", "-c"]

# set the ros version
ENV ROS_DISTRO noetic

# install some useful packages and upgrade existing ones
RUN apt update && apt upgrade -y \
    && apt install -y \
    apt-utils \
    git \
    curl \
    nano \
    vim \
    tmux \
    x11-apps \
    python3-pip \
    python3-catkin-tools \
    python3-vcstool \
    python-is-python3 \
    ros-${ROS_DISTRO}-cv-bridge \
    libqt5websockets5-dev \
    libasound2-dev \
    libsndfile-dev \
    pkg-config \
    qt5-default

# install gstreamer utils required for audio_common
RUN apt update && apt upgrade -y \
    && apt install -y \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libgstreamer-plugins-bad1.0-dev \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    gstreamer1.0-tools \
    gstreamer1.0-x \
    gstreamer1.0-alsa \
    gstreamer1.0-gl \
    gstreamer1.0-gtk3 \
    gstreamer1.0-qt5 \
    gstreamer1.0-pulseaudio

# install ros packages
# see ../docs/installing_ros_packages.md for alternatives
RUN DEBIAN_FRONTEND=noninteractive apt install -y \
    ros-${ROS_DISTRO}-rviz \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep update

# Setup environment
ENV BASE_WS=/root/ws_base
ENV DEV_WS=/root/hri_cacti/ws_dev

# setup
RUN mkdir -p ${BASE_WS}/src

# Change the working directory
WORKDIR ${BASE_WS}/src

# // Clone project dependencies from github
# clone audio common
RUN git clone https://github.com/ros-drivers/audio_common.git

# clone robofleet client 
RUN git clone https://github.com/UTNuclearRobotics/robofleet_client.git -b noetic-main
WORKDIR ${BASE_WS}/src/robofleet_client
RUN git submodule init
RUN git submodule update

# build base catkin workspace
WORKDIR ${BASE_WS}
RUN source /opt/ros/${ROS_DISTRO}/setup.bash \
    && catkin build

# create and build robotfleet flattbuffer packages
RUN source devel/setup.bash \
    && python ${BASE_WS}/src/robofleet_client/scripts/generate/generate_plugin_pkg.py -o ${BASE_WS}/src/robofleet_pkgs -w \
    std_msgs \
    geometry_msgs \
    sensor_msgs \
    audio_common_msgs

RUN source devel/setup.bash \
    && catkin build

# # setup mount location directory and catkin workspace
# WORKDIR ${DEV_WS}
# RUN mkdir src && catkin config --extend ${BASE_WS}/devel && catkin build

# setup .bashrc
SHELL ["/bin/bash", "-l", "-c"]
RUN echo -e "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

# setup .bashrc
SHELL ["/bin/bash", "-l", "-c"]

# copy the entrypoint into the image
COPY ./entrypoint.sh /entrypoint.sh

# run this script on startup
ENTRYPOINT /entrypoint.sh