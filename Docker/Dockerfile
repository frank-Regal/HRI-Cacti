FROM ros:noetic-ros-base-focal

SHELL ["/bin/bash", "-c"]

# set the ros version
ENV ROS_DISTRO noetic
ENV PROJ_HUB project

# install some useful packages and upgrade existing ones
RUN apt-get update && apt-get upgrade -y \
    && apt install -y \
    apt-utils \
    git \
    curl \
    nano \
    vim \
    tmux \
    wget \
    x11-apps \
    python3-pip \
    python3-catkin-tools \
    python3-vcstool \
    python-is-python3 \
    ros-${ROS_DISTRO}-cv-bridge \
    ros-${ROS_DISTRO}-vision-opencv \
    libqt5websockets5-dev \
    libasound2-dev \
    libsndfile-dev \
    pkg-config \
    qt5-default \
    gcc \
    cmake \
    qt5-qmake

# install gstreamer utils required for audio_common
RUN apt-get update && apt-get upgrade -y \
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

# Install ngrok
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && \
    apt update && apt install ngrok

# install ros packages
# see ../docs/installing_ros_packages.md for alternatives
RUN DEBIAN_FRONTEND=noninteractive apt install -y \
    ros-${ROS_DISTRO}-rviz \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep update

# Download CUDA Toolkit installer
RUN wget https://developer.download.nvidia.com/compute/cuda/11.0.3/local_installers/cuda_11.0.3_450.51.06_linux.run

# Install CUDA Toolkit
RUN chmod +x cuda_11.0.3_450.51.06_linux.run && \
    ./cuda_11.0.3_450.51.06_linux.run --silent --toolkit --override --toolkitpath=/usr/local/cuda-11.0

# Set environment variables
ENV PATH=/usr/local/cuda-11.0/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/cuda-11.0/lib64:${LD_LIBRARY_PATH}

# Clean up
RUN rm cuda_11.0.3_450.51.06_linux.run && \
    apt-get purge -y wget && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Install pip packages
WORKDIR /usr/src/app
COPY ./requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# Install torch packages
RUN pip3 install torch==2.2.1+cu118 torchvision==0.17.1+cu118 torchaudio==2.2.1+cu118 -f https://download.pytorch.org/whl/torch_stable.html

# Setup environment
ENV BASE_WS=/deps/ws_base
ENV DEV_WS=/${PROJ_HUB}/ws_dev

# setup
RUN mkdir -p ${BASE_WS}/src

# Change the working directory
WORKDIR ${BASE_WS}/src

# clone audio common
RUN git clone https://github.com/ros-drivers/audio_common.git

# clone robofleet client 
RUN git clone https://github.com/UTNuclearRobotics/robofleet_client.git -b noetic-devel
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
    audio_common_msgs \
    tf2_msgs

RUN source devel/setup.bash \
    && catkin build

# Install robofleet server
WORKDIR /deps
RUN git clone https://github.com/UTNuclearRobotics/robofleet.git
WORKDIR /deps/robofleet
RUN git submodule init
RUN git submodule update
RUN cp /deps/robofleet/robofleet_server/src/config.example.ts /deps/robofleet/robofleet_server/src/config.ts
RUN chown -R $UNAME:$UNAME /deps/robofleet

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Set the working directory to the Robofleet server
WORKDIR /deps/robofleet/robofleet_server

# Install dependencies and build the project
RUN yarn install
RUN yarn build

WORKDIR /${PROJ_HUB}

# setup .bashrc to correctly source workspace and setup user aliases
SHELL ["/bin/bash", "-l", "-c"]
ENV TERM=xterm-256color
RUN echo -e "source /opt/ros/${ROS_DISTRO}/setup.bash\n\
    source ${BASE_WS}/devel/setup.bash\n\
    alias inpypkg='pip install $WS_PY_PKG'\n\
    alias cdcacti='cd ${DEV_WS}'\n\
    alias sws='source ${DEV_WS}/devel/setup.bash'\n\
    PS1='\e[1m\e[93m\u\e[97m@\e[93m\h:\e[35m\w\e[0m\e[97m#\e[0m '" >> ~/.bashrc

# Copy the start scripts to /usr/local/bin
COPY scripts/start-robofleet-server.sh /usr/local/bin/start-robofleet-server
COPY scripts/kill-robofleet-server.sh /usr/local/bin/kill-robofleet-server
COPY scripts/start-robofleet-server-ngrok.sh /usr/local/bin/start-robofleet-server-ngrok
COPY scripts/kill-robofleet-server-ngrok.sh /usr/local/bin/kill-robofleet-server-ngrok
COPY scripts/start-robofleet-client.sh /usr/local/bin/start-robofleet-client
COPY scripts/kill-robofleet-client.sh /usr/local/bin/kill-robofleet-client
COPY scripts/create-augre-config.sh /usr/local/bin/create-augre-config

# Make the scripts executable
RUN chmod +x /usr/local/bin/start-robofleet-server
RUN chmod +x /usr/local/bin/start-robofleet-server-ngrok
RUN chmod +x /usr/local/bin/kill-robofleet-server
RUN chmod +x /usr/local/bin/kill-robofleet-server-ngrok
RUN chmod +x /usr/local/bin/start-robofleet-client
RUN chmod +x /usr/local/bin/kill-robofleet-client
RUN chmod +x /usr/local/bin/create-augre-config

# copy the entrypoint into the image
COPY ./entrypoint.sh /entrypoint.sh

# run this script on startup
ENTRYPOINT /entrypoint.sh
