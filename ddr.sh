#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Check if bc is installed, install if necessary
if ! command -v bc &> /dev/null
then
    if command -v apt &> /dev/null
    then
        apt install bc -y
    elif command -v yum &> /dev/null
    then
        yum install bc -y
    else
        echo "Could not install bc, please install it manually"
        exit 1
    fi
fi

# Check if mbw is installed, install if necessary
if ! command -v mbw &> /dev/null
then
    if command -v apt &> /dev/null
    then
        apt install mbw -y
    elif command -v yum &> /dev/null
    then
        yum install mbw -y
    else
        echo "Could not install mbw, please install it manually"
        exit 1
    fi
fi

# Run mbw to measure the memory bandwidth
bandwidth=$(mbw -n 100 -t0 1 -b 512M | awk '{sum += $(NF-1); n++} END {print sum/n}')

# Determine the memory type based on bandwidth performance
if (( $(echo "$bandwidth < 8000" |bc -l) )); then
  echo "DDR3 memory detected"
elif (( $(echo "$bandwidth >= 8000 && $bandwidth < 16000" |bc -l) )); then
  echo "DDR4 memory detected"
elif (( $(echo "$bandwidth >= 16000" |bc -l) )); then
  echo "DDR5 memory detected"
else
  echo "Memory type could not be determined"
fi
