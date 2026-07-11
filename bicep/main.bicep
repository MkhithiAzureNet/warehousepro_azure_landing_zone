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

   dependsOn: [
    spokeVirtualNetworkJHB
  ]

  params: {
    location: location
    environment: environment
    site: 'JHB'
    subnetPrefix: '10.1.1.0/24'
    routeTableId: routeTableJHB.outputs.routeTableId
  }
}

// Creates the Durban Workload Subnet.

module workloadSubnetDBN './modules/networking/workloadSubnets.bicep' = {
  name: 'workloadSubnetDBNDeployment'

  scope: resourceGroup('RG-WH-DBN-${environment}')

  dependsOn: [
    spokeVirtualNetworkDBN
]

  params: {
    location: location
    environment: environment
    site: 'DBN'
    subnetPrefix: '10.2.1.0/24'
    routeTableId: routeTableDBN.outputs.routeTableId
  }
}

// Creates the Cape Town Workload Subnet.

module workloadSubnetCPT './modules/networking/workloadSubnets.bicep' = {
  name: 'workloadSubnetCPTDeployment'

  scope: resourceGroup('RG-WH-CPT-${environment}')

  dependsOn: [
    spokeVirtualNetworkCPT
]

  params: {
    location: location
    environment: environment
    site: 'CPT'
    subnetPrefix: '10.3.1.0/24'
    routeTableId: routeTableCPT.outputs.routeTableId
  }
}

// Creates the Johannesburg Route Table.

module routeTableJHB './modules/networking/routeTables.bicep' = {
  name: 'routeTableJHBDeployment'

  scope: resourceGroup('RG-WH-JHB-${environment}')

  params: {
    location: location
    environment: environment
    site: 'JHB'
  }
}

// Creates the Durban Route Table.

module routeTableDBN './modules/networking/routeTables.bicep' = {
  name: 'routeTableDBNDeployment'

  scope: resourceGroup('RG-WH-DBN-${environment}')

  params: {
    location: location
    environment: environment
    site: 'DBN'
  }
}

// Creates the Cape Town Route Table.

module routeTableCPT './modules/networking/routeTables.bicep' = {
  name: 'routeTableCPTDeployment'

  scope: resourceGroup('RG-WH-CPT-${environment}')

  params: {
    location: location
    environment: environment
    site: 'CPT'
  }
}

// Creates Hub to Johannesburg Virtual Network Peering.

module hubToJHBPeering './modules/networking/vnetPeerings.bicep' = {
  name: 'hubToJHBPeeringDeployment'

  scope: resourceGroup('RG-Networking-${environment}')

  dependsOn: [
  hubVirtualNetwork
  spokeVirtualNetworkJHB
]

  params: {
    localVirtualNetworkName: 'VNET-Hub-${environment}'
    remoteVirtualNetworkId: spokeVirtualNetworkJHB.outputs.virtualNetworkId
    peeringName: 'Hub-To-JHB'
  }
}

// Creates Johannesburg to Hub Virtual Network Peering.

module jhbToHubPeering './modules/networking/vnetPeerings.bicep' = {
  name: 'jhbToHubPeeringDeployment'

  scope: resourceGroup('RG-WH-JHB-${environment}')

  dependsOn: [
  hubVirtualNetwork
  spokeVirtualNetworkJHB
]

  params: {
    localVirtualNetworkName: 'VNET-WH-JHB-${environment}'
    remoteVirtualNetworkId: hubVirtualNetwork.outputs.virtualNetworkId
    peeringName: 'JHB-To-Hub'
  }
}

// Creates Hub to Durban Virtual Network Peering.

module hubToDBNPeering './modules/networking/vnetPeerings.bicep' = {
  name: 'hubToDBNPeeringDeployment'

  scope: resourceGroup('RG-Networking-${environment}')

  dependsOn: [
  hubVirtualNetwork
  spokeVirtualNetworkDBN
]

  params: {
    localVirtualNetworkName: 'VNET-Hub-${environment}'
    remoteVirtualNetworkId: spokeVirtualNetworkDBN.outputs.virtualNetworkId
    peeringName: 'Hub-To-DBN'
  }
}

// Creates Durban to Hub Virtual Network Peering.

module dbnToHubPeering './modules/networking/vnetPeerings.bicep' = {
  name: 'dbnToHubPeeringDeployment'

  scope: resourceGroup('RG-WH-DBN-${environment}')

  dependsOn: [
  hubVirtualNetwork
  spokeVirtualNetworkDBN
]

  params: {
    localVirtualNetworkName: 'VNET-WH-DBN-${environment}'
    remoteVirtualNetworkId: hubVirtualNetwork.outputs.virtualNetworkId
    peeringName: 'DBN-To-Hub'
  }
}

// Creates Hub to Cape Town Virtual Network Peering.

module hubToCPTPeering './modules/networking/vnetPeerings.bicep' = {
  name: 'hubToCPTPeeringDeployment'

  scope: resourceGroup('RG-Networking-${environment}')

  dependsOn: [
  hubVirtualNetwork
  spokeVirtualNetworkCPT
]

  params: {
    localVirtualNetworkName: 'VNET-Hub-${environment}'
    remoteVirtualNetworkId: spokeVirtualNetworkCPT.outputs.virtualNetworkId
    peeringName: 'Hub-To-CPT'
  }
}

// Creates Cape Town to Hub Virtual Network Peering.

module cptToHubPeering './modules/networking/vnetPeerings.bicep' = {
  name: 'cptToHubPeeringDeployment'

  scope: resourceGroup('RG-WH-CPT-${environment}')

    dependsOn: [
  hubVirtualNetwork
  spokeVirtualNetworkCPT
]

  params: {
    localVirtualNetworkName: 'VNET-WH-CPT-${environment}'
    remoteVirtualNetworkId: hubVirtualNetwork.outputs.virtualNetworkId
    peeringName: 'CPT-To-Hub'
  }
}


