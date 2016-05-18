Virtualizing a Network with Cumulus VX
======================================
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

Provision the topology and log in
---------------------------------
    git clone https://github.com/cumulusnetworks/cldemo-vagrant
    cd cldemo-vagrant
    vagrant plugin install vagrant-cumulus
    vagrant up
    vagrant ssh oob-mgmt-server
    sudo su - cumulus

### What's happening?
Vagrant topologies are described in a Vagrantfile, which is a Ruby program that
tells Vagrant which devices to create and how to configure their networks.
`vagrant up` will execute the Vagrantfile and create the reference topology
using Virtualbox. It will also use Ansible to configure the out-of-band
management network.

The following tasks are completed to make using the topology more convenient.

 * DHCP, DNS, and Apache are installed and configured on the oob-mgmt-server
 * Static MAC address entries are added to DHCP on the oob-mgmt-server for all devices
 * A bridge is created on the oob-mgmt-switch to connect all devices eth0 interfaces together
 * A private key for the Cumulus user is installed on the oob-mgmt-server
 * Public keys for the cumulus user are installed on all of the devices, allowing passwordless ssh
 * A NOPASSWD stanza is added for the cumulus user in the sudoers file of all devices

After the topology comes up, we use `vagrant ssh` to log in to the management
device and switch to the `cumulus` user. The `cumulus` user is able to access
other devices in the network using its SSH key, and has passwordless sudo
enabled on all devices to make it easy to run administrative commands. **Most
demos assume that you are logged into the out of band management server as the
`cumulus` user**.

Note that due to the way we simulate the out of band network, it is not possible
to use `vagrant ssh` to access in-band devices like leaf01 and leaf02. These
devices **must** be accessed via the out-of-band management server.


Factory-reset a device
----------------------
    vagrant destroy -f leaf01
    vagrant up leaf01

### What's happening?
The topology built using this Vagrantfile does not support `vagrant halt` or
`vagrant resume` for in-band devices. This means that in order to keep your
configuration across Vagrant sessions, you should either save your configuration
in a repository using an automation tool such as Ansible, Puppet, or Chef
(preferred) or use the hypervisor's halt and resume functionality.

For VirtualBox, these commands are:
    * VBoxManage controlvm leaf01 poweroff
    * VBoxManage startvm leaf01 --type headless


Destroy the entire topology
---------------------------
    vagrant destroy -f


Provision a Smaller Topology
----------------------------
    vagrant up oob-mgmt-server oob-mgmt-switch leaf01 leaf02 spine01 spine02 server01 server02


Customizing the Topology
------------------------
This Vagrant topology is built using [Topology Converter](https://github.com/cumulusnetworks/topology_converter).
To create your own topology for demo development, edit the file `topology.dot`
and add the devices or cables you need and run
[topology_converter.py](https://github.com/CumulusNetworks/topology_converter/blob/master/topology_converter.py)
in this directory. For more details on how to make customized topologies, read
that project's documentation.
