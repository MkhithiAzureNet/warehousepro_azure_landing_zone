////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 04
// Module      : Azure Bastion
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Deploys Azure Bastion for secure administrative access
////////////////////////////////////////////////////////////

targetScope = 'resourceGroup'

////////////////////////////////////////////////////////////
// PARAMETERS
////////////////////////////////////////////////////////////

@description('Deployment location')
param location string

@description('Environment name')
param environment string

@description('Azure Bastion subnet resource ID')
param bastionSubnetId string

////////////////////////////////////////////////////////////
// VARIABLES
////////////////////////////////////////////////////////////

var bastionName = 'Bastion-WarehousePro-${environment}'
var publicIpName = 'PIP-Bastion-WarehousePro-${environment}'

////////////////////////////////////////////////////////////
// RESOURCES
////////////////////////////////////////////////////////////

// Bastion Public IP
resource bastionPublicIp 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: publicIpName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

// Azure Bastion
resource bastion 'Microsoft.Network/bastionHosts@2024-05-01' = {
  name: bastionName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'bastionIpConfiguration'
        properties: {
          subnet: {
            id: bastionSubnetId
          }
          publicIPAddress: {
            id: bastionPublicIp.id
          }
        }
      }
    ]
  }
}

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Azure Bastion Resource ID')
output bastionId string = bastion.id

@description('Azure Bastion Name')
output bastionName string = bastion.name

@description('Bastion Public IP Resource ID')
output bastionPublicIpId string = bastionPublicIp.id
