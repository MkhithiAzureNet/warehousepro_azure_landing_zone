////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 04
// Module      : Private Endpoint
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Deploys a Private Endpoint for Azure PaaS services
////////////////////////////////////////////////////////////

targetScope = 'resourceGroup'

////////////////////////////////////////////////////////////
// PARAMETERS
////////////////////////////////////////////////////////////

@description('Deployment location')
param location string

@description('Private Endpoint name')
param privateEndpointName string

@description('Subnet resource ID for the Private Endpoint')
param subnetId string

@description('Resource ID of the Azure service accessed privately')
param targetResourceId string

@description('Private Link group ID exposed by the target service')
param groupId string

////////////////////////////////////////////////////////////
// RESOURCES
////////////////////////////////////////////////////////////

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2024-05-01' = {
  name: privateEndpointName
  location: location

  properties: {
    subnet: {
      id: subnetId
    }

    privateLinkServiceConnections: [
      {
        name: '${privateEndpointName}-connection'

        properties: {
          privateLinkServiceId: targetResourceId
          groupIds: [
            groupId
          ]
        }
      }
    ]
  }
}

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Private Endpoint Resource ID')
output privateEndpointId string = privateEndpoint.id

@description('Private Endpoint Name')
output privateEndpointName string = privateEndpoint.name
