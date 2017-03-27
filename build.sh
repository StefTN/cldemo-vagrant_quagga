#!/bin/bash

# Write Vagrantfile for Libvirt
python ./topology_converter.py -cmd ./topology.dot -p libvirt
cp ./Vagrantfile ./Vagrantfile-kvm

# Write Vagrantfile for Virtualbox
python ./topology_converter.py -cmd ./topology.dot
cp ./Vagrantfile ./Vagrantfile-vbox
