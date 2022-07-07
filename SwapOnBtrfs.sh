#!/bin/bash
# EXEC WITH SUDO PERMISSIONS

# create /swap directory
mkdir /swap
# remove COW in /swap
chattr +C /swap
# create swapfile 1G in /swap
dd if=/dev/zero of=/swap/swapfile bs=1M count=1024 status=progress
# permissions
chmod 0600 /swap/swapfile
# turn swap on
mkswap -U clear /swap/swapfile
swapon /swap/swapfile
# add entry in fstab config
echo /swap/swapfile none swap defaults 0 0 >> /etc/fstab
