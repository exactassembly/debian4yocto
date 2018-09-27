FROM debian:stretch

# Configure timezone and locale
RUN echo "UTC" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata

RUN echo "deb http://ftp.debian.org/debian stretch-backports main" > \
    /etc/apt/sources.list.d/backports.list

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install Core packages
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get upgrade -y && \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    apt-get install -y  -q \
        netcat apt-utils sed rsync gawk wget curl unzip sudo cpio chrpath \
        make build-essential gcc-multilib libtool autoconf automake \
        cvs subversion git-core quilt diffstat libssl-dev \
        vim srecord texinfo procps net-tools screen ncurses-dev \
        nano smartpm rpm python-rpm vim srecord hexedit ssh-client libsdl-dev \
        cryptsetup squashfs-tools python3 locales && \
    locale-gen en_US.UTF-8 && \
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
CMD ["-c","tail -f /dev/null"]
