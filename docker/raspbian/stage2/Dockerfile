FROM raspbian:stage1

ENV ACTIVE_CONSOLES ""

# 00-copies-and-fills
RUN set -xe ;\
  apt update ;\
  DEBIAN_FRONTEND=noninteractive apt install -y raspi-copies-and-fills ;\
  echo /usr/lib/arm-linux-gnueabihf/libarmmem-v7l.so > /etc/ld.so.preload

# 01-sys-tweaks
# debconf
COPY files/debconf debconf
RUN set -xe ;\
  debconf-set-selections debconf && \
  rm -rf debconf

# packages-nr
RUN set -xe ;\
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends cifs-utils

# packages
RUN set -x ;\
  DEBIAN_FRONTEND=noninteractive apt-get install -y ssh less fbset sudo \
  psmisc strace ed ncdu crda  console-setup keyboard-configuration \
  debconf-utils parted python bash-completion gdb pkg-config \
  python-rpi.gpio luajit hardlink ca-certificates curl fake-hwclock \
  dosfstools dphys-swapfile raspberrypi-sys-mods pi-bluetooth apt-listchanges \
  usb-modeswitch apt-transport-https libpam-chksshpwd rpi-update libmtp-runtime \
  rsync htop man-db policykit-1

# patch
COPY files/useradd /etc/default
COPY files/dphys-swapfile /etc
COPY files/inputrc /etc
COPY files/login.defs /etc
COPY files/profile /etc
COPY files/rc.local /etc
COPY files/cmdline.txt /boot

# run
COPY files/resize2fs_once /etc/init.d
RUN mkdir /etc/systemd/system/rc-local.service.d
COPY files/ttyoutput.conf /etc/systemd/system/rc-local.service.d
COPY files/console-setup /etc/default
COPY files/rc.local /etc

RUN set -xe ;\
  systemctl disable hwclock.sh ;\
  systemctl enable ssh ;\
  systemctl enable regenerate_ssh_host_keys ;\
  systemctl enable resize2fs_once ;\
  for GRP in input spi i2c gpio; do groupadd -f -r "$GRP"; done ;\
  for GRP in adm dialout cdrom audio users sudo video games plugdev input gpio spi i2c netdev; do \
    adduser pi $GRP; \
  done ;\
  setupcon --force --save-only -v ;\
  usermod --pass='*' root ;\
  rm -rf /etc/ssh/ssh_host_*_key*

# 02-net-tweaks
RUN set -xe ;\
  apt-get update ;\
  DEBIAN_FRONTEND=noninteractive apt-get install -y wpasupplicant wireless-tools \
    firmware-atheros firmware-brcm80211 firmware-libertas firmware-misc-nonfree \
    firmware-realtek raspberrypi-net-mods dhcpcd5 net-tools vim ;\
  mkdir -p /etc/systemd/system/dhcpcd.service.d ;\
  mkdir -p /etc/wpa_supplicant

COPY files/wait.conf /etc/systemd/system/dhcpcd.service.d
COPY files/wpa_supplicant.conf /etc/wpa_supplicant

# 03 - docker
# Docker CE
COPY files/apt/docker.list /etc/apt/sources.list.d/
RUN set -xe ;\
  curl -kfsSL https://download.docker.com/linux/raspbian/gpg | apt-key add - ;\
  apt update ;\
  DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends docker-ce ;\
  gpasswd -a pi docker

# 04 - puppet agent
# COPY files/puppet/puppet5.list /etc/apt/sources.list.d/puppet5.list
RUN set -xe ;\
DEBIAN_FRONTEND=noninteractive apt install -y dirmngr ;\
  apt update ;\
  DEBIAN_FRONTEND=noninteractive apt install -y puppet

# COPY files/puppet/puppet.conf /etc/puppet/puppet.conf

# 99 - final config
# apt
COPY files/apt/50raspi /etc/apt/apt.conf.d
