# Created by Topology-Converter v4.0.3
#    using topology data from: topology.dot
#    NOTE: in order to use this Vagrantfile you will need:
#       -Vagrant(v1.7+) installed: http://www.vagrantup.com/downloads
#       -Cumulus Plugin for Vagrant installed: $ vagrant plugin install vagrant-cumulus
#       -the "helper_scripts" directory that comes packaged with topology-converter.py
#       -Virtualbox installed: https://www.virtualbox.org/wiki/Downloads

raise "vagrant-cumulus plugin must be installed, try $ vagrant plugin install vagrant-cumulus" unless Vagrant.has_plugin? "vagrant-cumulus"

Vagrant.configure("2") do |config|
  wbid = 1461950669

  config.vm.provider "virtualbox" do |v|
    v.gui=false

  end



  ##### DEFINE VM for oob-mgmt-server #####
  config.vm.define "oob-mgmt-server" do |device|
    device.vm.hostname = "oob-mgmt-server"
    device.vm.box = "boxcutter/ubuntu1404"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_oob-mgmt-server"
      v.memory = 1024
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for eth1 --> oob-mgmt-switch:swp1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net52", auto_config: false , :mac => "44383900005B"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_oob_server.sh"

      device.vm.provision "ansible" do |ansible|
          ansible.playbook = "./playbook/site.yml"
          ansible.extra_vars = {wbench_hosts: {






                  exit02: {ip: "192.168.0.42", mac: "A0:00:00:00:00:42"},



                  exit01: {ip: "192.168.0.41", mac: "A0:00:00:00:00:41"},



                  spine02: {ip: "192.168.0.22", mac: "A0:00:00:00:00:22"},



                  spine01: {ip: "192.168.0.21", mac: "A0:00:00:00:00:21"},



                  leaf04: {ip: "192.168.0.14", mac: "A0:00:00:00:00:14"},



                  leaf02: {ip: "192.168.0.12", mac: "A0:00:00:00:00:12"},



                  leaf03: {ip: "192.168.0.13", mac: "A0:00:00:00:00:13"},



                  leaf01: {ip: "192.168.0.11", mac: "A0:00:00:00:00:11"},



                  edge01: {ip: "192.168.0.51", mac: "A0:00:00:00:00:51"},



                  server01: {ip: "192.168.0.31", mac: "A0:00:00:00:00:31"},



                  server03: {ip: "192.168.0.33", mac: "A0:00:00:00:00:33"},



                  server02: {ip: "192.168.0.32", mac: "A0:00:00:00:00:32"},



                  server04: {ip: "192.168.0.34", mac: "A0:00:00:00:00:34"},




                              }}
        end

      # Apply the interface re-map

      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900005B eth1"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm -nv"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for oob-mgmt-switch #####
  config.vm.define "oob-mgmt-switch" do |device|
    device.vm.hostname = "oob-mgmt-switch"
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_oob-mgmt-switch"
      v.memory = 256
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for swp10 --> spine01:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net30", auto_config: false , :mac => "443839000037"

      # link for swp11 --> spine02:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net57", auto_config: false , :mac => "443839000065"

      # link for swp12 --> exit01:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net9", auto_config: false , :mac => "443839000010"

      # link for swp13 --> exit02:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net47", auto_config: false , :mac => "443839000053"

      # link for swp14 --> edge01:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net39", auto_config: false , :mac => "443839000046"

      # link for swp15 --> internet:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net34", auto_config: false , :mac => "44383900003E"

      # link for swp8 --> leaf03:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net27", auto_config: false , :mac => "443839000032"

      # link for swp9 --> leaf04:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net33", auto_config: false , :mac => "44383900003C"

      # link for swp2 --> server01:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net41", auto_config: false , :mac => "443839000049"

      # link for swp3 --> server02:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net46", auto_config: false , :mac => "443839000052"

      # link for swp1 --> oob-mgmt-server:eth1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net52", auto_config: false , :mac => "44383900005C"

      # link for swp6 --> leaf01:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net20", auto_config: false , :mac => "443839000025"

      # link for swp7 --> leaf02:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net37", auto_config: false , :mac => "443839000043"

      # link for swp4 --> server03:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net3", auto_config: false , :mac => "443839000005"

      # link for swp5 --> server04:eth0
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net48", auto_config: false , :mac => "443839000054"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype5", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype6", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype7", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype8", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype9", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype10", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype11", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype12", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype13", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype14", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype15", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype16", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_oob_switch.sh"



      # Apply the interface re-map
        #Disable default remap on Cumulus VX
      device.vm.provision :shell , inline: "rm -f /etc/init.d/rename_eth_swp"
      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000037 swp10"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000065 swp11"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000010 swp12"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000053 swp13"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000046 swp14"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900003E swp15"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000032 swp8"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900003C swp9"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000049 swp2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000052 swp3"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900005C swp1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000025 swp6"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000043 swp7"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000005 swp4"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000054 swp5"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm -nv"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for exit02 #####
  config.vm.define "exit02" do |device|
    device.vm.hostname = "exit02"
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_exit02"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for eth0 --> oob-mgmt-switch:swp13
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net47", auto_config: false , :mac => "A00000000042"

      # link for swp51 --> spine01:swp29
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net21", auto_config: false , :mac => "443839000026"

      # link for swp52 --> spine02:swp29
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net51", auto_config: false , :mac => "443839000059"

      # link for swp48 --> exit02:swp47
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net32", auto_config: false , :mac => "44383900003B"

      # link for swp1 --> edge01:eth2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net7", auto_config: false , :mac => "44383900000D"

      # link for swp47 --> exit02:swp48
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net32", auto_config: false , :mac => "44383900003A"

      # link for swp46 --> exit02:swp45
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net29", auto_config: false , :mac => "443839000036"

      # link for swp45 --> exit02:swp46
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net29", auto_config: false , :mac => "443839000035"

      # link for swp44 --> internet:swp2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net38", auto_config: false , :mac => "443839000045"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype5", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype6", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype7", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype8", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype9", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype10", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"



      # Apply the interface re-map
        #Disable default remap on Cumulus VX
      device.vm.provision :shell , inline: "rm -f /etc/init.d/rename_eth_swp"
      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:42 eth0"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000026 swp51"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000059 swp52"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900003B swp48"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900000D swp1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900003A swp47"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000036 swp46"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000035 swp45"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000045 swp44"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for exit01 #####
  config.vm.define "exit01" do |device|
    device.vm.hostname = "exit01"
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_exit01"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for swp1 --> edge01:eth1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net45", auto_config: false , :mac => "443839000051"

      # link for swp51 --> spine01:swp30
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net6", auto_config: false , :mac => "44383900000A"

      # link for swp52 --> spine02:swp30
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net54", auto_config: false , :mac => "44383900005F"

      # link for swp48 --> exit01:swp47
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net14", auto_config: false , :mac => "44383900001A"

      # link for swp44 --> internet:swp1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net5", auto_config: false , :mac => "443839000009"

      # link for swp47 --> exit01:swp48
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net14", auto_config: false , :mac => "443839000019"

      # link for swp46 --> exit01:swp45
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net42", auto_config: false , :mac => "44383900004B"

      # link for swp45 --> exit01:swp46
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net42", auto_config: false , :mac => "44383900004A"

      # link for eth0 --> oob-mgmt-switch:swp12
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net9", auto_config: false , :mac => "A00000000041"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype5", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype6", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype7", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype8", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype9", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype10", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"



      # Apply the interface re-map
        #Disable default remap on Cumulus VX
      device.vm.provision :shell , inline: "rm -f /etc/init.d/rename_eth_swp"
      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000051 swp1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900000A swp51"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900005F swp52"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900001A swp48"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000009 swp44"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000019 swp47"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900004B swp46"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900004A swp45"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:41 eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for spine02 #####
  config.vm.define "spine02" do |device|
    device.vm.hostname = "spine02"
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_spine02"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for swp32 --> spine01:swp32
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net35", auto_config: false , :mac => "443839000040"

      # link for swp30 --> exit01:swp52
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net54", auto_config: false , :mac => "443839000060"

      # link for swp31 --> spine01:swp31
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net44", auto_config: false , :mac => "44383900004F"

      # link for swp29 --> exit02:swp52
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net51", auto_config: false , :mac => "44383900005A"

      # link for swp2 --> leaf02:swp52
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net56", auto_config: false , :mac => "443839000064"

      # link for swp3 --> leaf03:swp52
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net17", auto_config: false , :mac => "443839000020"

      # link for swp1 --> leaf01:swp52
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net23", auto_config: false , :mac => "44383900002B"

      # link for swp4 --> leaf04:swp52
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net43", auto_config: false , :mac => "44383900004D"

      # link for eth0 --> oob-mgmt-switch:swp11
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net57", auto_config: false , :mac => "A00000000022"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype5", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype6", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype7", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype8", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype9", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype10", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"



      # Apply the interface re-map
        #Disable default remap on Cumulus VX
      device.vm.provision :shell , inline: "rm -f /etc/init.d/rename_eth_swp"
      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000040 swp32"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000060 swp30"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900004F swp31"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900005A swp29"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000064 swp2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000020 swp3"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900002B swp1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900004D swp4"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:22 eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for spine01 #####
  config.vm.define "spine01" do |device|
    device.vm.hostname = "spine01"
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_spine01"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for swp32 --> spine02:swp32
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net35", auto_config: false , :mac => "44383900003F"

      # link for swp30 --> exit01:swp51
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net6", auto_config: false , :mac => "44383900000B"

      # link for swp31 --> spine02:swp31
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net44", auto_config: false , :mac => "44383900004E"

      # link for swp29 --> exit02:swp51
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net21", auto_config: false , :mac => "443839000027"

      # link for swp2 --> leaf02:swp51
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net24", auto_config: false , :mac => "44383900002D"

      # link for swp3 --> leaf03:swp51
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net49", auto_config: false , :mac => "443839000056"

      # link for swp1 --> leaf01:swp51
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net50", auto_config: false , :mac => "443839000058"

      # link for swp4 --> leaf04:swp51
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net36", auto_config: false , :mac => "443839000042"

      # link for eth0 --> oob-mgmt-switch:swp10
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net30", auto_config: false , :mac => "A00000000021"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype5", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype6", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype7", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype8", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype9", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype10", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"



      # Apply the interface re-map
        #Disable default remap on Cumulus VX
      device.vm.provision :shell , inline: "rm -f /etc/init.d/rename_eth_swp"
      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900003F swp32"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900000B swp30"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900004E swp31"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000027 swp29"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900002D swp2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000056 swp3"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000058 swp1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000042 swp4"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:21 eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for leaf04 #####
  config.vm.define "leaf04" do |device|
    device.vm.hostname = "leaf04"
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_leaf04"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for swp50 --> leaf03:swp50
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net4", auto_config: false , :mac => "443839000007"

      # link for swp51 --> spine01:swp4
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net36", auto_config: false , :mac => "443839000041"

      # link for swp52 --> spine02:swp4
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net43", auto_config: false , :mac => "44383900004C"

      # link for swp49 --> leaf03:swp49
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net28", auto_config: false , :mac => "443839000034"

      # link for swp48 --> leaf04:swp47
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net31", auto_config: false , :mac => "443839000039"

      # link for swp2 --> server04:eth2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net26", auto_config: false , :mac => "443839000031"

      # link for swp1 --> server03:eth2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net55", auto_config: false , :mac => "443839000062"

      # link for swp47 --> leaf04:swp48
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net31", auto_config: false , :mac => "443839000038"

      # link for swp46 --> leaf04:swp45
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net16", auto_config: false , :mac => "44383900001E"

      # link for swp45 --> leaf04:swp46
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net16", auto_config: false , :mac => "44383900001D"

      # link for eth0 --> oob-mgmt-switch:swp9
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net33", auto_config: false , :mac => "A00000000014"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype5", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype6", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype7", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype8", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype9", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype10", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype11", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype12", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"



      # Apply the interface re-map
        #Disable default remap on Cumulus VX
      device.vm.provision :shell , inline: "rm -f /etc/init.d/rename_eth_swp"
      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000007 swp50"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000041 swp51"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900004C swp52"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000034 swp49"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000039 swp48"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000031 swp2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000062 swp1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000038 swp47"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900001E swp46"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900001D swp45"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:14 eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for leaf02 #####
  config.vm.define "leaf02" do |device|
    device.vm.hostname = "leaf02"
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_leaf02"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for swp50 --> leaf01:swp50
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net1", auto_config: false , :mac => "443839000002"

      # link for swp51 --> spine01:swp2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net24", auto_config: false , :mac => "44383900002C"

      # link for swp52 --> spine02:swp2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net56", auto_config: false , :mac => "443839000063"

      # link for swp49 --> leaf01:swp49
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net10", auto_config: false , :mac => "443839000012"

      # link for swp48 --> leaf02:swp47
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net53", auto_config: false , :mac => "44383900005E"

      # link for swp2 --> server02:eth2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net15", auto_config: false , :mac => "44383900001C"

      # link for swp1 --> server01:eth2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net13", auto_config: false , :mac => "443839000018"

      # link for swp47 --> leaf02:swp48
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net53", auto_config: false , :mac => "44383900005D"

      # link for swp46 --> leaf02:swp45
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net8", auto_config: false , :mac => "44383900000F"

      # link for swp45 --> leaf02:swp46
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net8", auto_config: false , :mac => "44383900000E"

      # link for eth0 --> oob-mgmt-switch:swp7
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net37", auto_config: false , :mac => "A00000000012"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype5", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype6", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype7", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype8", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype9", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype10", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype11", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype12", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"



      # Apply the interface re-map
        #Disable default remap on Cumulus VX
      device.vm.provision :shell , inline: "rm -f /etc/init.d/rename_eth_swp"
      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000002 swp50"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900002C swp51"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000063 swp52"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000012 swp49"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900005E swp48"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900001C swp2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000018 swp1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900005D swp47"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900000F swp46"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900000E swp45"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:12 eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for leaf03 #####
  config.vm.define "leaf03" do |device|
    device.vm.hostname = "leaf03"
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_leaf03"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for swp50 --> leaf04:swp50
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net4", auto_config: false , :mac => "443839000006"

      # link for swp51 --> spine01:swp3
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net49", auto_config: false , :mac => "443839000055"

      # link for swp52 --> spine02:swp3
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net17", auto_config: false , :mac => "44383900001F"

      # link for swp49 --> leaf04:swp49
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net28", auto_config: false , :mac => "443839000033"

      # link for swp48 --> leaf03:swp47
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net11", auto_config: false , :mac => "443839000014"

      # link for swp2 --> server04:eth1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net19", auto_config: false , :mac => "443839000024"

      # link for swp1 --> server03:eth1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net22", auto_config: false , :mac => "443839000029"

      # link for swp47 --> leaf03:swp48
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net11", auto_config: false , :mac => "443839000013"

      # link for swp46 --> leaf03:swp45
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net25", auto_config: false , :mac => "44383900002F"

      # link for swp45 --> leaf03:swp46
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net25", auto_config: false , :mac => "44383900002E"

      # link for eth0 --> oob-mgmt-switch:swp8
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net27", auto_config: false , :mac => "A00000000013"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype5", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype6", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype7", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype8", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype9", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype10", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype11", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype12", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"



      # Apply the interface re-map
        #Disable default remap on Cumulus VX
      device.vm.provision :shell , inline: "rm -f /etc/init.d/rename_eth_swp"
      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000006 swp50"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000055 swp51"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900001F swp52"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000033 swp49"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000014 swp48"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000024 swp2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000029 swp1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000013 swp47"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900002F swp46"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900002E swp45"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:13 eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for leaf01 #####
  config.vm.define "leaf01" do |device|
    device.vm.hostname = "leaf01"
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_leaf01"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for swp50 --> leaf02:swp50
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net1", auto_config: false , :mac => "443839000001"

      # link for swp51 --> spine01:swp1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net50", auto_config: false , :mac => "443839000057"

      # link for swp52 --> spine02:swp1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net23", auto_config: false , :mac => "44383900002A"

      # link for swp49 --> leaf02:swp49
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net10", auto_config: false , :mac => "443839000011"

      # link for swp48 --> leaf01:swp47
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net40", auto_config: false , :mac => "443839000048"

      # link for swp2 --> server02:eth1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net12", auto_config: false , :mac => "443839000016"

      # link for swp1 --> server01:eth1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net2", auto_config: false , :mac => "443839000004"

      # link for swp47 --> leaf01:swp48
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net40", auto_config: false , :mac => "443839000047"

      # link for swp46 --> leaf01:swp45
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net18", auto_config: false , :mac => "443839000022"

      # link for swp45 --> leaf01:swp46
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net18", auto_config: false , :mac => "443839000021"

      # link for eth0 --> oob-mgmt-switch:swp6
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net20", auto_config: false , :mac => "A00000000011"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype5", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype6", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype7", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype8", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype9", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype10", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype11", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype12", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"



      # Apply the interface re-map
        #Disable default remap on Cumulus VX
      device.vm.provision :shell , inline: "rm -f /etc/init.d/rename_eth_swp"
      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000001 swp50"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000057 swp51"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900002A swp52"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000011 swp49"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000048 swp48"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000016 swp2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000004 swp1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000047 swp47"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000022 swp46"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000021 swp45"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:11 eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for edge01 #####
  config.vm.define "edge01" do |device|
    device.vm.hostname = "edge01"
    device.vm.box = "boxcutter/ubuntu1404"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_edge01"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for eth2 --> exit02:swp1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net7", auto_config: false , :mac => "44383900000C"

      # link for eth1 --> exit01:swp1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net45", auto_config: false , :mac => "443839000050"

      # link for eth0 --> oob-mgmt-switch:swp14
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net39", auto_config: false , :mac => "A00000000051"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_server.sh"



      # Apply the interface re-map

      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900000C eth2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000050 eth1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:51 eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for server01 #####
  config.vm.define "server01" do |device|
    device.vm.hostname = "server01"
    device.vm.box = "boxcutter/ubuntu1404"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_server01"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for eth2 --> leaf02:swp1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net13", auto_config: false , :mac => "443839000017"

      # link for eth1 --> leaf01:swp1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net2", auto_config: false , :mac => "443839000003"

      # link for eth0 --> oob-mgmt-switch:swp2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net41", auto_config: false , :mac => "A00000000031"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_server.sh"



      # Apply the interface re-map

      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000017 eth2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000003 eth1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:31 eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for server03 #####
  config.vm.define "server03" do |device|
    device.vm.hostname = "server03"
    device.vm.box = "boxcutter/ubuntu1404"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_server03"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for eth2 --> leaf04:swp1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net55", auto_config: false , :mac => "443839000061"

      # link for eth1 --> leaf03:swp1
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net22", auto_config: false , :mac => "443839000028"

      # link for eth0 --> oob-mgmt-switch:swp4
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net3", auto_config: false , :mac => "A00000000033"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_server.sh"



      # Apply the interface re-map

      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000061 eth2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000028 eth1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:33 eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for server02 #####
  config.vm.define "server02" do |device|
    device.vm.hostname = "server02"
    device.vm.box = "boxcutter/ubuntu1404"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_server02"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for eth2 --> leaf02:swp2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net15", auto_config: false , :mac => "44383900001B"

      # link for eth1 --> leaf01:swp2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net12", auto_config: false , :mac => "443839000015"

      # link for eth0 --> oob-mgmt-switch:swp3
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net46", auto_config: false , :mac => "A00000000032"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_server.sh"



      # Apply the interface re-map

      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900001B eth2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000015 eth1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:32 eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for server04 #####
  config.vm.define "server04" do |device|
    device.vm.hostname = "server04"
    device.vm.box = "boxcutter/ubuntu1404"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_server04"
      v.memory = 512
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for eth2 --> leaf04:swp2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net26", auto_config: false , :mac => "443839000030"

      # link for eth1 --> leaf03:swp2
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net19", auto_config: false , :mac => "443839000023"

      # link for eth0 --> oob-mgmt-switch:swp5
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net48", auto_config: false , :mac => "A00000000034"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_server.sh"



      # Apply the interface re-map

      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000030 eth2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000023 eth1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a A0:00:00:00:00:34 eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm "
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end

  ##### DEFINE VM for internet #####
  config.vm.define "internet" do |device|
    device.vm.hostname = "internet"
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.provider "virtualbox" do |v|
      v.name = "1461950669_internet"
      v.memory = 256
    end
  config.vm.synced_folder ".", "/vagrant", disabled: true

      # link for swp2 --> exit02:swp44
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net38", auto_config: false , :mac => "443839000044"

      # link for swp1 --> exit01:swp44
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net5", auto_config: false , :mac => "443839000008"

      # link for eth0 --> oob-mgmt-switch:swp15
      device.vm.network "private_network", virtualbox__intnet: "{wbid}_net34", auto_config: false , :mac => "44383900003D"


    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-vms']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-vms']

      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype3", "virtio"]
      vbox.customize ["modifyvm", :id, "--nictype4", "virtio"]

    end

      # Run Any Extra Config
      device.vm.provision :shell , path: "./helper_scripts/config_internet.sh"



      # Apply the interface re-map
        #Disable default remap on Cumulus VX
      device.vm.provision :shell , inline: "rm -f /etc/init.d/rename_eth_swp"
      device.vm.provision "file", source: "./helper_scripts/apply_udev.py", destination: "/home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "chmod 755 /home/vagrant/apply_udev.py"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000044 swp2"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 443839000008 swp1"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -a 44383900003D eth0"


      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -vm --vagrant-name=swp48"
      device.vm.provision :shell , inline: "/home/vagrant/apply_udev.py -s"
      device.vm.provision :shell , inline: "reboot"



  end



end
