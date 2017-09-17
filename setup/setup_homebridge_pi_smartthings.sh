#!/bin/bash

#
# This script is to setup a raspberry pi from scratch as opposed to doing it manually
#
declare -a npm_pkg=('homebridge' 'homebridge-smartthings' 'homebridge-smartthings-routine-triggers')

echo "Updating OS"
sudo apt-get update
wait
sudo apt-get -y upgrade
wait

echo "starting install of packages"
echo
echo

sudo apt-get install git-core gcc build-essential git make libssl-dev vim libavahi-compat-libdnssd-dev -y
wait


echo "starting git clone"
cd /opt
git clone https://github.com/ETBrown/homebridge_setup
wait

# Unused applications
#
# git clone git://git.drogon.net/wiringPi
# wait
#
# git clone https://github.com/ManiacalLabs/BiblioPixel
# wait

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
sudo apt-get install nodejs -y

echo
wait

# Add homebridge user
useradd --system homebridge
sleep .5

# Install homebridge and homebridge-plugins
echo "installing homebridge"
echo

for i in "${npm_pkg}"; do
	npm install --global --unsafe-perm $i
	wait
done


# Create system directory for homebridge JSON file
mkdir /etc/homebridge
cp /opt/homebridge_setup/config/config.json /etc/homebridge/
cp /opt/homebridge_setup/config/homebridge.init /etc/init.d/homebridge
cp /opt/homebridge_setup/setup/homebridge.sudoers /etc/sudoers.d/homebridge
chown -R /etc/homebridge
chmod -R 0700 /etc/homebridge
chmod 755 /etc/init.d/homebridge
sleep .5


echo "homebridge is setup"
echo
echo "done"
