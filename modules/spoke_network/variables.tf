variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "spoke_cidr" {
  type = string
}

variable "app_subnet" {
  type = string
}

variable "pe_subnet" {
  type = string
}

variable "tags" {
  type = map(string)
}
