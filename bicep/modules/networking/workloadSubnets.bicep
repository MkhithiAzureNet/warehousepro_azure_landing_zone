////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 03
// Module      : Workload Subnets
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Deploys Workload Subnets to Regional Spoke Networks
////////////////////////////////////////////////////////////

targetScope = 'resourceGroup'

////////////////////////////////////////////////////////////
// MODULE INFORMATION
////////////////////////////////////////////////////////////

// Scope      : Resource Group
// Depends On : spokeVirtualNetworks.bicep
// Deploys    : Workload Subnet
// Returns    : Workload Subnet Name

////////////////////////////////////////////////////////////
// PARAMETERS
////////////////////////////////////////////////////////////

@description('Deployment location')
param location string

@description('Environment name')
param environment string

@description('Regional warehouse site')
param site string

@description('Subnet address prefix')
param subnetPrefix string

////////////////////////////////////////////////////////////
// VARIABLES
////////////////////////////////////////////////////////////

var spokeVirtualNetworkName = 'VNET-WH-${site}-${environment}'

var workloadSubnetName = 'WorkloadSubnet'

////////////////////////////////////////////////////////////
// EXISTING RESOURCES
////////////////////////////////////////////////////////////

resource spokeVirtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: spokeVirtualNetworkName
}

////////////////////////////////////////////////////////////
// RESOURCES
////////////////////////////////////////////////////////////

resource workloadSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: spokeVirtualNetwork

  name: workloadSubnetName

  properties: {
    addressPrefix: subnetPrefix
  }
}

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Workload Subnet Resource ID')
output workloadSubnetId string = workloadSubnet.id

@description('Workload Subnet Name')
output workloadSubnetName string = workloadSubnet.name
