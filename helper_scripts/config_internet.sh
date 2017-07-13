#!/bin/bash

#This file is transferred to the Cumulus VX and executed to re-map interfaces
#Extra config COULD be added here but I would recommend against that to keep this file standard.
echo "#################################"
echo "   Running config_internet.sh"
echo "#################################"
sudo su

echo -e "auto swp48" > /etc/network/interfaces
echo -e "iface swp48 inet dhcp\n" >> /etc/network/interfaces

####### Custom Stuff

# Config for OOB Switch
echo -e "auto eth0" >> /etc/network/interfaces
echo -e "iface eth0" >> /etc/network/interfaces
echo -e "    address 192.168.0.253/24" >> /etc/network/interfaces


# Exit 1
echo -e "auto swp1" >> /etc/network/interfaces
echo -e "iface swp1" >> /etc/network/interfaces


# Exit 2
echo -e "auto swp2" >> /etc/network/interfaces
echo -e "iface swp2" >> /etc/network/interfaces


echo "#################################"
echo "   Finished "
echo "#################################"
