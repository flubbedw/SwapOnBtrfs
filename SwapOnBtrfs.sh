#!/bin/bash
# EXEC WITH SUDO PERMISSIONS
if (( $EUID != 0 ));
then
    echo "Please run as root"
    exit
fi
# create /swap directory
if [ -d "/swap" ]
then
    echo "Directory already exists, skipping."
else
    mkdir /swap
fi
# remove COW in /swap
chattr +C /swap
# create swapfile 1G in /swap
sudo fallocate -l 1G /swap/swapfile
# permissions
chmod 600 /swap/swapfile
# turn swap on
mkswap /swap/swapfile
swapon /swap/swapfile
# add entry in fstab config
STRING="/swap/swapfile none swap defaults 0 0"
FILE="/etc/fstab"
if grep -q "$STRING" "$FILE" ;
then
    echo "Entry already exists, skipping."
else
    echo /swap/swapfile none swap defaults 0 0 >> /etc/fstab
fi
exit 0
