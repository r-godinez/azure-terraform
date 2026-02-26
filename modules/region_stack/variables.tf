variable "location" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "region_config" {
  type = map(object({
    hub_cidr        = string
    spoke_cidr      = string
    bastion_subnet  = string
    firewall_subnet = string
    mgmt_subnet     = string
    app_subnet      = string
    pe_subnet       = string
  }))
}

variable "tags" {
  type = map(string)
}
