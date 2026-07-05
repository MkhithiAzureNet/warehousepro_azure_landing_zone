////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 03
// Module      : Main Deployment
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Orchestrates the WarehousePro Azure Landing Zone
////////////////////////////////////////////////////////////

targetScope = 'subscription'

////////////////////////////////////////////////////////////
// MODULE INFORMATION
////////////////////////////////////////////////////////////

// Scope      : Subscription
// Depends On : None
// Deploys    : Complete Azure Landing Zone
// Returns    : Module deployment outputs

////////////////////////////////////////////////////////////
// PARAMETERS
////////////////////////////////////////////////////////////

@description('Deployment location')
param location string

@description('Environment name')
param environment string

////////////////////////////////////////////////////////////
// STAGE 1 - FOUNDATION
////////////////////////////////////////////////////////////

// Creates the enterprise resource groups.

module resourceGroups './modules/foundation/resourceGroups.bicep' = {
  name: 'resourceGroupsDeployment'

  params: {
    location: location
    environment: environment
  }
}

////////////////////////////////////////////////////////////
// VARIABLES
////////////////////////////////////////////////////////////

// None required

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

// None

////////////////////////////////////////////////////////////
// STAGE 2 - NETWORKING
////////////////////////////////////////////////////////////

// Creates the Hub Virtual Network.

module hubVirtualNetwork './modules/networking/hubVirtualNetwork.bicep' = {
  name: 'hubVirtualNetworkDeployment'

  scope: resourceGroup('RG-Networking-${environment}')

  params: {
    location: location
    environment: environment
  }
}

// Creates the Hub subnets.

module hubSubnets './modules/networking/hubSubnets.bicep' = {
    name: 'hubSubnetsDeployment'

    scope: resourceGroup('RG-Networking-${environment}')

    params: {
        location: location
        environment: environment
    }
}
