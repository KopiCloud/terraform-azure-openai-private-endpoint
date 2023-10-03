# Create the VNET for Private Endpoint
resource "azurerm_virtual_network" "this" {
  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-vnet"
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

# Create the Subnet for Private Endpoint
resource "azurerm_subnet" "this" {
  name                 = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_address_space]

  private_endpoint_network_policies_enabled = true

  service_endpoints = ["Microsoft.CognitiveServices"]
}

# Create Private DNS Zone Virtual Network Link
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-vnet-link"
  resource_group_name   = data.azurerm_private_dns_zone.openai_dns_zone.resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.openai_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.this.id
}

# Create the Private Endpoint
resource "azurerm_private_endpoint" "this" {
  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-pe"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.this.id

  private_service_connection {
    name                           = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-pe-psc"
    private_connection_resource_id = azurerm_cognitive_account.this.id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.openai_dns_zone.id]
  }
}
