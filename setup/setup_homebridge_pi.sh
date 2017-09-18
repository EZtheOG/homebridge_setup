#!/bin/bash

#
# This script is to setup a raspberry pi from scratch as opposed to doing it manually
#
# Array of NPM Plugins
declare -a npm_pkg=('homebridge' 'homebridge-rcswitch-gpiomem' 'homebridge-platform-lightify' 'homebridge-cmdswitch2' 'homebridge-sonos' 'homebridge-platform-wemo')

echo "starting install of packages"
echo
echo
# Apt Packages
apt-get install git-core gcc build-essential git make libssl-dev vim libavahi-compat-libdnssd-dev -y
wait

# Git Repos for Rasp
echo "starting git clone"

cd /opt
git clone https://github.com/timleland/rfoutlet
wait

git clone git://git.drogon.net/wiringPi
wait

git clone https://github.com/ManiacalLabs/BiblioPixel
wait

echo
echo "installing GPIO via WiringPi"
cd /opt/wiringPi
./build
wait

echo 
echo
echo "set hostname to homebridge"
echo
sed -i 's/raspberrypi/homebridge/g' /etc/hosts
sed -i 's/raspberrypi/homebridge/g' /etc/hostname
echo

#Install NodeJS
echo "installing nodejs"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
wait
apt-get install nodejs -y

#Create user Homebridge
useradd --system homebridge
sleep .5

echo "installing homebridge"
echo

# Install Homebridge Plugins
for i in "${npm_pkg}"; do
	npm install --global --unsafe-perm $i
	wait
done

# Create directory structure
# Copy Files
# Chown + Chmod Homebridge dir
# Homebridge user add to sudoers

mkdir /etc/homebridge
cp /opt/homebridge_setup/config/config.json /etc/homebridge/
cp /opt/homebridge_setup/config/homebridge.init /etc/init.d/homebridge
cp /opt/homebridge_setup/setup/homebridge.sudoers /etc/sudoers.d/homebridge
chown -R homebridge /etc/homebridge
chmod -R 0700 /etc/homebridge
chmod 755 /etc/init.d/homebridge
sleep .5

# Last step is to add homebridge + sshd to autostart
update-rc.d homebridge defaults
update-rc.d ssh defaults
update-rc.d ssh enable

echo "homebridge is setup"
echo 
echo "done"
