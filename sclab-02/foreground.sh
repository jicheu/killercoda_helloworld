#!/bin/bash
echo "Waiting for environment to initialize..."
while [ ! -f /root/background_ready ]; do sleep 1; done
clear
echo "Environment ready! You can now proceed."
