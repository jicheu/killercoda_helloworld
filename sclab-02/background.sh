#!/bin/bash
# Pre-install tools needed for the lab so snap commands are available from step 1.
apt-get update -qq
apt-get install -y snapd squashfs-tools
systemctl enable --now snapd
# Give snapd a moment to initialise before the student starts
sleep 3
touch /root/background_ready
