# ==================================================
# Deploy Regions
# ==================================================
module "primary_region" {
  source      = "../../modules/region_stack"
  location    = "westus3"
  region      = "primary"
  environment = "prod"
  region_config = var.region_config
  tags        = var.tags
}

module "secondary_region" {
  source      = "../../modules/region_stack"
  location    = "mexicocentral"
  region      = "secondary"
  environment = "prod"
  region_config = var.region_config
  tags        = var.tags
}
# ==================================================