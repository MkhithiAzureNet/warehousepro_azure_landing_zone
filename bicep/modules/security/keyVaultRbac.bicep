////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 04
// Module      : Key Vault RBAC
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Assigns RBAC permissions to Azure Key Vault
////////////////////////////////////////////////////////////

targetScope = 'resourceGroup'

////////////////////////////////////////////////////////////
// PARAMETERS
////////////////////////////////////////////////////////////

@description('Key Vault name')
param keyVaultName string

@description('Principal ID receiving Key Vault access')
param principalId string

@description('Key Vault RBAC role definition ID')
param roleDefinitionId string

////////////////////////////////////////////////////////////
// VARIABLES
////////////////////////////////////////////////////////////

var roleDefinitionResourceId = subscriptionResourceId(
  'Microsoft.Authorization/roleDefinitions',
  roleDefinitionId
)

////////////////////////////////////////////////////////////
// EXISTING RESOURCES
////////////////////////////////////////////////////////////

resource keyVault 'Microsoft.KeyVault/vaults@2024-04-01-preview' existing = {
  name: keyVaultName
}

////////////////////////////////////////////////////////////
// RESOURCES
////////////////////////////////////////////////////////////

resource keyVaultRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(keyVault.id, principalId, roleDefinitionResourceId)

  scope: keyVault

  properties: {
    principalId: principalId
    roleDefinitionId: roleDefinitionResourceId
    principalType: 'ServicePrincipal'
  }
}

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Key Vault RBAC Role Assignment Resource ID')
output roleAssignmentId string = keyVaultRoleAssignment.id
