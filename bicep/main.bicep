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

// Creates the Johannesburg Spoke Virtual Network.

module spokeVirtualNetworkJHB './modules/networking/spokeVirtualNetworks.bicep' = {
  name: 'spokeVirtualNetworkJHBDeployment'

  scope: resourceGroup('RG-WH-JHB-${environment}')

  params: {
    location: location
    environment: environment
    site: 'JHB'
    addressSpace: '10.1.0.0/16'
  }
}

// Creates the Durban Spoke Virtual Network.

module spokeVirtualNetworkDBN './modules/networking/spokeVirtualNetworks.bicep' = {
  name: 'spokeVirtualNetworkDBNDeployment'

  scope: resourceGroup('RG-WH-DBN-${environment}')

  params: {
    location: location
    environment: environment
    site: 'DBN'
    addressSpace: '10.2.0.0/16'
  }
}

// Creates the Cape Town Spoke Virtual Network.

module spokeVirtualNetworkCPT './modules/networking/spokeVirtualNetworks.bicep' = {
  name: 'spokeVirtualNetworkCPTDeployment'

  scope: resourceGroup('RG-WH-CPT-${environment}')

  params: {
    location: location
    environment: environment
    site: 'CPT'
    addressSpace: '10.3.0.0/16'
  }
}

// Creates the Johannesburg Workload Subnet.

module workloadSubnetJHB './modules/networking/workloadSubnets.bicep' = {
  name: 'workloadSubnetJHBDeployment'

  scope: resourceGroup('RG-WH-JHB-${environment}')

  params: {
    location: location
    environment: environment
    site: 'JHB'
    subnetPrefix: '10.1.1.0/24'
  }
}

// Creates the Durban Workload Subnet.

module workloadSubnetDBN './modules/networking/workloadSubnets.bicep' = {
  name: 'workloadSubnetDBNDeployment'

  scope: resourceGroup('RG-WH-DBN-${environment}')

  params: {
    location: location
    environment: environment
    site: 'DBN'
    subnetPrefix: '10.2.1.0/24'
  }
}

// Creates the Cape Town Workload Subnet.

module workloadSubnetCPT './modules/networking/workloadSubnets.bicep' = {
  name: 'workloadSubnetCPTDeployment'

  scope: resourceGroup('RG-WH-CPT-${environment}')

  params: {
    location: location
    environment: environment
    site: 'CPT'
    subnetPrefix: '10.3.1.0/24'
  }
}
