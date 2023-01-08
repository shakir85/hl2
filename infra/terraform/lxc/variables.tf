variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "container_password" {
  type      = string
  sensitive = true
}

variable "container_name" {
  type = string
}

variable "disk_size" {
  type        = string
  description = "Lxc disk size number + M, K or G quoted [e.g. \"8G\"]"
}

variable "pxmx_storage" {
  type        = string
  description = "Enter storage pool [local, local-lvm, ssd-r10]"
}

variable "container_template" {
  type        = string
  description = "Copy & paste a lxc template: \n\tubuntu-20.04-standard_20.04-1_amd64.tar.gz\n\tcentos-7-default_20190926_amd64.tar.xz"
}
