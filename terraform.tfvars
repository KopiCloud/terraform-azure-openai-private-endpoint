####################
# Common Variables #
####################
company       = "kopicloud"
app_name      = "openai"
environment   = "dev"
location      = "westeurope"
shortlocation = "we"

##################
# Authentication #
##################
azure-subscription-id = "complete-this"
azure-client-id       = "complete-this"
azure-client-secret   = "complete-this"
azure-tenant-id       = "complete-this"

###########
# Network #
###########
vnet_address_space   = "10.120.0.0/16"
subnet_address_space = "10.120.1.0/24"

##########
# OpenAI #
##########
public_network_access_enabled      = true
outbound_network_access_restricted = true
network_acls_default_action        = "Deny"

cognitive_deployment = [
  {
    name       = "gpt35"
    type       = "gpt-35"
    version    = "0301"
    scale_type = "Standard"
  },
  {
    name       = "gpt35turbo"
    type       = "gpt-35-turbo"
    version    = "0301"
    scale_type = "Standard"
  }
]

#######
# DNS #
#######
private_dns_resource_group = "kopicloud-core-dev-we-dns-rg"
