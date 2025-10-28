locals {
  demo_prefix                 = "${lower(var.solution)}-${lower(var.tenant)}-${lower(var.environment)}"
  account_id                 = data.aws_caller_identity.current.account_id
  aws_vpc_cidr               = "10.80.0.0/16"
  aws_region                 = var.aws_region
  vpc_public_subnet_count    = tonumber(var.vpc_public_subnet_count)
  vpc_private_subnet_count   = tonumber(var.vpc_private_subnet_count)
  vpc_availability_zones     = slice(data.aws_availability_zones.available.names, 0, 3)

  solution    = var.solution
  tenant      = var.tenant
  environment = var.environment
}
