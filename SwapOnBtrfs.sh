#!/bin/bash
# EXEC WITH SUDO PERMISSIONS

# create /swap directory
mkdir /swap
# remove COW in /swap
chattr +C /swap
# create swapfile 1G in /swap
sudo fallocate -l 1G /swap/swapfile
# set permissions
chmod 600 /swap/swapfile
# turn swap on
mkswap /swap/swapfile
swapon /swap/swapfile
# add entry in fstab config
echo /swap/swapfile swap swap defaults 0 0 >> /etc/fstab
