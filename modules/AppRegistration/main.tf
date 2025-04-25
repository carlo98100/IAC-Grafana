locals {
  microsoft_graph_scope_id = "00000003-0000-0000-c000-000000000000"
  email_scope_id           = "64a6cdd6-aab1-4aaf-94b8-3cc8405e90d0"
  openid_scope_id          = "37f7f235-527c-4136-accd-4a02d197296e"
  profile_scope_id         = "14dad69e-099b-42c9-810b-d002981feec1"
}

resource "random_uuid" "generated_uuid_viewer_role" {
}

resource "random_uuid" "generated_uuid_editor_role" {
}

resource "random_uuid" "generated_uuid_admin_role" {
}

resource "azuread_application" "grafana_app_reg" {
  display_name = var.display_name

  required_resource_access {
    resource_app_id = local.microsoft_graph_scope_id #Microsoft Graph
    resource_access {
      id   = local.email_scope_id #Email
      type = "Scope"
    }
    resource_access {
      id   = local.openid_scope_id #OpenId
      type = "Scope"
    }
    resource_access {
      id   = local.profile_scope_id #Profile
      type = "Scope"
    }
  }

  web {
    redirect_uris = var.redirect_urls
  }

  app_role {
    allowed_member_types = [
      "User",
    ]
    description  = "Grafana Viewer role"
    display_name = "Grafana Viewer"
    enabled      = true
    id           = random_uuid.generated_uuid_viewer_role.result
    value        = "Viewer"
  }

  app_role {
    allowed_member_types = [
      "User",
    ]
    description  = "Editor role for Grafana"
    display_name = "Grafana Editor"
    enabled      = true
    id           = random_uuid.generated_uuid_editor_role.result
    value        = "Editor"
  }

  app_role {
    allowed_member_types = [
      "User",
    ]
    description  = "Grafana Admin role"
    display_name = "Grafana Admin"
    enabled      = true
    id           = random_uuid.generated_uuid_admin_role.result
    value        = "Admin"
  }
}

resource "azuread_application_password" "grafana_app_reg_secret" {
  application_id = azuread_application.grafana_app_reg.id
  display_name   = "grafana secret"
}
