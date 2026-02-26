locals {
  cfg = var.region_config[var.location]
}

module "hub" {
  source              = "../hub_network"
  location            = var.location
  hub_cidr            = local.cfg.hub_cidr
  bastion_subnet      = local.cfg.bastion_subnet
  firewall_subnet     = local.cfg.firewall_subnet
  mgmt_subnet         = local.cfg.mgmt_subnet
  environment         = var.environment
  tags                = var.tags
}

module "spoke" {
  source              = "../spoke_network"
  location            = var.location
  spoke_cidr          = local.cfg.spoke_cidr
  app_subnet          = local.cfg.app_subnet
  pe_subnet           = local.cfg.pe_subnet
  environment         = var.environment
  tags                = var.tags
}
