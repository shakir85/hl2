resource "proxmox_lxc" "basic" {
  target_node  = "pve"
  hostname     = var.container_name
  ostemplate   = "local:vztmpl/${var.container_template}"
  password     = var.container_password
  unprivileged = true

  // Terraform will crash without rootfs defined
  rootfs {
    // To let lxc containers use local for storage run:
    // "pvesm set local --content backup,images,iso,rootdir,snippets,vztmpl"
    storage = var.pxmx_storage
    size    = var.disk_size
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }

  features {
    keyctl  = true
    nesting = true
  }
}
