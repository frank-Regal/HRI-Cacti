# HRI-Cacti :cactus:
Human Robot Interaction (HRI) Command and Control Teammate Interface (CACTI) project hub.

## Table of Contents
   * [1. Install Dependencies](#1-install-dependencies)

## 1. Install Dependencies

### via Docker
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
     ```shell
     cacti-build
     ```
  5. Start Container
     ```shell
     cacti-start
     ```

## 2. Getting Started
### Clone HRI-Cacti for XR
> Note: Currently only tested and configured for use with a HoloLens 2
  1. From `HRI-Cacti/` directory, create the following workspace directories
       ```shell
       mkdir -p proj/ws_dev/src && cd proj/ws_dev/src
       ```
  2. Clone [hri_cacti_xr](https://github.com/frank-Regal/hri_cacti_xr) repo and import submodules.
       ```shell
       git clone https://github.com/frank-Regal/hri_cacti_xr && \
         cd hri_cacti_xr && \
         vcs import < .repos
       ```
  2. Build package in *Docker* container
       ```shell
       cacti-shell
       ```
       `🐋 Docker`
       ```shell
       pip install $KP_PY_PKG && \
         cd proj/ws_dev/ && \
         catkin build
       ```
        
