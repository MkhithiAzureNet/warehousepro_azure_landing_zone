////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 04
// Module      : Azure Key Vault
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Deploys Azure Key Vault for secure secret management
////////////////////////////////////////////////////////////

targetScope = 'resourceGroup'

////////////////////////////////////////////////////////////
// PARAMETERS
////////////////////////////////////////////////////////////

@description('Deployment location')
param location string

@description('Environment name')
param environment string

////////////////////////////////////////////////////////////
// VARIABLES
////////////////////////////////////////////////////////////

var keyVaultName = 'KV-WarehousePro-${environment}'

////////////////////////////////////////////////////////////
// RESOURCES
////////////////////////////////////////////////////////////

resource keyVault 'Microsoft.KeyVault/vaults@2024-04-01-preview' = {
  name: keyVaultName
  location: location

  properties: {
    tenantId: tenant().tenantId

    enableRbacAuthorization: true
    enableSoftDelete: true
    enablePurgeProtection: true

    publicNetworkAccess: 'Disabled'

    sku: {
      family: 'A'
      name: 'standard'
    }
  }
}

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Azure Key Vault Resource ID')
output keyVaultId string = keyVault.id

@description('Azure Key Vault Name')
output keyVaultName string = keyVault.name

@description('Azure Key Vault URI')
output keyVaultUri string = keyVault.properties.vaultUri
