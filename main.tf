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


# print result 
output "workspace" {
  value = data.bitbucket_workspace.workspace_selected
}