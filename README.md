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
