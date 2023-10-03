# Deploying Azure OpenAI ChatGPT with Private Endpoint using Terraform
[![Terraform](https://img.shields.io/badge/terraform-v1.5+-blue.svg)](https://www.terraform.io/downloads.html)

## Overview

Deploying an Azure OpenAI with ChatGPT or Azure Cognitive Service with Private Endpoint

## Code creates:

- Resource Group for Network
- VNET and Subnet for Private Endpoint
- Azure OpenAI/Cognitive Service Instance
- Azure OpenAI/Cognitive Service Deployment

## Azure OpenAI Service Instance Variables

List of variables used in this code to configure the Azure OpenAI Service Instance

Variable | Description | Type
--- | --- | ---
`region` | The region in which this module should be deployed | `string`
`cognitive_account_sku_name` | Specifies the SKU Name for this Cognitive Service Account. Default: S0 | `string`
`cognitive_account_kind_name` | Specifies the type of Cognitive Service Account that should be created. Default: OpenAI | `string`
`vnet_address_space` | CIDR of the VNET used for the Private Endpoint | `string`
`subnet_address_space` | CIDR of the Subnet used for the Private Endpoint | `string`
`public_network_access_enabled` | Enable public network access. Default: false | `bool`
`outbound_network_access_restricted` | Whether outbound network access is restricted for the Cognitive Account. Default: true | `bool`
`network_acls_default_action` | The Default Action to use when no rules match from ip_rules / virtual_network_rules. Possible values are Allow and Deny. Default: "Deny" | `string`
`network_acls_ip_rules` | One or more IP Addresses, or CIDR Blocks which should be able to access the Cognitive Account | `list(string)`
`private_dns_resource_group` | The Resource Group where the Private DNS for OpenAI was created | `string` 

> Note: `cognitive_account_kind_name` Possible values are Academic, AnomalyDetector, Bing.Autosuggest, Bing.Autosuggest.v7, Bing.CustomSearch, Bing.Search, Bing.Search.v7, Bing.Speech, Bing.SpellCheck, Bing.SpellCheck.v7, CognitiveServices, ComputerVision, ContentModerator, CustomSpeech, CustomVision.Prediction, CustomVision.Training, Emotion, Face, FormRecognizer, ImmersiveReader, LUIS, LUIS.Authoring, MetricsAdvisor, OpenAI, Personalizer, QnAMaker, Recommendations, SpeakerRecognition, Speech, SpeechServices, SpeechTranslation, TextAnalytics, TextTranslation and WebLM.

## Azure OpenAI Deployments Variables

Variable | Description | Type
--- | --- | ---
`cognitive_deployment` | List of Azure OpenAI Cognitive Deployments | `list(object)`
  
  type = list(object({
    name       = string --> Name of the Deployment
    type       = string --> Type of the Deployment
    version    = string --> Version of the Deployment
    scale_type = string --> Scale Type of the Deployment
  }))
  
  default = [
    {
      name       = "gpt35"
      type       = "gpt-35-turbo"
      version    = "0301"
      scale_type = "Standard"
    }
  ]

## How To deploy the code:

- Clone the repo
- Update variables to your environment
- Execute "terraform init"
- Execute "terraform apply"

## Private DNS Zone

A private DNS zone is required, if you need one, use the code below:

```
# Create the Resource Group for DNS Zone
resource "azurerm_resource_group" "dns_zone" {
  name     = "kopicloud-dns-rg"
  location = var.location
}

# Create Private DNS Zone for OpenAI
resource "azurerm_private_dns_zone" "openai" {
  name                = "privatelink.openai.azure.com"
  resource_group_name = azurerm_resource_group.dns_zone.name
}
```