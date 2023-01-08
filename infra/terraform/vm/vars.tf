/*  Available values for the following ariables:
      cloud_init_template = [debian11-cloud, centos7-cloud]
      storage_pool = [local, local-lvm, ssd-r10]
*/
variable "proxmox_host" {
  default = "10.10.50.20"
}

variable "vms" {
  default = {
    # Copy/paste this block to create more VMs
    "test01" = {
      hostname    = "tf-test01"
      target_node = "pve",
      # vlan_tag          = 200,
      ip_address          = "10.10.50.174/24"
      default_gateway     = "10.10.50.10"
      cpu_cores           = 2,
      cpu_sockets         = 1,
      memory              = "1024",
      hdd_size            = "8G",
      storage_pool        = "local-lvm"
      cloud_init_template = "debian11-cloud",
      vm_description      = "testing multi vm pxmpx 1",
      tags                = "tftest tag2 tag3"
    },
    "test02" = {
      hostname    = "tf-test02"
      target_node = "pve",
      # vlan_tag          = 200,
      ip_address          = "10.10.50.175/24"
      default_gateway     = "10.10.50.10"
      cpu_cores           = 2,
      cpu_sockets         = 1,
      memory              = "1024",
      hdd_size            = "8G",
      storage_pool        = "local-lvm"
      cloud_init_template = "debian11-cloud",
      vm_description      = "testing multi vm pxmpx 1",
      tags                = "tftest tag2 tag3"
    },
  }
}
