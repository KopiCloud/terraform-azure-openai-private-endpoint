variable "region" {
  type        = string
  description = "The region in which this module should be deployed"
}

variable "cognitive_account_sku_name" {
  type        = string
  description = "Specifies the SKU Name for this Cognitive Service Account"
  default     = "S0"
}

variable "cognitive_deployment_name" {
  type        = string
  description = "The name of the Cognitive Services Account Deployment model"
  default     = "gpt-35-turbo"
}

variable "cognitive_deployment_version" {
  type        = string
  description = "The version of the Cognitive Services Account Deployment model"
  default     = "0301"
}

variable "cognitive_deployment_scale_type" {
  type        = string
  description = "Deployment scale type"
  default     = "Standard"
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

variable "vnet_address_space" {
  type        = string
  description = "VNET for OpenAI Public Endpoint"
}

variable "subnet_address_space" {
  type        = string
  description = "Subnet for OpenAI Public Endpoint"
}

variable "network_acls_default_action" {
  type        = string
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_rules. Possible values are Allow and Deny."
  default     = "Deny"
}

variable "network_acls_ip_rules" {
  type        = list(string)
  description = "One or more IP Addresses, or CIDR Blocks which should be able to access the Cognitive Account."
  default     = []
}
