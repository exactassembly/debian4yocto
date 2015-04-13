FROM debian:wheezy

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Configure timezone and locale
RUN echo "UTC" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

# Install Core packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    netcat apt-utils sed rsync gawk wget curl unzip sudo cpio chrpath \
    make build-essential gcc-multilib libtool autoconf automake \
    cvs subversion git-core quilt diffstat libssl-dev \
    vim srecord texinfo procps net-tools screen ncurses-dev \
    nano smartpm rpm python-rpm vim srecord hexedit ssh-client

RUN DEBIAN_FRONTEND=noninteractive apt-get clean

RUN /usr/sbin/useradd minion -m -d /home/minion \
    && echo "minion:minion" | chpasswd \
    && /usr/sbin/adduser minion sudo \
    && echo "%sudo  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER minion
WORKDIR /build

ENTRYPOINT ["/bin/bash","--login"]
CMD ["-s"]
