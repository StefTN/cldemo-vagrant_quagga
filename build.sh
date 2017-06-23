#!/bin/bash

# Write Vagrantfile for Libvirt
python ./topology_converter.py ./topology.dot -p libvirt
cp ./Vagrantfile ./Vagrantfile-kvm

# Write Vagrantfile for Virtualbox (Centos)
python ./topology_converter.py ./topology-centos.dot
cp ./Vagrantfile ./Vagrantfile-centos

# Write Vagrantfile for Virtualbox
python ./topology_converter.py ./topology.dot
cp ./Vagrantfile ./Vagrantfile-vbox


