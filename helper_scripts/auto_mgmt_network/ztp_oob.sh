#!/bin/bash
# Created by Topology-Converter v4.6.2_dev
#    Template Revision: v4.6.1_custom


function error() {
  echo -e "\e[0;33mERROR: The Zero Touch Provisioning script failed while running the command $BASH_COMMAND at line $BASH_LINENO.\e[0m" >&2
}
trap error ERR

#Setup SSH key authentication for Ansible
mkdir -p /home/cumulus/.ssh
#SSH_URL="http://192.168.0.254/authorized_keys"
#wget -O /home/cumulus/.ssh/authorized_keys $SSH_URL
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzH+R+UhjVicUtI0daNUcedYhfvgT1dbZXgY33Ibm4MOo+X84Iwuzirm3QFnYf2O3uyZjNyrA6fj9qFE7Ekul4bD6PCstQupXPwfPMjns2M7tkHsKnLYjNxWNql/rCUxoH2B6nPyztcRCass3lIc2clfXkCY9Jtf7kgC2e/dmchywPV5PrFqtlHgZUnyoPyWBH7OjPLVxYwtCJn96sFkrjaG9QDOeoeiNvcGlk4DJp/g9L4f2AaEq69x8+gBTFUqAFsD8ecO941cM8sa1167rsRPx7SK3270Ji5EUF3lZsgpaiIgMhtIB/7QNTkN9ZjQBazxxlNVN6WthF8okb7OSt" >> /home/cumulus/.ssh/authorized_keys
chmod 700 -R /home/cumulus/.ssh
chown cumulus:cumulus -R /home/cumulus/.ssh

# Enable/Disable MGMT VRF
#sed -i '/iface eth0/a \ vrf mgmt' /etc/network/interfaces
#cat <<EOT >> /etc/network/interfaces
#auto mgmt
#iface mgmt
#  address 127.0.0.1/8
#  vrf-table auto
#EOT

echo "cumulus ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10_cumulus

reboot
exit 0
#CUMULUS-AUTOPROVISIONING