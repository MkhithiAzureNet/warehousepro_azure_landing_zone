////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 03
// Module      : Hub Subnets
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Deploys Enterprise Hub Subnets
////////////////////////////////////////////////////////////

targetScope = 'resourceGroup'

////////////////////////////////////////////////////////////
// MODULE INFORMATION
////////////////////////////////////////////////////////////

// Scope      : Resource Group
// Depends On : hubVirtualNetwork.bicep
// Deploys    : Hub Subnets
// Returns    : Hub Virtual Network

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

var hubVirtualNetworkName = 'VNET-Hub-${environment}'

var hubSubnetNames = [
  {
    name: 'AzureFirewallSubnet'
    prefix: '10.0.0.0/24'
  }
  {
    name: 'AzureBastionSubnet'
    prefix: '10.0.1.0/26'
  }
  {
    name: 'GatewaySubnet'
    prefix: '10.0.2.0/27'
  }
  {
    name: 'SharedServicesSubnet'
    prefix: '10.0.10.0/24'
  }
  {
    name: 'ManagementSubnet'
    prefix: '10.0.20.0/24'
  }
]

////////////////////////////////////////////////////////////
// EXISTING RESOURCES
////////////////////////////////////////////////////////////

resource hubVirtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: hubVirtualNetworkName
}

////////////////////////////////////////////////////////////
// RESOURCES
////////////////////////////////////////////////////////////

resource hubSubnets 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = [
  for subnet in hubSubnetNames: {
    parent: hubVirtualNetwork
    name: subnet.name

    properties: {
      addressPrefix: subnet.prefix
    }
  }
]

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Hub Subnet Names')
output hubSubnetNames array = [
  for subnet in hubSubnetNames: subnet.name
]
