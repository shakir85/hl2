#!/bin/bash

# 0. Download a distro
# Debian 11
# wget https://cloud.debian.org/images/cloud/bullseye/20220711-1073/debian-11-generic-amd64-20220711-1073.qcow2

# 1. Install these requirements:
# Install libguestfs-tools on Proxmox server
apt-get install libguestfs-tools
# Install qemu-guest-agent on Ubuntu image
virt-customize -a focal-server-cloudimg-amd64.img --install qemu-guest-agent
# Enable password authentication in the template. Obviously, not recommended except for testing
virt-customize -a focal-server-cloudimg-amd64.img --run-command "sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config"

# 2. Set environment variables. Change these as necessary.
export STORAGE_POOL="local-lvm"
export VM_ID="10000" # give it any id number
export VM_NAME="ubuntu-20.04-cloudimg"
export UBUNTU_IMG=""

# Create Proxmox VM image from Ubuntu Cloud Image.
qm create $VM_ID --memory 2048 --net0 virtio,bridge=vmbr0
qm importdisk $VM_ID focal-server-cloudimg-amd64.img $STORAGE_POOL
qm set $VM_ID --scsihw virtio-scsi-pci --scsi0 $STORAGE_POOL:vm-$VM_ID-disk-0
qm set $VM_ID --agent enabled=1,fstrim_cloned_disks=1
qm set $VM_ID --name $VM_NAME

# Create Cloud-Init Disk and configure boot
qm set $VM_ID --ide2 $STORAGE_POOL:cloudinit
qm set $VM_ID --boot c --bootdisk scsi0
qm set $VM_ID --serial0 socket --vga serial0
