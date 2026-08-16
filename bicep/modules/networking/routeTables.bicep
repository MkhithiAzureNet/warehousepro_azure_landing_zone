////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 04
// Module      : Route Table
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Deploys a Regional Route Table with Azure Firewall routing
////////////////////////////////////////////////////////////

targetScope = 'resourceGroup'

////////////////////////////////////////////////////////////
// MODULE INFORMATION
////////////////////////////////////////////////////////////

// Scope      : Resource Group
// Depends On : resourceGroups.bicep
// Deploys    : Route Table
// Returns    : Route Table ID

////////////////////////////////////////////////////////////
// PARAMETERS
////////////////////////////////////////////////////////////

@description('Deployment location')
param location string

@description('Environment name')
param environment string

@description('Regional warehouse site')
param site string

@description('Azure Firewall private IP address')
param firewallPrivateIp string

////////////////////////////////////////////////////////////
// VARIABLES
////////////////////////////////////////////////////////////

var routeTableName = 'RT-WH-${site}-${environment}'

////////////////////////////////////////////////////////////
// RESOURCES
////////////////////////////////////////////////////////////

resource routeTable 'Microsoft.Network/routeTables@2024-05-01' = {
  name: routeTableName

  location: location
}

////////////////////////////////////////////////////////////
// AZURE FIREWALL DEFAULT ROUTE
////////////////////////////////////////////////////////////

resource defaultRoute 'Microsoft.Network/routeTables/routes@2024-05-01' = {
  parent: routeTable

  name: 'DefaultRouteToAzureFirewall'

  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: firewallPrivateIp
  }
}

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Route Table Resource ID')
output routeTableId string = routeTable.id

@description('Route Table Name')
output routeTableName string = routeTable.name
