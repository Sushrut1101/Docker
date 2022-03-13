# Base Image
FROM archlinux/archlinux:latest

# User
USER root

# Working Directory
WORKDIR /root

# Remove Files before copying the Rootfs
COPY remove /tmp/
RUN rm -rf $(< /tmp/remove)

# Copy Rootfs and Scripts
COPY rootfs /
COPY scripts /tmp/scripts/

# Install Packages
COPY ./install_packages.sh /tmp/
RUN bash /tmp/install_packages.sh

# Configuration
COPY ./config.sh /tmp/
RUN bash /tmp/config.sh

# Remove the Scripts we used
RUN rm -rf /tmp/{{install_packages,config,aosp-build-env}.sh,remove,scripts}

# docker run command
CMD ["bash"]
