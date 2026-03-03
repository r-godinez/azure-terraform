variable "environment" {
  type        = string
  description = "Environment name (prod, dev, etc)"
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
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