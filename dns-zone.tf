# Reference to Private DNS Zone for OpenAI
data "azurerm_private_dns_zone" "openai_dns_zone" {
  name                = "privatelink.openai.azure.com"
  resource_group_name = var.private_dns_resource_group
}