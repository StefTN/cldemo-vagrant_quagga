cldemo Reference Topology
=========================
In order to run Cumulus Networks' demos, it is assumed that you are already using
a common topology with a proper out of band network. This Vagrantfile and associated
helper scripts provisions a virtual version of the internal
[Cumulus Linux Demo Reference Topology](https://github.com/CumulusNetworks/cldemo-vagrant/blob/master/cldemo-topology.png)
used for demo development and testing.

This topology is designed to support both Layer 2 and Layer 3 high availability routing
without having to replace cables between demos. As such, much of the cabling will be
unused depending on the actual demo or use case. It is for this reason that while many
best practices are implemented in the design of this topology, discretion should be
exercised when adapting this to a production network.

This Vagrantfile is not supported by Cumulus Networks and is provided for your personal
education or evaluation. If you run into trouble, feel free to share your story with the
[Cumulus Networks Community](http://community.cumulusnetworks.com).


Instructions
------------
Before running, ensure that you have **Ansible version 1.9.4** and **Vagrant version 1.8.4** installed. This includes the Python Ansible package installable via Pip.

    git clone https://github.com/cumulusnetworks/cldemo-vagrant
    vagrant plugin install cumulus-vagrant
    vagrant up

To access your various devices...

    vagrant ssh oob-mgmt-server
    sudo su cumulus
    ssh leaf01

To reprovision a specific device

    vagrant destroy -f leaf01
    vagrant up leaf01

To shut down all VMs forever.

    vagrant destroy -f

To run a cldemo.

    vagrant up
    vagrant ssh oob-mgmt-server
    sudo su cumulus
    cd ~
    git clone https://github.com/cumulusnetworks/cldemo-xxxxx
    cd cldemo-xxxxxx
    cat README.md
    # follow instructions


Libvirt Instructions
--------------------
Using KVM to provision the topology is an advanced topic and not documented. These steps are provided as a starting point. Good luck!

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
    # add your user to the appropriate libvirt or libvirtd group           
    sudo service libvirt-bin restart
    virsh pool-define-as --name default --type dir --target /var/lib/libvirt/images
    virsh pool-autostart default
    virsh pool-build default
    virsh pool-start default
    wget https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
    sudo pip install ansible==1.9.4
    git clone https://github.com/cumulusnetworks/cldemo-vagrant
