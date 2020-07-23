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
    alias Interface used by Vagrant

auto bridge
iface bridge
    alias Untagged Bridge
    bridge-ports swp1 swp2 swp3 swp4 swp5 swp6 swp7 swp8 swp9 swp10 swp11 swp12 swp13 swp14 swp15
    hwaddress a0:00:00:00:00:61
    address 192.168.0.1/24
    
EOT

echo "#################################"
echo "   Finished "
echo "#################################"

cat << EOT >> /home/cumulus/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDee1uZVFHxptB43LP8dSR5rNjqmPhuzwYbB1KgDTbssc7fha4lB9rDLSjuiAGWSM3iq1RHrpzED0uTMc9i0wawDmPb2TglELIrPXas2mpx5c/j7GnjypMAX3NhBimKq5jZR d+AmfE4Y1bTl0nKeWjucZDgwnpP1x6gcR2xGDZzy1HHAHDP0JvE8QCbxKq/SgMl7nXE+j1cvXxTy9sjF4OBLIKtdw7P/Qqkc3GfsgzKSgSNp/s/crmr5SJ7fv2s20nZCw81hgJZ3orNpPRsFFAtRbP6QnX4o8JQVyJAEVVlb0gQ byKuTDmZj/FFhq46SYqo5kUx0loaYns9dPmitfy5 stefano@Ubuntu-VirtualBox
EOT
