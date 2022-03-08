# Base Image
FROM archlinux:base-devel

# User
USER root

# Working Directory
WORKDIR /root

# Remove Files before copying the Rootfs
COPY remove /tmp/
RUN rm -rf $(< /tmp/remove)
RUN rm -rf /tmp/remove

# Copy Rootfs
COPY rootfs /

# Install Packages
COPY ./install_packages.sh /tmp/
RUN bash /tmp/install_packages.sh

# Configuration
COPY ./config.sh /tmp/
RUN bash /tmp/config.sh

# docker run command
CMD ["bash"]
