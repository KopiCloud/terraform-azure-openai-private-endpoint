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
