FROM raspbian:stage0

# 00-boot-files
COPY files/boot/cmdline.txt /boot
COPY files/boot/config.txt /boot

# 01-sys-tweaks
COPY files/authorized_keys /tmp
COPY files/bashrc /etc/skel/.bashrc
RUN mkdir -p /etc/systemd/system/getty@tty1.service.d
COPY files/noclear.conf /etc/systemd/system/getty@tty1.service.d
COPY files/fstab /etc/fstab
RUN if ! id -u pi >/dev/null 2>&1; then adduser --disabled-password --gecos "" pi; fi
RUN set -xe ;\
  echo "pi:raspberry" | chpasswd ;\
  echo "root:root" | chpasswd ;\
  install -o root -g root -d /root/.ssh ;\
  install -o root -g root -m 0600 /tmp/authorized_keys /root/.ssh/authorized_keys ;\
  install -o pi -g pi -d /home/pi/.ssh ;\
  install -o pi -g pi -m 0600 /tmp/authorized_keys /home/pi/.ssh/authorized_keys

# 02-net-tweaks
COPY files/hosts /etc
COPY files/ipv6.conf /etc/modprobe.d
COPY files/hostname /etc
RUN ln -sf /dev/null /etc/systemd/network/99-default.link

# 03-install-packages
RUN DEBIAN_FRONTEND=noninteractive apt install -y libraspberrypi-bin libraspberrypi0 raspi-config

# 04-rsyslog
COPY files/rsyslog/remote-iota.conf /etc/rsyslog.d/remote-iota.conf
