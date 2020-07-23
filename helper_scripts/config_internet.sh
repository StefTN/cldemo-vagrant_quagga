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

# Setup SSH key authentication for ODL [Ubuntu 16.04 Desktop]
cat << EOT >> /home/cumulus/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDee1uZVFHxptB43LP8dSR5rNjqmPhuzwYbB1KgDTbssc7fha4lB9rDLSjuiAGWSM3iq1RHrpzED0uTMc9i0wawDmPb2TglELIrPXas2mpx5c/j7GnjypMAX3NhBimKq5jZRd+AmfE4Y1bTl0nKeWjucZDgwnpP1x6gcR2xGDZzy1HHAHDP0JvE8QCbxKq/SgMl7nXE+j1cvXxTy9sjF4OBLIKtdw7P/Qqkc3GfsgzKSgSNp/s/crmr5SJ7fv2s20nZCw81hgJZ3orNpPRsFFAtRbP6QnX4o8JQVyJAEVVlb0gQbyKuTDmZj/FFhq46SYqo5kUx0loaYns9dPmitfy5 stefano@Ubuntu-VirtualBox
EOT

echo "#################################"
echo "   Finished "
echo "#################################"
