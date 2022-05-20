# Base Image
FROM fedora:latest

# User
USER root

# Working Directory
WORKDIR /root

# Install Packages
COPY install_packages.sh /tmp/
RUN bash /tmp/install_packages.sh

# docker run command
CMD ["bash"]
