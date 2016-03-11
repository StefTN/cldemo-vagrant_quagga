#!/bin/bash

#This file is transferred to a Debian/Ubuntu Host and executed to re-map interfaces
#Extra config COULD be added here but I would recommend against that to keep this file standard.
echo "#################################"
echo "  Running Extra_Server_Config.sh"
echo "#################################"
sudo su


#Replace existing network interfaces file
echo -e "auto lo" > /etc/network/interfaces
echo -e "iface lo inet loopback\n\n" >> /etc/network/interfaces

#Add vagrant interface
echo -e "\n\nauto eth0" >> /etc/network/interfaces
echo -e "iface eth0 inet dhcp\n\n" >> /etc/network/interfaces

useradd cumulus
CUMULUS_HASH=`python -c 'import crypt; print(crypt.crypt("CumulusLinux!", "\$6\$saltsalt\$").replace("/","\\/"))'`
sed "s/cumulus:!/cumulus:$CUMULUS_HASH/" -i /etc/shadow
echo "cumulus ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10_cumulus
mkdir /home/cumulus/
mkdir /home/cumulus/.ssh
echo "" >> /home/cumulus/.ssh/authorized_keys
chmod 700 -R /home/cumulus
chown cumulus:cumulus /home/cumulus
chsh -s /bin/bash cumulus
sed "s/PasswordAuthentication no/PasswordAuthentication yes/" -i /etc/ssh/sshd_config
reboot

echo "#################################"
echo "   Finished"
echo "#################################"
