# HRI-Cacti :cactus:
Human Robot Interaction (HRI) Command and Control Teammate Interface (CACTI) project hub.

## Table of Contents
   * [1. Setup & Installation](#1-setup-&-installation)

## 1. Setup & Installation

### Install Dependencies
#### Docker Setup (Recommended)
  1. Clone repo & setup environment variables
     ```shell
     git clone https://github.com/frank-Regal/HRI-Cacti && \
       cd HRI-Cacti && \
       chmod +x setup.sh && \
       ./setup.sh
     ```
  2. Build Docker Image
     ```shell
     cacti-build
     ```
  3. Start Container
     ```shell
     cacti-start
     ```

### Clone Packages
#### HRI-Cacti XR
> Note: Currently only tested and configured for use with a HoloLens 2
  1. Clone repo and sub repos (on your local machine / **not** in the docker terminal)
       ```shell
       # -- local --
       cd HRI-Cacti
       ```
       ```shell
       # -- local --
       mkdir -p proj/ws_dev/src && \
         cd proj/ws_dev/src
       ```
       ```shell
       # -- local --
       git clone https://github.com/frank-Regal/hri_cacti_xr && \
         cd hri_cacti_xr && \
         vcs import < .repos
       ```
  2. Build package
       ```shell
       # -- local --
       cacti-shell
       ```
       ```shell
       # -- docker --
       pip install $KP_PY_PKG && \
         cd proj/ws_dev/ && \
         catkin build
       ```
        
