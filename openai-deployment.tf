# Create the Azure Cognitive Deployments
resource "azurerm_cognitive_deployment" "this" {
  for_each = {
    for key, value in var.cognitive_deployment :
    key => value
  }

  name     = each.value.name
  cognitive_account_id = azurerm_cognitive_account.this.id
  
  model {
    format  = each.value.format
    name    = each.value.type
    version = each.value.version
  }

  scale {
    type     = each.value.scale_type
    capacity = each.value.capacity
  }
}
