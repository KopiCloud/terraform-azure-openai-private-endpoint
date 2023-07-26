# Create the Resource Group
resource "azurerm_resource_group" "this" {
  name     = "kopicloud-rg"
  location = var.region

  tags = local.tags
}

# Access information about an existing User Assigned Identity
resource "azurerm_user_assigned_identity" "this" {
  name                = "kopicloud-identity"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}
