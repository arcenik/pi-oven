#!/bin/bash -xe

# Requirement
apt update
apt install -y \
    apt-transport-https ca-certificates \
    curl software-properties-common debootstrap qemu-user-static \
    build-essential dosfstools parted zerofree

# Docker CE
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

apt update
apt install -y docker-ce

# for Docker
gpasswd -a vagrant docker
