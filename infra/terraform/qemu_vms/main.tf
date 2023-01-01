resource "proxmox_vm_qemu" "vm_resource" {
  name        = "${var.vm_name}-tf"
  desc        = var.vm_description
  target_node = "pve"
  agent       = 1

  clone   = var.cloud_images
  cores   = var.vm_cores
  sockets = var.vm_sockets
  memory  = var.vm_memory
  cpu     = "host"
  # full_clone = false
  os_type = "cloud-init"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    type    = "scsi"
    storage = var.storage_pool
    size    = var.disk_size
  }

}

# Print DHCP IP on completion
output "dhcp_ip" {
  value = proxmox_vm_qemu.vm_resource.default_ipv4_address
}
