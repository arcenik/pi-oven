FROM raspbian:rootfs

ENV DEBIAN_FRONTEND=noninteractive
# https://bugs.launchpad.net/nexenta/+bug/335056
RUN chown -R man /var/cache/man

# 00-configure-apt
COPY files/apt/sources.list /etc/apt
COPY files/apt/raspi.list /etc/apt/sources.list.d
COPY files/debconf debconf
COPY files/apt/82B129927FA3303E.key /tmp/82B129927FA3303E.key

RUN set -x &&\
  rm -fv /etc/apt/apt.conf.d/51cache &&\
  apt-key add /tmp/82B129927FA3303E.key &&\
  apt update &&\
  DEBIAN_FRONTEND=noninteractive apt dist-upgrade -y &&\
  debconf-set-selections debconf &&\
  rm -rf debconf &&\
  DEBIAN_FRONTEND=noninteractive apt install -y locales raspberrypi-bootloader
