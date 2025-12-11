terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "1.40.0"
    }
    flows = {
      source  = "spacelift-io/flows"
      version = "0.2.0"
    }
  }
}

locals {
  plugin_manifest = templatefile("${path.module}/plugin.yaml", {
    threshold  = var.infracost.threshold
    api_key_id = var.spacelift_api_key_id
  })
}

resource "spacelift_plugin_template" "this" {
  name        = "jira-approval${local.suffix}"
  description = yamldecode(local.plugin_manifest).description
  manifest    = local.plugin_manifest
}

resource "spacelift_plugin" "this" {
  plugin_template_id = spacelift_plugin_template.this.id
  name               = "jira-approval${local.suffix}"
  stack_label        = var.stack_label
  parameters = {
    jira_url            = var.jira.url
    jira_email          = var.jira.email
    jira_api_token      = var.jira.api_token
    jira_project_key    = var.jira.project_key
    jira_issue_type     = try(var.jira.issue_type, "")
    jira_assignee       = try(var.jira.assignee, "")
    jira_labels         = try(join(",", var.jira.labels), "")
    jira_initial_status = try(var.jira.initial_status, "")
    infracost_api_key   = var.infracost.api_key
    custom_field_id     = var.jira.custom_field_id
    signing_key         = var.signing_key
  }
}

resource "flows_flow" "this" {
  project_id = var.flows.project_id
  name       = "Jira approval flow${local.suffix}"
  definition = file("${path.module}/flow.yaml")
  app_installation_mapping = {
    jira      = var.flows.jira_app_id
    spacelift = var.flows.spacelift_app_id
  }
}