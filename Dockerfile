# Base Image: Ubuntu
FROM ubuntu:latest

# Install sudo
RUN apt install sudo -y

# tzdata
ENV TZ Asia/Kolkata

RUN \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata \
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
apt-get install -y tzdata \
dpkg-reconfigure --frontend noninteractive tzdata

# Install git and ssh
RUN sudo apt install git ssh -y

# Configure git
ENV GIT_USERNAME Sushrut1101
ENV GIT_EMAIL guptasushrut@gmail.com
RUN \
    git config --global user.name $GIT_USERNAME \
    git config --global user.email $GIT_EMAIL

# Generate an SSH Key
ENV PASSPHRASE ""
RUN ssh-keygen -q -t rsa -N $PASSPHRASE -f ~/.ssh/id_rsa
