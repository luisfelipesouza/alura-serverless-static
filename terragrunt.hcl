locals {
  config          = yamldecode(file(".config.yaml"))
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket          = local.config.backend_bucket
    key             = "statefiles/${path_relative_to_include()}.tfstate"
    region          = local.config.region
    dynamodb_table  = local.config.backend_dynamo
    encrypt         = true
  }
}

generate "provider"{
  path = "version.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
    required_version = "~> 1.0"
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.54"
    }
  }
}
provider "aws" {
  region  = "${local.config.region}"
}
EOF
}

inputs = merge (
  {
    application     = "alura-med"
    cost-center     = "alura"
    deployed-by     = "terragrunt"
  }, 
  local.config
)