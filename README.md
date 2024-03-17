# HRI-Cacti :cactus:
Human Robot Interaction (HRI) Command and Control Teammate Interface (CACTI) project hub.

## Table of Contents
   * [1. Install Dependencies via Docker](#1-install-dependencies-via-docker)
   * [2. Install HRI-Cacti Packages]()

## 1. Install Dependencies via Docker
> **Note**: This docker installation is the recommended way to run and contribute to this project. The installation instructions below will setup a Docker container on your machine mounted to the local `HRI-Cacti/project/` directory from this repo on your local machine after cloning this repo. The `/project/` directory in the Docker container after setup will be mounted (synced) to the `HRI-Cacti/project/` directory on your local machine. The intended work flow is to develop in the local `HRI-Cacti/project/` directory on your local machine and then build and run the packages located in `/project/` from a Docker container shell.
  1. Install prerequisites
      <details>
      <summary><a href="https://github.com/dirk-thomas/vcstool">vcstool</a></summary>
      <br>
    
      ```shell
      sudo apt install python3-vcstool
      ```
      </details>
      <details>
      <summary><a href="https://docs.docker.com/engine/install/ubuntu/">Docker</a></summary>
      https://docs.docker.com/engine/install/ubuntu/
      </details>
      <details>
      <summary><a href="https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/1.14.5/install-guide.html">NVIDIA Container Toolkit</a></summary>
      https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/1.14.5/install-guide.html
      </details>
      <details>
      <summary><a href="https://docs.docker.com/engine/install/linux-postinstall/">Docker: Post Installation Steps</a></summary>
      https://docs.docker.com/engine/install/linux-postinstall/
      </details>
  3. Clone repo & setup environment variables
     ```shell
     git clone https://github.com/frank-Regal/HRI-Cacti && \
       cd HRI-Cacti && \
       chmod +x setup.sh && \
       ./setup.sh
     ```
  4. Build Docker Image
     >**Note**: `HRI-Cacti/setup.sh` script should have sourced the `HRI-Cacti/Docker/bash-utils` file to run the following shell cmds. If they were not correctly setup, see `HRI-Cacti/Docker/bash-utils` for a list of the cmds to run.
     ```shell
     cacti-build
     ```
  6. Start Container
     ```shell
     cacti-start
     ```

## 2. Getting Started
### Clone HRI-Cacti for XR
> Note: Currently only tested and configured for use with a HoloLens 2
  1. From `HRI-Cacti/` directory, create the following workspace directories
       ```shell
       mkdir -p project/ws_dev/src && cd project/ws_dev/src
       ```
  2. Clone [hri_cacti_xr](https://github.com/frank-Regal/hri_cacti_xr) repo and import submodules.
       ```shell
       git clone https://github.com/frank-Regal/hri_cacti_xr && \
         cd hri_cacti_xr && \
         vcs import < .repos
       ```
  3. Open Docker shell, build package, source workspace in Docker container
       ```shell
       cacti-shell
       ```
  4. Build custom python package and catkin workspace
       `🐋 From Docker Shell`
       ```shell
       pip install $WS_PY_PKG && \
         cd /project/ws_dev/ && \
         catkin build
       ```
  5. Source catkin workspace
       `🐋 From Docker Shell`
       ```shell
       sws #preconfigured alias
       ```
       
        
