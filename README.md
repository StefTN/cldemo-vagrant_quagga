Virtualizing a Network with Cumulus VX and Vagrant
==================================================
[Cumulus VX](https://cumulusnetworks.com/cumulus-vx/) is a virtual machine
produced by Cumulus Networks to simulate the user experience of configuring a
switch using the Cumulus Linux network operating system.
[Vagrant](https://www.vagrantup.com/) is an open source tool for quickly
deploying large topologies of virtual machines. Vagrant and Cumulus VX can be
used together to build virtual simulations of production networks to validate
configurations, develop automation code, and simulate failure scenarios.

This example demonstrates how to build a two-tier spine-leaf network with a
dedicated out-of-band management network. The topology built in this demo is
the [reference topology](https://github.com/CumulusNetworks/cldemo-vagrant/blob/master/cldemo-topology.png)
used for all Cumulus Networks documentation, demos, and course materials, so
many demos will require you to build a topology using the code available in this
repository.


Prerequisites
-------------
Before running this demo, install
[VirtualBox](https://www.virtualbox.org/manual/ch02.html),
[Vagrant](https://www.vagrantup.com/downloads.html), and
[Ansible](https://docs.ansible.com/ansible/intro_installation.html) using the
installation instructions from their website. The version of Vagrant and Ansible
available in your distribution's package manager may be out of date, so
installing via the preferred sources is recommended. This example was last
tested with **Vagrant 1.8** and **Ansible 2.0.1**.


Provision the topology
----------------------
    git clone https://github.com/cumulusnetworks/cldemo-vagrant
    cd cldemo-vagrant
    vagrant plugin install cumulus-vagrant
    vagrant up

### What's happening?
Vagrant topologies are described in a Vagrantfile, which is a Ruby program that
tells Vagrant which devices to create and how to configure their networks.
`vagrant up` will execute the Vagrantfile and create the reference topology
using Virtualbox. It will also use Ansible to configure the out-of-band
management network.

 * DHCP, DNS, and Apache are installed and configured on the oob-mgmt-server
 * Static MAC address entries are added to DHCP on the oob-mgmt-server for all devices
 * A bridge is created on the oob-mgmt-switch to connect all devices eth0 interfaces together
 * A private key for the Cumulus user is installed on the oob-mgmt-server
 * Public keys for the cumulus user are installed on all of the devices, allowing passwordless ssh
 * A NOPASSWD stanza is added for the cumulus user in the sudoers file of all devices


SSH into a device
-----------------
    vagrant ssh oob-mgmt-server
    sudo su - cumulus
    ssh leaf01

### What's happening?
This topology tries to accurately simulate the experience of accessing a network
via an out-of-band interface. This means that it is not possible to directly
use `vagrant ssh` to access a device. Use `vagrant ssh` to connect to the
management server, and then switch to the `cumulus` user, who will be able to
use key-based SSH to log into any other device in the network without a
password.


Destroy the topology
--------------------
    vagrant destroy -f

### What's happening?
This command will destroy all VMs in the topology. This topology does not
support halting or suspending VMs using Vagrant. If you want to preserve your
work, you must use one of these two options:

 * Save your configuration using some form of automation tool, such as Puppet, Ansible, or Chef
 * Use Virtualbox Manager to halt and resume your VMs
   * VBoxManage controlvm leaf01 poweroff
   * VBoxManage startvm leaf01 --type headless


Factory-reset a device
----------------------
    vagrant destroy -f leaf01
    vagrant up leaf01

### What's happening?
The topology built using this Vagrantfile does not support halting or restarting
VMs. You must either reboot the VM by SSHing to it and issuing a `reboot`
command, or destroy the device and reprovision it.


Provision a Smaller Topology
----------------------------
    vagrant up oob-mgmt-server oob-mgmt-switch leaf01 leaf02 spine01 spine02 server01 server02

### What's happening?
In many topologies, it is not necessary to provision the entire reference
topology. Most demos only need some of the devices.


Customizing the Topology
------------------------
    python build-topology.py topology-extended-lite.json

### What's happening?
A utility script called `build-topology.py` is provided that allows you to
specify a JSON file that contains device and cabling definitions and outputs a
Vagrantfile. The JSON specification allows you to specify which interfaces on
the device to simulate, how much memory to allocate, and which cables are
connected to which devices.

Before building a new topology, be sure to destroy your active topology using
`vagrant destroy -f`.
