# Variables needed to authentiate with Proxmoox
variable "proxmox_api_url" {
  type        = string
  description = "Example: https://yourproxmox.com:8006/api2/json"
}

variable "proxmox_api_token_id" {
  type        = string
  description = "In this format: <Username>@<Realm>!<TokenId>"
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}
# ---------------------------------------
variable "vm_name" {
  type = string
}

variable "vm_description" {
  type = string
}

variable "storage_pool" {
  type        = string
  description = "Enter storage pool: [local, local-lvm, ssd-r10]"
}

variable "disk_size" {
  description = "VM disk size number + M, K or G quoted [e.g. \"8G\"]"
}

variable "vm_cores" {
  description = "Integer number, no quotes [e.g. 2]"
}

variable "vm_sockets" {
  description = "Integer number, no quotes [e.g. 1]"
}

variable "vm_memory" {
  description = "Integer number, no quotes [e.g. 1028]"
}

variable "cloud_images" {
  type        = string
  description = "OS image, choose: [debian11-cloud, centos7-cloud]"
}
