module "galaxy" {
  source              = "./modules/vm"
  pvt_key_path        = "/home/shakir/.ssh/id_rsa"
  default_user        = "shakir"
  inventory_path      = "../../../ansible/playbooks/inventory.ini"
  hostname            = "galaxy"
  target_node         = "pve"
  ip_address          = "10.10.50.30/24"
  default_gateway     = "10.10.50.10"
  cpu_cores           = 2
  cpu_sockets         = 1
  memory              = "4096"
  hdd_size            = "128G"
  storage_pool        = "ssd-r10"
  cloud_init_template = "debian11-cloud"
  vm_description      = "Main apps host"
  tags                = "galaxy prod debian11"
  ansible_command     = "../../../ansible/playbooks/galaxy.playbook.yml"
  ip_without_cidr     = "10.10.50.30"
  backup_enabled      = 1
}

module "mediaserver" {
  source              = "./modules/vm"
  pvt_key_path        = "/home/shakir/.ssh/id_rsa"
  default_user        = "shakir"
  inventory_path      = "../../../ansible/playbooks/inventory.ini"
  hostname            = "mediaserver"
  target_node         = "pve"
  ip_address          = "10.10.50.31/24"
  default_gateway     = "10.10.50.10"
  cpu_cores           = 2
  cpu_sockets         = 2
  memory              = "16384"
  hdd_size            = "128G"
  storage_pool        = "ssd-r10"
  cloud_init_template = "debian11-cloud"
  vm_description      = "Media server"
  tags                = "media-server prod debian11"
  ansible_command     = "../../../ansible/playbooks/mediaserver.playbook.yml"
  ip_without_cidr     = "10.10.50.31"
  backup_enabled      = 1

  depends_on = [
    module.galaxy
  ]
}

module "mediaintake" {
  source              = "./modules/vm"
  pvt_key_path        = "/home/shakir/.ssh/id_rsa"
  default_user        = "shakir"
  inventory_path      = "../../../ansible/playbooks/inventory.ini"
  hostname            = "mediaintake"
  target_node         = "pve"
  ip_address          = "10.10.50.32/24"
  default_gateway     = "10.10.50.10"
  cpu_cores           = 2
  cpu_sockets         = 1
  memory              = "16384"
  hdd_size            = "128G"
  storage_pool        = "ssd-r10"
  cloud_init_template = "debian11-cloud"
  vm_description      = "Media ingestion from various sources"
  tags                = "media-intake prod debian11"
  ansible_command     = "../../../ansible/playbooks/mediaintake.playbook.yml"
  ip_without_cidr     = "10.10.50.32"
  backup_enabled      = 1

  depends_on = [
    module.mediaserver
  ]
}

module "devops" {
  source              = "./modules/vm"
  pvt_key_path        = "/home/shakir/.ssh/id_rsa"
  default_user        = "shakir"
  inventory_path      = "../../../ansible/playbooks/inventory.ini"
  hostname            = "devops"
  target_node         = "pve"
  ip_address          = "10.10.50.33/24"
  default_gateway     = "10.10.50.10"
  cpu_cores           = 2
  cpu_sockets         = 1
  memory              = "1026"
  hdd_size            = "24G"
  storage_pool        = "ssd-r10"
  cloud_init_template = "debian11-cloud"
  vm_description      = "Testing, CI/CD, and build vm"
  tags                = "devops dev debian11"
  ansible_command     = "../../../ansible/playbooks/devops.playbook.yml"
  ip_without_cidr     = "10.10.50.33"
  backup_enabled      = 1

  depends_on = [
    module.mediaintake
  ]
}
