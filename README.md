# homebridge_setup

This repo is to manage an internal use of Homebridge (HB), and to redeploy a lost Homebridge server. 

The first aspect is to clone the repo and run the script (setup_homebridge_pi.sh),
This assumes that you're cloning into the opt directory. If you want to copy/paste the self insall script, review the lines of code to make sure that it applies to your Homebridge setup/install.

This install script installs a Homebridge sudoers file that allows the HB user sudo rights. The other file is the Homebridge.init which is just the init script that manages the HB application. 

The files under the bin directory are deprecated Bash scripts that are used to turn off monitors in a Linux OS. These scripts work just keeping for historical record. 

Then the config.json file is my HB config file, if you use this install script adjust accordingly. 

# To Use
* First, fork the repo
* Second, Edit the ARRAY of NPM plugins and whatever else you desire in the script
* Run Script as Sudo

## Note - I create all the Github Directories in /opt
I clone this repo in /opt and this script assumes that is to be true.
All Github Repos, things I need for my homebridge setup, are in /opt. After Clone/Pull then I move accordingly. For example, after Homebridge is installed, I make an /etc/homebridge directory and place my config file there. Homebridge is installed in /usr/bin/homebridge. 

Anytime I make an update to my repo, I cd into the /opt dir and pull. Then, I backup the file:
* (e.g) mv /etc/homebridge/config.json /etc/homebridge/config.bak
* Copy the file manually:
* sudo cp ./config.json /etc/homebridge/

then test.

God speed
