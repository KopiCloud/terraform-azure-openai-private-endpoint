# Create the Resource Group
resource "azurerm_resource_group" "this" {
  name     = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-rg"
  location = var.location

  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Access information about an existing User Assigned Identity
resource "azurerm_user_assigned_identity" "this" {
  name     = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-identity"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  tags = {
    application = var.app_name
    environment = var.environment
  }
}

