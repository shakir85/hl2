/*  Available values for the following variables:
      cloud_init_template = [debian11-cloud, centos7-cloud]
      storage_pool = [local, local-lvm, ssd-r10]
    All paths below are relevant to this Terraform module.
*/
variable "proxmox_host" {
  default = "10.10.50.20"
}

variable "inventory_path" {
  default = "../../ansible/playbooks/inventory.ini"
}

variable "vms" {
  default = {
    "galaxy" = {
      hostname            = "galaxy",
      target_node         = "pve",
      ip_address          = "10.10.50.30/24",
      default_gateway     = "10.10.50.10",
      cpu_cores           = 2,
      cpu_sockets         = 1,
      memory              = "4096",
      hdd_size            = "128G",
      storage_pool        = "ssd-r10"
      cloud_init_template = "debian11-cloud",
      vm_description      = "Main host for hosted apps",
      tags                = "galaxy prod debian11",
      ansible_command     = "../../ansible/playbooks/galaxy.playbook.yml"
    },
    "mediaserver" = {
      hostname            = "mediaserver",
      target_node         = "pve",
      ip_address          = "10.10.50.31/24",
      default_gateway     = "10.10.50.10",
      cpu_cores           = 2,
      cpu_sockets         = 2,
      memory              = "16384",
      hdd_size            = "128G",
      storage_pool        = "ssd-r10"
      cloud_init_template = "debian11-cloud",
      vm_description      = "Media servers",
      tags                = "media-server prod debian11",
      ansible_command     = "../../ansible/playbooks/mediaserver.playbook.yml"
    },
    "mediaintake" = {
      hostname            = "mediaintake",
      target_node         = "pve",
      ip_address          = "10.10.50.32/24",
      default_gateway     = "10.10.50.10",
      cpu_cores           = 2,
      cpu_sockets         = 2,
      memory              = "2048",
      hdd_size            = "128G",
      storage_pool        = "ssd-r10"
      cloud_init_template = "debian11-cloud",
      vm_description      = "Media ingestion from various sources",
      tags                = "media-intake prod debian11",
      ansible_command     = "../../ansible/playbooks/mediaintake.playbook.yml"
    },
    "devops" = {
      hostname            = "devops",
      target_node         = "pve",
      ip_address          = "10.10.50.33/24",
      default_gateway     = "10.10.50.10",
      cpu_cores           = 2,
      cpu_sockets         = 1,
      memory              = "1026",
      hdd_size            = "24G",
      storage_pool        = "ssd-r10"
      cloud_init_template = "debian11-cloud",
      vm_description      = "Machine for dev and and varios ops (plumbing) tasks!",
      tags                = "devops dev debian11",
      ansible_command     = "../../ansible/playbooks/devops.playbook.yml"
    },
    # "harbor" = {
    #   hostname            = "harbor",
    #   target_node         = "pve",
    #   ip_address          = "10.10.50.34/24",
    #   default_gateway     = "10.10.50.10",
    #   cpu_cores           = 2,
    #   cpu_sockets         = 1,
    #   memory              = "4096",
    #   hdd_size            = "40G",
    #   storage_pool        = "ssd-r10"
    #   cloud_init_template = "debian11-cloud",
    #   vm_description      = "Artifacts registry",
    #   tags                = "harbor prod debian11",
    #   ansible_command     = "../../ansible/playbooks/harbor.playbook.yml"
    # },
  }
}
