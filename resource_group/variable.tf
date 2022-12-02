variable "name" {
  type= string
  description = "resource group name"
  default = "sysco_demo_rg"
}

variable "env" {
  type = string
  description = "resource environment tag"
  default = "dev"
}
