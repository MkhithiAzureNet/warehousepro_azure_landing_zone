////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 03
// Module      : Virtual Network Peering
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Creates a Virtual Network Peering
////////////////////////////////////////////////////////////

targetScope = 'resourceGroup'

////////////////////////////////////////////////////////////
// MODULE INFORMATION
////////////////////////////////////////////////////////////

// Scope      : Resource Group
// Depends On : Local Virtual Network
// Deploys    : Virtual Network Peering
// Returns    : Virtual Network Peering Resource ID

////////////////////////////////////////////////////////////
// PARAMETERS
////////////////////////////////////////////////////////////

@description('Local Virtual Network Name')
param localVirtualNetworkName string

@description('Remote Virtual Network Resource ID')
param remoteVirtualNetworkId string

@description('Peering Name')
param peeringName string

////////////////////////////////////////////////////////////
// EXISTING RESOURCES
////////////////////////////////////////////////////////////

resource localVirtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: localVirtualNetworkName
}

////////////////////////////////////////////////////////////
// RESOURCES
////////////////////////////////////////////////////////////

resource virtualNetworkPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-05-01' = {
  parent: localVirtualNetwork

  name: peeringName

  properties: {
    remoteVirtualNetwork: {
      id: remoteVirtualNetworkId
    }

    allowVirtualNetworkAccess: true

    allowForwardedTraffic: true

    allowGatewayTransit: false

    useRemoteGateways: false
  }
}

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Virtual Network Peering Resource ID')
output peeringId string = virtualNetworkPeering.id
