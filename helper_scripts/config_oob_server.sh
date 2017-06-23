#!/bin/bash

SCRIPTNAME=`basename "$0"`

echo "################################################"
echo "  Running Management Server Setup ($SCRIPTNAME)..."
echo "################################################"
echo -e "\n This script was written for CumulusCommunity/vx_oob_server"
echo " Detected vagrant user is: $username"

echo " ### Overwriting /etc/network/interfaces ###"
cat <<EOT > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
    alias Connects (via NAT) To the Internet

auto eth1
iface eth1
    alias Faces the Internal Management Network
    address 192.168.0.254/24

EOT

echo " ### Pushing Ansible Hosts File ###"
mkdir -p /etc/ansible
cat << EOT > /etc/ansible/hosts
[oob-switch]
oob-mgmt-switch ansible_host=192.168.0.1 ansible_user=cumulus

[exit]
exit02 ansible_host=192.168.0.42 ansible_user=cumulus
exit01 ansible_host=192.168.0.41 ansible_user=cumulus

[leaf]
leaf04 ansible_host=192.168.0.14 ansible_user=cumulus
leaf02 ansible_host=192.168.0.12 ansible_user=cumulus
leaf03 ansible_host=192.168.0.13 ansible_user=cumulus
leaf01 ansible_host=192.168.0.11 ansible_user=cumulus

[spine]
spine02 ansible_host=192.168.0.22 ansible_user=cumulus
spine01 ansible_host=192.168.0.21 ansible_user=cumulus

[host]
edge01 ansible_host=192.168.0.51 ansible_user=cumulus
server01 ansible_host=192.168.0.31 ansible_user=cumulus
server03 ansible_host=192.168.0.33 ansible_user=cumulus
server02 ansible_host=192.168.0.32 ansible_user=cumulus
server04 ansible_host=192.168.0.34 ansible_user=cumulus
EOT

echo " ### Pushing DHCP File ###"
cat << EOT > /etc/dhcp/dhcpd.conf
ddns-update-style none;

authoritative;

log-facility local7;

option www-server code 72 = ip-address;
option cumulus-provision-url code 239 = text;

# Create an option namespace called ONIE
# See: https://github.com/opencomputeproject/onie/wiki/Quick-Start-Guide#advanced-dhcp-2-vivsoonie/onie/
option space onie code width 1 length width 1;
# Define the code names and data types within the ONIE namespace
option onie.installer_url code 1 = text;
option onie.updater_url   code 2 = text;
option onie.machine       code 3 = text;
option onie.arch          code 4 = text;
option onie.machine_rev   code 5 = text;
# Package the ONIE namespace into option 125
option space vivso code width 4 length width 1;
option vivso.onie code 42623 = encapsulate onie;
option vivso.iana code 0 = string;
option op125 code 125 = encapsulate vivso;
class "onie-vendor-classes" {
  # Limit the matching to a request we know originated from ONIE
  match if substring(option vendor-class-identifier, 0, 11) = "onie_vendor";
  # Required to use VIVSO
  option vivso.iana 01:01:01;

  ### Example how to match a specific machine type ###
  #if option onie.machine = "" {
  #  option onie.installer_url = "";
  #  option onie.updater_url = "";
  #}
}

# OOB Management subnet
shared-network LOCAL-NET{

subnet 192.168.0.0 netmask 255.255.255.0 {
  range 192.168.0.201 192.168.0.250;
  option domain-name-servers 192.168.0.254;
  option domain-name "simulation";
  default-lease-time 172800;  #2 days
  max-lease-time 345600;      #4 days
  option www-server 192.168.0.254;
  option default-url = "http://192.168.0.254/onie-installer";
  option cumulus-provision-url "http://192.168.0.254/ztp_oob.sh";
  option ntp-servers 192.168.0.254;
}

}

#include "/etc/dhcp/dhcpd.pools";
include "/etc/dhcp/dhcpd.hosts";
EOT

echo " ### Push DHCP Host Config ###"
cat << EOT > /etc/dhcp/dhcpd.hosts
group {

  option domain-name-servers 192.168.0.254;
  option domain-name "simulation";
  option routers 192.168.0.254;
  option www-server 192.168.0.254;
  option default-url = "http://192.168.0.254/onie-installer";

 host oob-mgmt-switch {hardware ethernet a0:00:00:00:00:61; fixed-address 192.168.0.1; option host-name "oob-mgmt-switch"; option cumulus-provision-url "http://192.168.0.254/ztp_oob.sh";  } 

 host exit02 {hardware ethernet a0:00:00:00:00:42; fixed-address 192.168.0.42; option host-name "exit02"; option cumulus-provision-url "http://192.168.0.254/ztp_oob.sh";  } 

 host exit01 {hardware ethernet a0:00:00:00:00:41; fixed-address 192.168.0.41; option host-name "exit01"; option cumulus-provision-url "http://192.168.0.254/ztp_oob.sh";  } 

 host spine02 {hardware ethernet a0:00:00:00:00:22; fixed-address 192.168.0.22; option host-name "spine02"; option cumulus-provision-url "http://192.168.0.254/ztp_oob.sh";  } 

 host spine01 {hardware ethernet a0:00:00:00:00:21; fixed-address 192.168.0.21; option host-name "spine01"; option cumulus-provision-url "http://192.168.0.254/ztp_oob.sh";  } 

 host leaf04 {hardware ethernet a0:00:00:00:00:14; fixed-address 192.168.0.14; option host-name "leaf04"; option cumulus-provision-url "http://192.168.0.254/ztp_oob.sh";  } 

 host leaf02 {hardware ethernet a0:00:00:00:00:12; fixed-address 192.168.0.12; option host-name "leaf02"; option cumulus-provision-url "http://192.168.0.254/ztp_oob.sh";  } 

 host leaf03 {hardware ethernet a0:00:00:00:00:13; fixed-address 192.168.0.13; option host-name "leaf03"; option cumulus-provision-url "http://192.168.0.254/ztp_oob.sh";  } 

 host leaf01 {hardware ethernet a0:00:00:00:00:11; fixed-address 192.168.0.11; option host-name "leaf01"; option cumulus-provision-url "http://192.168.0.254/ztp_oob.sh";  } 

 host edge01 {hardware ethernet a0:00:00:00:00:51; fixed-address 192.168.0.51; option host-name "edge01"; } 

 host server01 {hardware ethernet a0:00:00:00:00:31; fixed-address 192.168.0.31; option host-name "server01"; } 

 host server03 {hardware ethernet a0:00:00:00:00:33; fixed-address 192.168.0.33; option host-name "server03"; } 

 host server02 {hardware ethernet a0:00:00:00:00:32; fixed-address 192.168.0.32; option host-name "server02"; } 

 host server04 {hardware ethernet a0:00:00:00:00:34; fixed-address 192.168.0.34; option host-name "server04"; } 

 host internet {hardware ethernet a0:00:00:00:00:50; fixed-address 192.168.0.253; option host-name "internet"; option cumulus-provision-url "http://192.168.0.254/ztp_oob.sh";  } 

}#End of static host group
EOT

chmod 755 -R /etc/dhcp/*
systemctl enable dhcpd
systemctl restart dhcpd

echo " ### Push Hosts File ###"
cat << EOT > /etc/hosts
127.0.0.1 localhost 
127.0.1.1 oob-mgmt-server

192.168.0.254 oob-mgmt-server 

192.168.0.1 oob-mgmt-switch
192.168.0.42 exit02
192.168.0.41 exit01
192.168.0.22 spine02
192.168.0.21 spine01
192.168.0.14 leaf04
192.168.0.12 leaf02
192.168.0.13 leaf03
192.168.0.11 leaf01
192.168.0.51 edge01
192.168.0.31 server01
192.168.0.33 server03
192.168.0.32 server02
192.168.0.34 server04
192.168.0.253 internet

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOT

echo " ### Pushing ZTP Script ###"
cat << EOT > /var/www/html/ztp_oob.sh
#!/bin/bash

###################
# Simple ZTP Script
###################

function error() {
  echo -e "\e[0;33mERROR: The Zero Touch Provisioning script failed while running the command \$BASH_COMMAND at line \$BASH_LINENO.\e[0m" >&2
}
trap error ERR

#Setup SSH key authentication for Ansible
mkdir -p /home/cumulus/.ssh
wget -O /home/cumulus/.ssh/authorized_keys http://192.168.0.254/authorized_keys
#echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzH+R+UhjVicUtI0daNUcedYhfvgT1dbZXgY33Ibm4MOo+X84Iwuzirm3QFnYf2O3uyZjNyrA6fj9qFE7Ekul4bD6PCstQupXPwfPMjns2M7tkHsKnLYjNxWNql/rCUxoH2B6nPyztcRCass3lIc2clfXkCY9Jtf7kgC2e/dmchywPV5PrFqtlHgZUnyoPyWBH7OjPLVxYwtCJn96sFkrjaG9QDOeoeiNvcGlk4DJp/g9L4f2AaEq69x8+gBTFUqAFsD8ecO941cM8sa1167rsRPx7SK3270Ji5EUF3lZsgpaiIgMhtIB/7QNTkN9ZjQBazxxlNVN6WthF8okb7OSt" >> /home/cumulus/.ssh/authorized_keys
chmod 700 -R /home/cumulus/.ssh
chown cumulus:cumulus -R /home/cumulus/.ssh

echo "cumulus ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10_cumulus

nohup bash -c 'sleep 2; shutdown now -r "Rebooting to Complete ZTP"' &
exit 0
#CUMULUS-AUTOPROVISIONING
EOT

echo "############################################"
echo "      DONE!"
echo "############################################"
