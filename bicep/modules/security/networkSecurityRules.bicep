////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 04
// Module      : Network Security Rules
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Deploys Network Security Rules for Warehouse Network Security Groups
////////////////////////////////////////////////////////////

targetScope = 'resourceGroup'

////////////////////////////////////////////////////////////
// MODULE INFORMATION
////////////////////////////////////////////////////////////

// Scope      : Resource Group
// Depends On : Network Security Groups
// Deploys    : Network Security Rules
// Returns    : Security Rule Names

////////////////////////////////////////////////////////////
// PARAMETERS
////////////////////////////////////////////////////////////

@description('Environment name')
param environment string

@description('Regional warehouse site')
param site string

@description('Network Security Rules')
param securityRules array

////////////////////////////////////////////////////////////
// VARIABLES
////////////////////////////////////////////////////////////

var networkSecurityGroupName = 'NSG-WH-${site}-${environment}'

////////////////////////////////////////////////////////////
// EXISTING RESOURCES
////////////////////////////////////////////////////////////

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-05-01' existing = {
  name: networkSecurityGroupName
}

resource securityRule 'Microsoft.Network/networkSecurityGroups/securityRules@2024-05-01' = [for rule in securityRules: {
  parent: networkSecurityGroup

  name: rule.name

  properties: {
    priority: rule.priority

    direction: rule.direction

    access: rule.access

    protocol: rule.protocol

    sourcePortRange: rule.sourcePortRange

    destinationPortRange: rule.destinationPortRange

    sourceAddressPrefix: rule.sourceAddressPrefix

    destinationAddressPrefix: rule.destinationAddressPrefix
  }
}]

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Network Security Group Resource ID')
output networkSecurityGroupId string = networkSecurityGroup.id

@description('Network Security Rule Names')
output deployedSecurityRules array = [
  for rule in securityRules: rule.name
]
