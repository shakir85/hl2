/*
Requirement:
  - A pre-configured cloud-init template
*/
resource "proxmox_vm_qemu" "vm_resource" {
  for_each = var.vms

  name        = each.value.hostname
  desc        = each.value.vm_description
  target_node = each.value.target_node
  agent       = 1

  # Read this doc, and understand its implications, before enabling full_clone:
  # https://pve.proxmox.com/pve-docs/chapter-qm.html#qm_copy_and_clone
  # When this attribute is set to 'false', Proxmox will do linked clones.
  # full_clone = false

  os_type   = "cloud-init"
  clone     = each.value.cloud_init_template
  cpu       = "host"
  cores     = each.value.cpu_cores
  sockets   = each.value.cpu_sockets
  memory    = each.value.memory
  ipconfig0 = "ip=${each.value.ip_address},ip6=dhcp,gw=${each.value.default_gateway}"
  tags      = each.value.tags
  # scsihw = "virtio-scsi-pci"

  network {
    bridge = "vmbr0"
    model  = "virtio"
    # tag = each.value.vlan_tag
  }

  disk {
    type     = "scsi"
    storage  = each.value.storage_pool
    size     = each.value.hdd_size
    slot     = 0
    iothread = 0
    backup   = 0 # change to 1 pre-prod
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  provisioner "local-exec" {
    connection {
      host = each.value.ip_address
      type = "ssh"
      user = "root"
    }
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${var.inventory_path} ${each.value.ansible_command}"
  }
}
