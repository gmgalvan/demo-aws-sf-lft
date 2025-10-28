module "parameters_dev_infra" {
  source      = "../../modules/multiple-parameter-store"
  yaml_file   = "./dev.yaml"
  aws_region  = "us-east-1"
  tenant      = "softserve"
  solution    = "demo"
  environment = "dev"
}

module "parameters_base_infra" {
  source      = "../../modules/multiple-parameter-store"
  yaml_file   = "./general.yaml"
  aws_region  = "us-east-1"
  tenant      = "softserve"
  solution    = "demo"
  environment = "general"
}