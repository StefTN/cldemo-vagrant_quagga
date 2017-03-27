#!/bin/bash

python ./topology_converter.py -cmd ./topology.dot
cp ./Vagrantfile ./Vagrantfile-vbox


python ./topology_converter.py -cmd ./topology.dot -p libvirt
cp ./Vagrantfile ./Vagrantfile-kvm
