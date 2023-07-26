# Create the Azure Cognitive Account
resource "azurerm_cognitive_account" "this" {
  name                = "kopicloud-aca"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kind                = "OpenAI"
  sku_name            = var.cognitive_account_sku_name

  public_network_access_enabled      = var.public_network_access_enabled
  outbound_network_access_restricted = var.outbound_network_access_restricted

  custom_subdomain_name = "kopicloud-openai-${azurerm_resource_group.this.location}"

  network_acls {
    default_action = var.network_acls_default_action
    ip_rules       = var.network_acls_ip_rules
  }

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }
}

# Create the Azure Cognitive Deployment
resource "azurerm_cognitive_deployment" "this" {
  name                 = "kopicloud-acd"
  cognitive_account_id = azurerm_cognitive_account.this.id
  
  model {
    format  = "OpenAI"
    name    = var.cognitive_deployment_name
    version = var.cognitive_deployment_version
  }

  scale {
    type = var.cognitive_deployment_scale_type
  }
}

