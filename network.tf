# Create the VNET for Private Endpoint
resource "azurerm_virtual_network" "this" {
  name                = "kopicloud-vnet"
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

# Create the Subnet for Private Endpoint
resource "azurerm_subnet" "this" {
  name                = "kopicloud-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_address_space]
}

# Reference Private DNS Zone for OpenAI
data "azurerm_private_dns_zone" "openai_dns_zone" {
  name                = "privatelink.openai.azure.com"
  resource_group_name = local.central_rg_name
}

# Create Private DNS Zone Virtual Network Link
resource "azurerm_private_dns_zone_virtual_network_link" "dfs_dns_zone_vnet_link" {
  name                  = "kopicloud-vnet-link"
  resource_group_name   = local.central_rg_name
  private_dns_zone_name = data.azurerm_private_dns_zone.openai_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.this.id
}

# Create the Private Endpoint
resource "azurerm_private_endpoint" "this" {
  name                = "kopicloud-pe"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.this.id

  private_service_connection {
    name                           = "kopicloud-pe-psc"
    private_connection_resource_id = azurerm_cognitive_account.this.id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.openai_dns_zone.id]
  }
}
