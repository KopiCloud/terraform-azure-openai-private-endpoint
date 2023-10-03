## White List Traffic from Public Networks

# Create a white list of IP Addresses
variable "white_list_ip" {
  type        = list(string)
  description = "List of white list of IP Addresses"
  default     = []
}

# Get the Public IP Address 
data "http" "ip" {
  url = "https://ifconfig.me/ip"
}

# Create the Azure Cognitive Account
resource "azurerm_cognitive_account" "this" {
  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-aca"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kind                = var.cognitive_account_kind_name
  sku_name            = var.cognitive_account_sku_name

  public_network_access_enabled      = var.public_network_access_enabled
  outbound_network_access_restricted = var.outbound_network_access_restricted

  custom_subdomain_name = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}"

  network_acls {
    default_action = var.network_acls_default_action
 
    ip_rules = concat(var.network_acls_ip_rules, formatlist(data.http.ip.response_body))
    
    virtual_network_rules {
      subnet_id = azurerm_subnet.this.id
    }
  }

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  tags = {
    application = var.app_name
    environment = var.environment
  }
}
