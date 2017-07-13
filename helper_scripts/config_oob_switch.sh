#!/bin/bash

echo "#################################"
echo "   Running config_oob_switch.sh"
echo "#################################"
sudo su

# Config for OOB Switch
cat <<EOT > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

auto bridge-untagged
iface bridge-untagged inet dhcp
    bridge-ports swp1 swp2 swp3 swp4 swp5 swp6 swp7 swp8 swp9 swp10 swp11 swp12 swp13 swp14 swp15
    hwaddress a0:00:00:00:00:61
    
EOT

echo "#################################"
echo "   Finished "
echo "#################################"

