# Base Image
FROM archlinux/archlinux:latest

# Maintainer
MAINTAINER Sushrut1101 <guptasushrut@gmail.com>

# User
USER root

# Working Directory
WORKDIR /root

# Install Packages
COPY ./install_packages.sh /tmp/
RUN bash /tmp/install_packages.sh

# docker run command
CMD ["bash"]
