#! /bin/bash

MASTER_NODE_VM_NAME=k8s-master-test1
WORKER1_VM_NAME=k8s-worker1-test1
WORKER2_VM_NAME=k8s-worker2-test1

USERNAME=$SUDO_USER

for vm in $MASTER_NODE_VM_NAME $WORKER1_VM_NAME $WORKER2_VM_NAME
do
# Create k8s master and worker node vms
VBoxManage createvm --basefolder /$USERNAME/VirtualBox\ VMs/$vm/$vm.vbox --name $vm --ostype Ubuntu_64 --register

# Create storage mediums for vms
VBoxManage createmedium --filename /home/$USERNAME/VirtualBox\ VMs/$vm/$vm.vdi --size 10240

# Download ubuntu iso image
#wget -O ubuntu-22.04-server-amd64.iso "https://releases.ubuntu.com/22.04/ubuntu-22.04-live-server-amd64.iso?_ga=2.167925473.1971089893.1655198826-230278046.1654672308"

# Add and attach SATA and IDE Storage Controllers
VBoxManage storagectl $vm --name SATA --add SATA --controller IntelAhci
VBoxManage storageattach $vm --storagectl SATA --port 0 --device 0 --type hdd --medium /home/$USERNAME/VirtualBox\ VMs/$vm/$vm.vdi

VBoxManage storagectl $vm --name IDE --add ide
VBoxManage storageattach $vm --storagectl IDE --port 0 --device 0 --type dvddrive --medium ubuntu-22.04-server-amd64.iso

done
