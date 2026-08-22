////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 04
// Module      : Managed Identity
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Deploys a User-Assigned Managed Identity
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

var managedIdentityName = 'MI-WarehousePro-${environment}'

////////////////////////////////////////////////////////////
// RESOURCES
////////////////////////////////////////////////////////////

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: managedIdentityName
  location: location
}

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Managed Identity Resource ID')
output managedIdentityId string = managedIdentity.id

@description('Managed Identity Principal ID')
output principalId string = managedIdentity.properties.principalId

@description('Managed Identity Client ID')
output clientId string = managedIdentity.properties.clientId

@description('Managed Identity Name')
output managedIdentityName string = managedIdentity.name
