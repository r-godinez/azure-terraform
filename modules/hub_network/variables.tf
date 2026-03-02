variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "hub_cidr" {
  type = string
}

variable "bastion_subnet" {
  type = string
}

variable "firewall_subnet" {
  type = string
}

variable "mgmt_subnet" {
  type = string
}

variable "tags" {
  type = map(string)
}