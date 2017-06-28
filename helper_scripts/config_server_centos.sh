#!/bin/bash

echo "#################################"
echo "  Running $0"
echo "#################################"
sudo su

install wget
cd /etc/yum.repos.d/
wget http://download.opensuse.org/repositories/home:vbernat/CentOS_7/home:vbernat.repo
yum install lldpd
echo "configure lldp portidsubtype ifname" > /etc/lldpd.d/port_info.con
systemctl enable lldpd.service
systemctl start lldpd.service


useradd cumulus -m -s /bin/bash
echo "cumulus:CumulusLinux!" | chpasswd
sed "s/PasswordAuthentication no/PasswordAuthentication yes/" -i /etc/ssh/sshd_config

## Convenience code. This is normally done in ZTP.
echo "cumulus ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10_cumulus
mkdir -p /home/cumulus/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzH+R+UhjVicUtI0daNUcedYhfvgT1dbZXgY33Ibm4MOo+X84Iwuzirm3QFnYf2O3uyZjNyrA6fj9qFE7Ekul4bD6PCstQupXPwfPMjns2M7tkHsKnLYjNxWNql/rCUxoH2B6nPyztcRCass3lIc2clfXkCY9Jtf7kgC2e/dmchywPV5PrFqtlHgZUnyoPyWBH7OjPLVxYwtCJn96sFkrjaG9QDOeoeiNvcGlk4DJp/g9L4f2AaEq69x8+gBTFUqAFsD8ecO941cM8sa1167rsRPx7SK3270Ji5EUF3lZsgpaiIgMhtIB/7QNTkN9ZjQBazxxlNVN6WthF8okb7OSt" >> /home/cumulus/.ssh/authorized_keys
chmod 700 -R /home/cumulus
chown cumulus:cumulus -R /home/cumulus

systemctl disable NetworkManager.service
systemctl stop NetworkManager.service

rm /etc/sysconfig/network-scripts/ifcfg-eth0
echo 'DEVICE="mgmt" BOOTPROTO="dhcp" ONBOOT="yes" TYPE="Ethernet" PERSISTENT_DHCLIENT="yes"' > /etc/sysconfig/network-scripts/ifcfg-mgmt

echo "#################################"
echo "   Finished"
echo "#################################"
