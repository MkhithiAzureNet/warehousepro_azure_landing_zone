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
// EXISTING RESOURCES
////////////////////////////////////////////////////////////

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
}

////////////////////////////////////////////////////////////
// RESOURCES
////////////////////////////////////////////////////////////

resource keyVaultRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(keyVault.id, principalId, roleDefinitionId)

  scope: keyVault

  properties: {
    principalId: principalId
    roleDefinitionId: roleDefinitionId
    principalType: 'ServicePrincipal'
  }
}

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Key Vault RBAC Role Assignment Resource ID')
output roleAssignmentId string = keyVaultRoleAssignment.id
