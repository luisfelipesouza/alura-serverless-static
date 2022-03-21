include {
    path = find_in_parent_folders()
}
locals {
  config = yamldecode(file(find_in_parent_folders(".config.yaml")))
}
terraform {
  source  = "git::git@github.com:luisfelipesouza/tf-module-static-site.git"
}

inputs = {
  bucket_name     = "alura-serverless-fullstak"
  application     = "alura-med"
  cost-center     = "alura"
  deployed-by     = "terragrunt"
  content_path    = local.config.content_path
}