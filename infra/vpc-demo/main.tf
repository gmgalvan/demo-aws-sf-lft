module "vpc" {
  source     = "../modules/vpc"
  name       = "${local.demo_prefix}-vpc"
  cidr       = local.aws_vpc_cidr
  aws_region = local.aws_region

  public_subnet_count  = local.vpc_public_subnet_count
  private_subnet_count = local.vpc_private_subnet_count

  availability_zones = local.vpc_availability_zones

  enable_nat_gateway         = true
  enable_s3_gateway_endpoint = true

  # Flow Logs (enabled=true, 3 days, 600s)
  enable_flow_logs               = true
  flow_logs_retention_days       = 3
  flow_logs_aggregation_interval = 600

  additional_tags = {
    Solution    = local.solution
    Tenant      = local.tenant
    Environment = local.environment
  }
}
 