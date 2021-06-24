#! /bin/sh

cd /sys/module/hid_apple/parameters
echo "0" > ./fnmode
