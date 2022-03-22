include {
    path = find_in_parent_folders()
}
//locals {
//  config = yamldecode(file(find_in_parent_folders(".config.yaml")))
//}
terraform {
  source  = "git::git@github.com:luisfelipesouza/tf-module-cognito-auth.git"
}