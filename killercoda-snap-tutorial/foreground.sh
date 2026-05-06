#!/bin/bash
echo "Waiting for background image downloads to complete..."
while [ ! -f /root/background_ready ]; do sleep 2; done
clear
echo "Environment ready! You can proceed with the lab."
