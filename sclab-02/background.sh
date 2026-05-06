#!/bin/bash
set -e
trap 'echo "Setup failed! Check /var/log/apt/history.log for details." >&2' ERR

# Pre-install tools needed for the lab so snap commands are available from step 1.
apt-get update -qq
apt-get install -y snapd squashfs-tools

# Enable and start snapd; the socket must be active before any snap command runs.
systemctl enable --now snapd

# Give snapd a moment to initialise before the student starts
sleep 3
touch /root/background_ready
