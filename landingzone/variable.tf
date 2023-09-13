variable "resource_group_location" {
  type        = string
  description = "Location for all resources."
  default     = "eastus"
}

variable "resource_group_name" {
  type        = string
  description = "name of the resource group"
  default     = "testing-keyvault"
}

variable "key_name" {
    type   = string 
    description = "name of the key vault"
    default = "test-7648-132"
}

variable "keyvault_name" {
    type = string 
    description = "name of the key vault key"
    default = "samplekey-test"
  
}
variable "Storage_name" { 
    type    = string 
    description = "name of the stoarge account" 
    default = "testing5463701"
} 

variable "sku_name" { 
     type        = string
     description = "The SKU of the vault to be created."
     default     = "Standard"
} 

variable "keysku_name" {  
    type  = string 
    description = "name of the key vault sku" 
    default = "standard"
  
}

variable "replication_type" { 
    type   = string 
    description = "name of the replication" 
    default = "LRS"
  
}
variable "container_name" { 
    type    = string 
    description = "name of the container"
    default = "sampletest"
  
} 

variable "container_access" {
    type   = string 
    description = "access type" 
    default = "private"
}