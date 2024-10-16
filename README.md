# HRI-Cacti :cactus:
Docker-based project workspace setup for the Human Robot Interaction (HRI) Command and Control Teammate Interface (CACTI) project.

**Main Project Repository: [hri_cacti_xr](https://github.com/frank-Regal/hri_cacti_xr)**

## Table of Contents
   * [1. Setup Docker Container](#1-setup-docker-container)
   * [2. Install Project Packages](#2-install-project-packages)
   * [3. Run Packages and Contribute](#3-run-packages-and-contribute)
   * [4. Custom Shell Commands](#4-custom-shell-commands)

## 1. Setup Docker Container
> **Note**: This docker installation is the recommended way to run and contribute to this project. The installation instructions below will setup a Docker container on your machine mounted to the local `HRI-Cacti/project/` directory from this repo on your local machine after cloning this repo. The `/project/` directory in the Docker container after setup will be mounted (synced) to the `HRI-Cacti/project/` directory on your local machine. The intended work flow is to develop in the local `HRI-Cacti/project/` directory on your local machine and then build and run the packages located in `/project/` from a Docker container shell.
  1. Install prerequisites
            <details>
      <summary><a href="https://github.com/dirk-thomas/vcstool">vcstool</a></summary>
      <br>
    
      ```shell
      curl -s https://packagecloud.io/install/repositories/dirk-thomas/vcstool/script.deb.sh | sudo bash
      sudo apt-get update
      sudo apt install python3-vcstool
      ```
      </details>
      <details>
      <summary><a href="https://docs.docker.com/engine/install/ubuntu/">Docker</a></summary>
        <br>
        
        ```shell
        https://docs.docker.com/engine/install/ubuntu/
        ```
      </details>
      <details>
      <summary><a href="https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/1.14.5/install-guide.html">NVIDIA Container Toolkit</a></summary>
        <br>

        ```shell
        https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/1.14.5/install-guide.html
        ```
      </details>
      <details>
      <summary><a href="https://docs.docker.com/engine/install/linux-postinstall/">Docker: Post Installation Steps</a></summary>
        <br>
        
        ```shell
        https://docs.docker.com/engine/install/linux-postinstall/
        ```
      </details>
  3. Clone repo & setup environment variables
     ```shell
     git clone -b devel git@github.com:frank-Regal/HRI-Cacti.git && \
       cd HRI-Cacti && \
       chmod +x setup.sh && \
       ./setup.sh
     ```
  4. Source environment
     ```shell
     source Docker/bash_utils && source ~/.bashrc
     ```
  5. Build Docker Image
     >**Note**: `HRI-Cacti/setup.sh` script should have sourced the `HRI-Cacti/Docker/bash-utils` file to run the following shell cmds. If they were not correctly setup, see `HRI-Cacti/Docker/bash-utils` for a list of the cmds to run.
     ```shell
     cacti-build
     ```
  6. Start Container
     ```shell
     cacti-start
     ```

## 2. Install Project Packages
### &diams; [hri_cacti_xr](https://github.com/frank-Regal/hri_cacti_xr) (main project repository) 
  >**Note**: Follow the steps below only if you setup the docker environment in [1. Setup Docker Container](#1-setup-docker-container). For non-docker, local machine, setup, see [this](https://github.com/frank-Regal/hri_cacti_xr) project repo for local install instructions.
  1. From `HRI-Cacti/` directory, create the following workspace directories
       ```shell
       mkdir -p project/ws_dev/src && cd project/ws_dev/src
       ```
  2. Clone [hri_cacti_xr](https://github.com/frank-Regal/hri_cacti_xr) repo and import submodules.
       ```shell
       git clone git@github.com:frank-Regal/hri_cacti_xr.git && \
         cd hri_cacti_xr && \
         vcs import < .repos
       ```
  3. Start Docker Container
       ```shell
       cacti-start
       ```
  4. Open Docker shell
       ```shell
       cacti-shell
       ```
  5. `🐋 From Docker Shell` Build custom python package and catkin workspace
       ```shell
       cd /project/ws_dev/ && catkin build
       ```
  6. `🐋 From Docker Shell` Source catkin workspace
       ```shell
       sws #preconfigured alias
       ```
## 3. Run Packages and Contribute
> **Note:** From here on out, whenever you are **_running_** or **_building_** ANY packages used within the [frank-Regal/hri_cacti_xr](https://github.com/frank-Regal/hri_cacti_xr) main project repository, run the commands from a **_Docker Container Shell_** that you setup in [1. Setup Docker Container](#1-setup-docker-container) section. For making Git push/pulls/clones, ensure you are working in a local machine shell!

  - [Run - frank-Regal/hri_cacti_xr](https://github.com/frank-Regal/hri_cacti_xr?tab=readme-ov-file#2-run)
  - [Contribute - frank-Regal/hri_cacti_xr](https://github.com/frank-Regal/hri_cacti_xr?tab=readme-ov-file#3-contribute)

## 4. Custom Shell Commands
`Local Shell` aliases & bash commands
```shell
cacti-start # starts the hri_cacti_i docker image if it is not started (see Docker/bash_utils for full list)
cacti-shell # opens a shell in docker (see Docker/bash_utils for full list)
cacti-build # builds/rebulds the docker image (see Docker/bash_utils for full list)
vcs pull -n # pulls all changes from all nested repositories (see Docker/bash_utils for full list)
```

`🐋 Docker Shell` aliases
```shell
sws # sources the catkin workspace
cdcacti # changes directory in the main project workspace
```
        
