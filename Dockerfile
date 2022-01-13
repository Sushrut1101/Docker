# Base Image: Ubuntu
FROM ubuntu:latest

# Working Directory
WORKDIR /root

# Delete the profile files (we'll copy our own in the next step)
RUN \
rm -f \
    /etc/profile \
    ~/.profile \
    ~/.bashrc

# Copy the Proprietary Files
COPY ./proprietary /

# apt update
RUN apt update

# Install sudo
RUN apt install apt-utils sudo -y

# tzdata
ENV TZ Asia/Kolkata

RUN \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata \
&& ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
&& apt-get install -y tzdata \
&& dpkg-reconfigure --frontend noninteractive tzdata

# Install git and ssh
RUN sudo apt install git ssh -y

# Configure git
ENV GIT_USERNAME Sushrut1101
ENV GIT_EMAIL guptasushrut@gmail.com
RUN \
    git config --global user.name $GIT_USERNAME \
&&  git config --global user.email $GIT_EMAIL

# Install Packages
RUN \
sudo apt install \
    curl wget aria2 tmate python2 python3 silversearch* \
    nano rsync rclone tmux screen openssh-server \
    python3-pip adb fastboot jq npm neofetch mlocate \
    zip unzip tar ccache \
    cpio lzma \
    -y

RUN \
sudo pip install \
    twrpdtgen

# Install schedtool and Java
RUN \
    sudo apt install \
        schedtool openjdk-8-jdk \
    -y

# Use python2 as the Default python
RUN \
sudo ln -sf /usr/bin/python2 /usr/bin/python

# Setup Android Build Environment
RUN \
git clone https://github.com/akhilnarang/scripts.git /tmp/scripts \
&& sudo bash /tmp/scripts/setup/android_build_env.sh \
&& rm -rf /tmp/scripts
