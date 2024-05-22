################################
## Azure Provider - Variables ##
################################

# Azure authentication variables

variable "azure-subscription-id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "azure-client-id" {
  type        = string
  description = "Azure Client ID"
}

variable "azure-client-secret" {
  type        = string
  description = "Azure Client Secret"
}

variable "azure-tenant-id" {
  type        = string
  description = "Azure Tenant ID"
}

#############################
## Application - Variables ##
#############################

# Company name 
variable "company" {
  type        = string
  description = "This variable defines the company name used to build resources"
}

# Application name 
variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
}

# Environment
variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
}

# Azure region
variable "location" {
  type        = string
  description = "Azure region where resources will be created"
  default     = "west europe"
}

# Azure short region
variable "shortlocation" {
  type        = string
  description = "Azure region where resources will be created"
  default     = "we"
}

#########################
## Network - Variables ##
#########################

variable "vnet_address_space" {
  type        = string
  description = "VNET for OpenAI VNET"
}

variable "subnet_address_space" {
  type        = string
  description = "Subnet for OpenAI Public Endpoint"
}

####################################
## Cognitive Services - Variables ##
####################################

variable "cognitive_account_sku_name" {
  type        = string
  description = "Specifies the SKU Name for this Cognitive Service Account"
  default     = "S0"
}

variable "cognitive_account_kind_name" {
  type        = string
  description = "Specifies the SKU Name for this Cognitive Service Account"
  default     = "OpenAI"
}

variable "cognitive_deployment" {
  description = "List of Cognitive Deployments"
  type = list(object({
    name       = string
    format     = string
    type       = string
    version    = string
    scale_type = string
    capacity   = number
  }))
  default = [
    {
      name       = "gpt35"
      format     = "OpenAI"
      type       = "gpt-35-turbo"
      version    = "0301"
      scale_type = "Standard"
      capacity   = 10
    }
  ]
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access"
  default     = false
}

variable "outbound_network_access_restricted" {
  type        = bool
  description = "Whether outbound network access is restricted for the Cognitive Account"
  default     = true
}

variable "network_acls_default_action" {
  type        = string
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_rules. Possible values are Allow and Deny."
  default     = "Deny"
}

variable "network_acls_ip_rules" {
  type        = list(string)
  description = "One or more IP Addresses, or CIDR Blocks, which should be able to access the Cognitive Account."
  default     = []
}

#####################
## DNS - Variables ##
#####################

variable "private_dns_resource_group" {
  type        = string
  description = "The Resource Group where the Private DNS for OpenAI was created"
}
