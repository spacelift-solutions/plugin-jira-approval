locals {
  suffix = var.suffix == "" ? "" : "-${var.suffix}"
}

variable "suffix" {
  type        = string
  default     = ""
  description = "Suffix to add to the name of resources for uniqueness."
}

variable "stack_label" {
  type        = string
  description = "The label of the stack to attach the plugin to."
}

variable "signing_key" {
  type        = string
  description = "The signing key to use for the plugin."
  sensitive   = true
}

variable "spacelift_api_key_id" {
  type        = string
  description = "The ID of the Spacelift API key to use for the plugin."
}

variable "jira" {
  type = object({
    url             = string
    email           = string
    api_token       = string
    project_key     = string
    custom_field_id = string
    issue_type      = optional(string)
    assignee        = optional(string)
    labels          = optional(list(string))
    initial_status  = optional(string)
  })
  sensitive   = true
  description = "Jira configuration."
}

variable "infracost" {
  type = object({
    api_key   = string
    threshold = number
  })
  sensitive   = true
  description = "Infracost configuration."
}

variable "flows" {
  type = object({
    project_id       = string
    jira_app_id      = string
    spacelift_app_id = string
  })
  description = "Flows configuration."
}