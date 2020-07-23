#!/bin/bash

echo "#################################"
echo "  Running Switch Post Config (config_switch.sh)"
echo "#################################"
sudo su


## Convenience code. This is normally done in ZTP.



echo "#################################"
echo "   Finished"
echo "#################################"
cat << EOT >> /home/cumulus/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDee1uZVFHxptB43LP8dSR5rNjqmPhuzwYbB1KgDTbssc7fha4lB9rDLSjuiAGWSM3iq1RHrpzED0uTMc9i0wawDmPb2TglELIrPXas2mpx5c/j7GnjypMAX3NhBimKq5jZR d+AmfE4Y1bTl0nKeWjucZDgwnpP1x6gcR2xGDZzy1HHAHDP0JvE8QCbxKq/SgMl7nXE+j1cvXxTy9sjF4OBLIKtdw7P/Qqkc3GfsgzKSgSNp/s/crmr5SJ7fv2s20nZCw81hgJZ3orNpPRsFFAtRbP6QnX4o8JQVyJAEVVlb0gQ byKuTDmZj/FFhq46SYqo5kUx0loaYns9dPmitfy5 stefano@Ubuntu-VirtualBox
EOT
