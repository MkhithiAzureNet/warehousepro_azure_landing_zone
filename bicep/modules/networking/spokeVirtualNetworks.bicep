////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 03
// Module      : Spoke Virtual Networks
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Deploys Regional Spoke Virtual Networks
////////////////////////////////////////////////////////////

targetScope = 'resourceGroup'

////////////////////////////////////////////////////////////
// MODULE INFORMATION
////////////////////////////////////////////////////////////

// Scope      : Resource Group
// Depends On : resourceGroups.bicep
// Deploys    : Regional Spoke Virtual Networks
// Returns    : Spoke Virtual Network Names

////////////////////////////////////////////////////////////
// PARAMETERS
////////////////////////////////////////////////////////////

@description('Deployment location')
param location string

@description('Environment name')
param environment string

@description('Regional warehouse site')
param site string

@description('Virtual Network address space')
param addressSpace string

/////////////////////////////////////////////////////////////
// VARIABLES
////////////////////////////////////////////////////////////

var spokeVirtualNetworkName = 'VNET-WH-${site}-${environment}'

var resourceGroupName = 'RG-WH-${site}-${environment}'

////////////////////////////////////////////////////////////
// RESOURCES
////////////////////////////////////////////////////////////

resource spokeVirtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: spokeVirtualNetworkName
  location: location

  properties: {
    addressSpace: {
      addressPrefixes: [
        addressSpace
      ]
    }
  }
}

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Virtual Network Resource ID')
output virtualNetworkId string = spokeVirtualNetwork.id

@description('Virtual Network Name')
output virtualNetworkName string = spokeVirtualNetwork.name
