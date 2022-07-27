variable "access" {
  type = object({
    username         = string
    password     = string
  })
  default = {
    username         = "value"
    password     = "value"
  }
}


variable "workspace" {
  type = object({
    workspaceID         = string
  })
  default = {
    workspaceID         = "value"
  }
}

