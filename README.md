cldemo Reference Topology
=========================
In order to run Cumulus Networks' demos, it is assumed that you are already using
a common topology with an out of band network. This Vagrantfile and associated
helper scripts provisions a virtual version of the internal
[Cumulus Linux Demo Reference Topology](https://github.com/CumulusNetworks/cldemo-vagrant/blob/master/cldemo-topology.png)
used for demo development and testing.

This topology is designed to support both Layer 2 and Layer 3 high availability routing
without having to replace cables or devices between demos. As such, much of the cabling
will be unused depending on the actual demo or use case. It is for this reason that
while many best practices are implemented in the design of this topology, discretion
should be exercised when adapting this to a production network.

In addition to creating the VMs and networking, the following steps are completed for your
convenience. If try to run a demo on factory-reset physical equipment, you may need to run
these steps manually.

 * DHCP, DNS, and Apache are installed and configured on the oob-mgmt-server
 * Static MAC address entries are added to DHCP on the oob-mgmt-server for all devices
 * A bridge is created on the oob-mgmt-switch to connect all devices eth0 interfaces together
 * A private key for the Cumulus user is installed on the oob-mgmt-server
 * Public keys for the cumulus user are installed on all of the devices, allowing passwordless ssh
 * A NOPASSWD stanza is added for the cumulus user in the sudoers file of all devices

This Vagrantfile is not supported by Cumulus Networks and is provided for your personal
education or evaluation. If you run into trouble, feel free to share your story with the
[Cumulus Networks Community](http://community.cumulusnetworks.com).


Instructions
------------
Before running, ensure that you have **Ansible version 1.9.4** and
**Vagrant version 1.8.4** installed. This includes the Python Ansible package
installable via Pip.

To bring up the entire reference topology...

    git clone https://github.com/cumulusnetworks/cldemo-vagrant
    cd cldemo-vagrant
    vagrant plugin install cumulus-vagrant
    vagrant up

To access your various devices...

    vagrant ssh oob-mgmt-server
    sudo su - cumulus
    ssh leaf01

To reprovision a specific device...

    vagrant destroy -f leaf01
    vagrant up leaf01

To shut down and delete all VMs...

    vagrant destroy -f

To run a cldemo.

    vagrant up
    vagrant ssh oob-mgmt-server
    sudo su - cumulus
    git clone https://github.com/cumulusnetworks/cldemo-xxxxx
    cd cldemo-xxxxxx
    cat README.md
    # follow instructions


Running Smaller Topologies
--------------------------
Demos do not necessarily need the full reference topology. You can bring up a
subset of the topology using the following commands.

    # two-switch: good for quick and dirty prototyping
    vagrant up oob-mgmt-server oob-mgmt-switch leaf01 leaf02

    # half-rack: used for most cldemos
    vagrant up oob-mgmt-server oob-mgmt-switch leaf01 leaf02 spine01 spine02 server01 server02

    # full-rack: usually used to demonstrate quagga on the host with dual-attached servers
    vagrant up oob-mgmt-server oob-mgmt-switch leaf01 leaf02 leaf03 leaf04 spine01 spine02 server01 server02 server03 server04

    # extended: includes exit leaves, an edge device, and a simulated internet node
    vagrant up

The extended reference topology provisions 16 devices totalling 8 GB of memory.
To reduce the memory load, you can run `python build-topology topology-extended-lite.json`,
which will create VX instances with 256 MB of RAM instead of 512 GB, bringing
the total to 6 GB. The 'lite' topology can be used for many of the Ansible
demos that don't involve installing agents on the switches, but demos such as
the Puppet demo won't work.


Customizing the Topology
------------------------
You can customize the topology using the python script `build-topology.py`. This
script reads a JSON file (see `topology-extended.json` for an example) and
produces a Vagrantfile to match the topology.


Advanced: Libvirt Instructions
------------------------------
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
