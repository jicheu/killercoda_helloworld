#!/bin/bash
apt-get update
apt-get install -y qemu-system-x86 ovmf xz-utils snapd g++ curl
wget -q https://cdimage.ubuntu.com/ubuntu-core/24/stable/current/ubuntu-core-24-amd64.img.xz -O /root/ubuntu-core-24-amd64.img.xz
unxz /root/ubuntu-core-24-amd64.img.xz
cp /usr/share/OVMF/OVMF_VARS_4M.fd /root/OVMF_VARS_4M.fd
touch /root/background_ready
