cldemo Reference Topology
=========================
This vagrant file and related support scripts can be used to bring up a virtual
version of the Cumulus Linux Demo Reference Topology, the topology used for all
demos and documentation for Cumulus Linux.

![Reference Configuration](https://raw.githubusercontent.com/CumulusNetworks/cldemo-vagrant/master/cldemo-topology.png?token=ABJsK6jGmw3Slo6RDVIDzPnq-tndwgmoks5W7Er4wA%3D%3D)

In this topology, the devices are accessed via the out-of-band management server.
All of the devices are connected via eth0 to an out-of-band management switch
(simulating the use case of an RMP) and receive their managment IP address via
DHCP running on the out-of-band server.

The reference topology is designed primarily to support demos, and does not
necessarily indicate the best way to cable a network. For example, in a CLOS
topology, the peer links between pairs of leaves are not used.


Instructions
------------
Before running, ensure that you have **ansible version 1.9.4 installed**. Either install it as root or run vagrant inside of a python virtualenv.

    git clone https://github.com/cumulusnetworks/cldemo-vagrant
    vagrant up

To access your various devices...

    vagrant ssh oob-mgmt-server
    sudo cumulus
    ssh leaf01

To reprovision a specific device

    vagrant destroy -f leaf01
    vagrant up leaf01

To shut down all VMs forever.

    vagrant destroy -f


Libvirt Instructions
--------------------
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:linuxsimba/libvirt-udp-tunnel
    sudo apt-get update -y
    sudo apt-get install autoconf python-dev git libvirt-dev libvirt-bin qemu-utils qemu-kvm -y
    wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
    sudo dpkg -i vagrant_1.8.1_x86_64.deb
    vagrant box install CumulusCommunity/cumulus-vx
    vagrant box install boxcutter/ubuntu1404
    vagrant plugin install vagrant-cumulus
    vagrant plugin install vagrant-libvirt
    vagrant plugin install vagrant-mutate
    vagrant plugin install --plugin-version 0.0.3 fog-libvirt
    vagrant mutate CumulusCommunity/cumulus-vx libvirt
    vagrant mutate boxcutter/ubuntu1404 libvirt
    # change socket permissions of /etc/libvirt/libvirtd.conf             
    sudo service libvirt-bin restart
    virsh pool-define-as --name default --type dir --target /var/lib/libvirt/images
    virsh pool-autostart default
    virsh pool-build default
    virsh pool-start default
    wget https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
    sudo pip install ansible==1.9.4
    git clone https://github.com/cumulusnetworks/cldemo-vagrant

Libvirt is designed to be used for setting up multiple parallel topologies. It
requires a specific kind of hardware to be useful.
