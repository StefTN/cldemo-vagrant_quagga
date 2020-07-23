#!/bin/bash

echo "#################################"
echo "  Running config_server.sh"
echo "#################################"
sudo su


#Replace existing network interfaces file
echo -e "auto lo" > /etc/network/interfaces
echo -e "iface lo inet loopback\n\n" >> /etc/network/interfaces

#Add vagrant interface
echo -e "\n\nauto eth0" >> /etc/network/interfaces
echo -e "iface eth0 inet dhcp\n\n" >> /etc/network/interfaces

useradd cumulus -m -s /bin/bash
echo "cumulus:CumulusLinux!" | chpasswd
sed "s/PasswordAuthentication no/PasswordAuthentication yes/" -i /etc/ssh/sshd_config

## Convenience code. This is normally done in ZTP.
echo "cumulus ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10_cumulus
mkdir /home/cumulus/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzH+R+UhjVicUtI0daNUcedYhfvgT1dbZXgY33Ibm4MOo+X84Iwuzirm3QFnYf2O3uyZjNyrA6fj9qFE7Ekul4bD6PCstQupXPwfPMjns2M7tkHsKnLYjNxWNql/rCUxoH2B6nPyztcRCass3lIc2clfXkCY9Jtf7kgC2e/dmchywPV5PrFqtlHgZUnyoPyWBH7OjPLVxYwtCJn96sFkrjaG9QDOeoeiNvcGlk4DJp/g9L4f2AaEq69x8+gBTFUqAFsD8ecO941cM8sa1167rsRPx7SK3270Ji5EUF3lZsgpaiIgMhtIB/7QNTkN9ZjQBazxxlNVN6WthF8okb7OSt" >> /home/cumulus/.ssh/authorized_keys
chmod 700 -R /home/cumulus
chown -R cumulus:cumulus /home/cumulus
chmod 600 /home/cumulus/.ssh/*
chmod 700 /home/cumulus/.ssh


# Other stuff
ping 8.8.8.8 -c2
if [ "$?" == "0" ]; then
  apt-get update -qy
  apt-get install lldpd ntp ntpdate -qy
  echo "configure lldp portidsubtype ifname" > /etc/lldpd.d/port_info.conf 
fi

# Set Timezone
cat << EOT > /etc/timezone
Etc/UTC
EOT

# Apply Timezone Now
# dpkg-reconfigure -f noninteractive tzdata

# Write NTP Configuration
cat << EOT > /etc/ntp.conf
# /etc/ntp.conf, configuration for ntpd; see ntp.conf(5) for help

driftfile /var/lib/ntp/ntp.drift

statistics loopstats peerstats clockstats
filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
filegen clockstats file clockstats type day enable

server 192.168.0.254 iburst

# By default, exchange time with everybody, but don't allow configuration.
restrict -4 default kod notrap nomodify nopeer noquery
restrict -6 default kod notrap nomodify nopeer noquery

# Local users may interrogate the ntp server more closely.
restrict 127.0.0.1
restrict ::1

# Specify interfaces, don't listen on switch ports
interface listen eth0
EOT

sudo systemctl enable ntp.service
sudo systemctl start ntp.service

echo "#################################"
echo "   Finished"
echo "#################################"
cat << EOT >> /home/cumulus/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDee1uZVFHxptB43LP8dSR5rNjqmPhuzwYbB1KgDTbssc7fha4lB9rDLSjuiAGWSM3iq1RHrpzED0uTMc9i0wawDmPb2TglELIrPXas2mpx5c/j7GnjypMAX3NhBimKq5jZR d+AmfE4Y1bTl0nKeWjucZDgwnpP1x6gcR2xGDZzy1HHAHDP0JvE8QCbxKq/SgMl7nXE+j1cvXxTy9sjF4OBLIKtdw7P/Qqkc3GfsgzKSgSNp/s/crmr5SJ7fv2s20nZCw81hgJZ3orNpPRsFFAtRbP6QnX4o8JQVyJAEVVlb0gQ byKuTDmZj/FFhq46SYqo5kUx0loaYns9dPmitfy5 stefano@Ubuntu-VirtualBox
EOT
