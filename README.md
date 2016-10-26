# Cumulus Linux Demo Framework
![Reference Topology](https://github.com/CumulusNetworks/cldemo-vagrant/blob/master/cldemo_topology.png "Reference Topology")

**[See the Layer 3 IP addressing on the Out of Band Network](https://raw.githubusercontent.com/CumulusNetworks/cldemo-vagrant/master/cldemo_topology_l3.png)**


Virtualizing a Network with Cumulus VX
---------------------------------------
[Cumulus VX](https://cumulusnetworks.com/cumulus-vx/) is a virtual machine
produced by Cumulus Networks to simulate the user experience of configuring a
switch using the Cumulus Linux network operating system.
[Vagrant](https://www.vagrantup.com/) is an open source tool for quickly
deploying large topologies of virtual machines. Vagrant and Cumulus VX can be
used together to build virtual simulations of production networks to validate
configurations, develop automation code, and simulate failure scenarios.

Vagrant topologies are described in a Vagrantfile, which is a Ruby program that
tells Vagrant which devices to create and how to configure their networks.
`vagrant up` will execute the Vagrantfile and create the reference topology
using Virtualbox. It will also use Ansible to configure the out-of-band
management network.

Using the Framework
========================
The Cumulus Linux Demo Framework is built upon a Vagrantfile which builds the Reference Topology (pictured above). Using this topology, it is possible to demonstrate any feature in Cumulus Linux. It may not be necessary to use all links or all devices but they're present if needed by a particular demo.

This framework of demos is built on a two-tier spine-leaf [CLOS network](https://en.wikipedia.org/wiki/Clos_network) with a
dedicated out-of-band management network. The topology built in this demo is
the reference topology used for all Cumulus Networks documentation, demos, and course materials, so
many demos will require you to build a topology using the code available in this
repository.

### Understanding What Is Provided
The following tasks are completed to make using the topology more convenient.

 * DHCP, DNS, and Apache are installed and configured on the oob-mgmt-server
 * Static MAC address entries are added to DHCP on the oob-mgmt-server for all devices
 * A bridge is created on the oob-mgmt-switch to connect all devices eth0 interfaces together
 * A private key for the Cumulus user is installed on the oob-mgmt-server
 * Public keys for the cumulus user are installed on all of the devices, allowing passwordless ssh
 * A NOPASSWD stanza is added for the cumulus user in the sudoers file of all devices

After the topology comes up, we use `vagrant ssh` to log in to the management
device and switch to the `cumulus` user. The `cumulus` user is able to access
other devices (leaf01, spine02) in the network using its SSH key, and has
passwordless sudo enabled on all devices to make it easy to run administrative
commands. Further, most automation tools (Ansible, Puppet, Chef) are run
from this management server. **Most demos assume that you are logged into
the out of band management server as the `cumulus` user**.

Note that due to the way we simulate the out of band network, it is not possible
to use `vagrant ssh` to access in-band devices like leaf01 and leaf02. These
devices **must** be accessed via the out-of-band management server.

### Prerequisites

Before running this demo or any of the other demos in the list below, install
[VirtualBox](https://www.virtualbox.org/manual/ch02.html) and
[Vagrant](https://www.vagrantup.com/downloads.html) using the
installation instructions from their website. The version of Vagrant and Virtualbox
available in your distribution's package manager may be out of date, so
installing via the preferred sources is recommended. This example was last
tested with **Vagrant 1.8.4**.

*NOTE: Do not use Vagrant version 1.8.5, there are known issues that should be rectified in v1.8.6

On an Ubuntu 16.04 box, this can be done with the following commands:

    wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
    sudo dpkg -i vagrant_1.8.1_x86_64.deb
    vagrant plugin install vagrant-cumulus

On Windows, if you have HyperV enabled, you will need to disable it as it will
conflict with Virtualbox's ability to create 64-bit VMs.

### Available Demos

Typically demos are built upon the Reference Topology shown here using this repository as a starting point and layering device configuration on top.

* **[Cldemo-config-routing](https://github.com/CumulusNetworks/cldemo-config-routing)** -- This Github repository contains the configuration files necessary for setting up Layer 3 routing on a CLOS topology using Cumulus Linux and Quagga.
* **[Cldemo-config-mlag](https://github.com/CumulusNetworks/cldemo-config-mlag)** -- This demo shows a topology using MLAG to dual-connect hosts at Layer 2 to two top of rack leafs and uses BGP unnumbered/L3 for everything above the leaf layer.
* **[Cldemo-roh-ansible](https://github.com/CumulusNetworks/cldemo-roh-ansible)** --  This demo shows a topology using 'Routing on the Host' to add host reachability directly into a BGP routed fabric.
* **[Cldemo-roh-docker](https://github.com/CumulusNetworks/cldemo-roh-docker)** -- This demo shows how to do ROH with a docker container.
* **[Cldemo-automation-puppet](https://github.com/CumulusNetworks/cldemo-automation-puppet)** -- This demo demonstrates how to write a manifest using Puppet to configure switches running Cumulus Linux and servers running Ubuntu.
* **[Cldemo-automation-ansible](https://github.com/CumulusNetworks/cldemo-automation-ansible)** -- This demo demonstrates how to write a playbook using Ansible to configure switches running Cumulus Linux and servers running Ubuntu.
* **[Cldemo-automation-chef](https://github.com/CumulusNetworks/cldemo-automation-chef)** -- This demo demonstrates how to write a set of cookbooks using Chef to configure switches running Cumulus Linux and servers running Ubuntu.
* **[Cldemo-puppet-enterprise](https://github.com/CumulusNetworks/cldemo-puppet-enterprise)** -- This demo demonstrates how to setup Puppet Enterprise to control Cumulus Linux switches with Puppet manifests.
* **[Cldemo-ansible-tower](https://github.com/CumulusNetworks/cldemo-ansible-tower)** -- This demo demonstrates how to setup Ansible Tower to control Cumulus Linux switches with Ansible playbooks.
* **[Cldemo-openstack](https://github.com/CumulusNetworks/cldemo-openstack)** -- Installs Openstack Mitaka on servers networked via Cumulus Linux
* **[Cldemo-onie-ztp-ptm](https://github.com/CumulusNetworks/cldemo-onie-ztp-ptm)** -- This demo demonstrates how to configure an out of band management network to automatically install and configure Cumulus Linux using Zero Touch Provisioning, and validate the cabling of the switches using Prescriptive Topology Manager.
* **[Cldemo-rdnbr-ansible](https://github.com/CumulusNetworks/cldemo-rdnbr-ansible)** -- This demo shows a topology using 'redistribute-neighbor' to add host reachability directly into a BGP routed fabric.
* **[Cldemo-pim](https://github.com/CumulusNetworks/cldemo-pim)** -- This demo implements Cumulus Linux PIM EA version. The demo includes simple python applications to simulate multicast senders and receivers.

Getting Started
------------------
To use one of the demos above, follow the instructions in the README for each repository.

To use the reference topology by itself outside of the above demos, follow the instructions below.

## Provision the topology and logging in

    git clone https://github.com/cumulusnetworks/cldemo-vagrant
    cd cldemo-vagrant
    vagrant up
    vagrant ssh oob-mgmt-server
    sudo su - cumulus


### Managing the VMs in the Topology
The topology built using this Vagrantfile does not support `vagrant halt` or
`vagrant resume` for in-band devices. To resume working with the demos at a later point in time, use the hypervisor's halt and resume functionality.

In Virtualbox this can be done inside of the GUI by powering off (and later powering-on) the devices involved in the simulation or by running the following CLI commands:

    * VBoxManage controlvm leaf01 poweroff
    * VBoxManage startvm leaf01 --type headless


When using the libvirt/kvm hypervisor the following commands can be used:

    * virsh destroy cldemo-vagrant_leaf01
    * virsh start cldemo-vagrant_leaf01

### Preserving configuration
In order to keep your configuration across Vagrant sessions, you should either save your configuration
in a repository using an automation tool such as Ansible, Puppet, or Chef (preferred) or alternatively copy the configuration files off of the VMs before running the "vagrant destroy" command to remove and destroy the VMs involved in the simulation.


Factory-reset a device
----------------------
    vagrant destroy -f leaf01
    vagrant up leaf01


Destroy the entire topology
---------------------------
    vagrant destroy -f


Provision a Smaller Topology
----------------------------
    vagrant up oob-mgmt-server oob-mgmt-switch leaf01 leaf02 spine01 spine02 server01 server02


Customizing the Topology
------------------------
This Vagrant topology is built using [Topology Converter](https://github.com/cumulusnetworks/topology_converter).
To create your own arbitrary topology, edit the file `topology.dot`
and add the devices or cables you need and run
[topology_converter.py](https://github.com/CumulusNetworks/topology_converter/blob/master/topology_converter.py)
in this directory. This will create a new Vagrantfile for you, which is preferred to editing the Vagrantfile
manually. For more details on how to make customized topologies, read
that project's [documentation](https://github.com/CumulusNetworks/topology_converter/tree/master/documentation).

    vagrant destroy -f
    wget https://raw.githubusercontent.com/CumulusNetworks/topology_converter/master/topology_converter.py
    # edit topology.dot as desired
    python topology_converter.py topology.dot

![Cumulus icon](http://cumulusnetworks.com/static/cumulus/img/logo_2014.png)

### Cumulus Linux

Cumulus Linux is a software distribution that runs on top of industry standard networking hardware. It enables the latest Linux applications and automation tools on networking gear while delivering new levels of innovation and ﬂexibility to the data center.

For further details please see: [cumulusnetworks.com](http://www.cumulusnetworks.com)
