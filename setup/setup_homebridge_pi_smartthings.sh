#!/bin/bash

#
# This script is to setup a raspberry pi from scratch as opposed to doing it manually
#
declare -a npm_pkg=('homebridge' 'homebridge-smartthings' 'homebridge-smartthings-routine-triggers')

# Update Raspbian OS
echo "Updating OS"
apt-get update
wait
apt-get -y upgrade
wait


echo "starting install of packages"
echo
echo

# Install git and Avahi dependencies needed by Homebridge
apt-get install git-core gcc build-essential git make libssl-dev vim libavahi-compat-libdnssd-dev -y
wait

# Copy files from Git respository
echo "starting git clone"
cd /opt
git clone https://github.com/ETBrown/homebridge_setup
wait

#
# Change computer name
#
echo
echo
echo "set hostname to homebridge_pi"
echo
sed -i 's/raspberrypi/homebridge_pi/g' /etc/hosts
sed -i 's/raspberrypi/homebridge_pi/g' /etc/hostname
echo

# Install nodejs
echo "installing nodejs"
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
wait
apt-get install nodejs -y

echo
wait

# Add homebridge user
useradd --system homebridge
sleep .5
echo

# Install homebridge and homebridge-plugins
echo "installing homebridge"
echo

for i in "${npm_pkg}"; do
	npm install --global --unsafe-perm $i
	wait
done

# Create system directory for homebridge JSON file
mkdir /etc/homebridge

# Copy JSON and files needed for automatic launch on startup to homebridge dir
cp /opt/homebridge_setup/config/config.json /etc/homebridge/
cp /opt/homebridge_setup/config/homebridge.init /etc/init.d/homebridge
cp /opt/homebridge_setup/setup/homebridge.sudoers /etc/sudoers.d/homebridge

# Change folder ownership
chown -R homebridge /etc/homebridge

# Modify folder properties
chmod -R 0700 /etc/homebridge
chmod 755 /etc/init.d/homebridge
sleep .5

echo "homebridge is setup"
echo
echo "done"
