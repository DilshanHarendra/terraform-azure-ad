variable "display_name" {
  type = string
  description = "This is application display name"
  default = "application_1"
}

variable "tenant_id" {
  type = string
  description = "This is tenant id"
}

variable "api_application" {
  type  = any
  description = "This is  api application"
}
