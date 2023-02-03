# Base Image
FROM archlinux:base-devel

# User
USER root

# Working Directory
WORKDIR /root

# Remove Files before copying the Rootfs
COPY ./arch/remove /tmp/
RUN rm -rf $(< /tmp/remove)

# Copy Rootfs and Scripts
COPY ./arch/rootfs /
COPY ./common/rootfs /
COPY ./scripts /tmp/scripts/

# Install Packages
COPY ./arch/install_packages.sh /tmp/
RUN bash /tmp/install_packages.sh

# Configuration
COPY ./arch/config.sh /tmp/
RUN bash /tmp/config.sh

# Remove the Scripts we used
RUN rm -rf /tmp/{{install_packages,config}.sh,remove,scripts,packages}

# docker run command
CMD ["/sbin/init", "--log-target=journal"]
