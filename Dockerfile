FROM debian:jessie

# Configure timezone and locale
RUN echo "UTC" > /etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" > \
    /etc/apt/sources.list.d/backports.list

# Install Core packages
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        netcat apt-utils sed rsync gawk wget curl unzip sudo cpio chrpath \
        make build-essential gcc-multilib libtool autoconf automake \
        cvs subversion git-core quilt diffstat libssl-dev \
        vim srecord texinfo procps net-tools screen ncurses-dev \
        nano smartpm rpm python-rpm vim srecord hexedit ssh-client libsdl-dev \
        python3 locales && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/*

RUN /usr/sbin/useradd minion -m -d /home/minion \
    && echo "minion:minion" | chpasswd \
    && /usr/sbin/adduser minion sudo \
    && echo "%sudo  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER minion
WORKDIR /build

RUN sudo chown -R minion /build

ENTRYPOINT ["/bin/bash","--login"]
CMD ["-c","touch /tmp/keeprunning;while [[ -e /tmp/keeprunning ]]; do sleep 30; done"]
