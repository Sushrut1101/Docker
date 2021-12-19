# Base Image: Ubuntu
FROM ubuntu:latest

# Working Directory
WORKDIR /root

# apt update
RUN apt update

# Install sudo
RUN apt install sudo -y

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

# Generate an SSH Key
ENV PASSPHRASE ""
RUN ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ${PASSPHRASE}

# Install Packages
RUN \
sudo apt install \
    curl wget aria2 tmate python2 python3 silversearch* \
    nano rsync rclone tmux screen openssh-server \
    python3-pip adb fastboot jq npm neofetch mlocate \
    -y

# Use python2 as the Default python
RUN \
sudo ln -sf /usr/bin/python2 /usr/bin/python

# Setup Android Build Environment
RUN \
git clone https://github.com/akhilnarang/scripts.git ~/scripts \
&& cd ~/scripts \
&& sudo bash setup/android_build_env.sh \
&& cd -
