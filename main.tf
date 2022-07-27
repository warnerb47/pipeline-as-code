terraform {
  required_providers {
    bitbucket = {
      source = "DrFaust92/bitbucket"
      version = "2.17.0"
    }
  }
}

# load config file
locals {
  input_file         = "./config.yml"
  input_file_content = fileexists(local.input_file) ? file(local.input_file) : "NoInputFileFound: true"
  input              = yamldecode(local.input_file_content)
}


# Configure the Bitbucket Provider
provider "bitbucket" {
  username = local.input.access.username
  password = local.input.access.password 
}


data "bitbucket_workspace" "workspace_selected" {
  workspace = local.input.workspace.workspaceID
}

# resource "bitbucket_project" "terraform_project" {
#   owner = "warnerb47"
#   name  = "terraform"
#   key   = "terraform"
#   description = "automate project, repositories and pipeline creation with terraform"
#   is_private = false
# }


# resource "bitbucket_repository" "terraform_repository" {
#   owner = "warnerb47"
#   name  = "terraformcode"
#   is_private = false
#   description = "this repository has been created with terraform"
#   pipelines_enabled = true
#   project_key = "terraform"
# }


# resource "bitbucket_repository_variable" "debug" {
#   key        = "DEBUG"
#   value      = "true"
#   repository = "${bitbucket_repository.terraform_repository.id}"
#   secured    = false
# }

# resource "bitbucket_deployment" "test" {
#   repository = "${bitbucket_repository.terraform_repository.id}"
#   name       = "test"
#   stage      = "Test"
# }
# resource "bitbucket_deployment_variable" "port" {
#   deployment = "${bitbucket_deployment.test.id}"
#   key       = "PORT"
#   value      = "5000"
#   secured    = false
# }


# resource "bitbucket_pipeline_ssh_key" "terraform_ssh_key" {
#   workspace  = "${data.bitbucket_workspace.workspace_selected.id}"
#   repository = "${bitbucket_repository.terraform_repository.id}"  
#   public_key  = "public_key"
#   private_key = "test-key"
# }

# resource "bitbucket_pipeline_ssh_known_host" "test" {
#   workspace  = "${data.bitbucket_workspace.workspace_selected.id}"
#   repository = "${bitbucket_repository.terraform_repository.id}"
#   hostname   = "18.216.17.9:22"

#   public_key {
#     key_type = "RSA" 
#     key      = base64encode("ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3TYmESsR2bqxEbxU1V/gQWmGyMNNS9nX4qt4Oz+6sOohM4snRTHPdL7IoDADUIa0dlGHWltfwwnAOjaUcOUTjfzzza5xi7pp0Ed5Rqaf+zbdmY3bjWPe8KCNYhygy4GE2ligLrDelK8gYoe0ZNPHCLPvo4nHbQCn439rksODwZAxpsauwzP4Y8AGvZ4FfdiVooJs1DUypVDrmUvMOALWI2KNOI06MNcD/VoYgQi8SWnAXgFw4EdBM58rprwZdtagjys798JC46IVLb467taPwZcOwSQAxAf0/JmR3XSl4uLvw/7yf3lMn6S2m1lL92IWcmiqyzgujQbWNRbOjuyIJ")
#   }
# }

# print result 
output "workspace" {
  value = data.bitbucket_workspace.workspace_selected
}