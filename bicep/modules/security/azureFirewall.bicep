////////////////////////////////////////////////////////////
// Project     : WarehousePro Logistics
// Sprint      : 04
// Module      : Azure Firewall
// Version     : 1.0
// Author      : Nhlanhla M
// Description : Deploys Azure Firewall and supporting
//               security resources for the Hub network
////////////////////////////////////////////////////////////

targetScope = 'resourceGroup'

////////////////////////////////////////////////////////////
// MODULE INFORMATION
////////////////////////////////////////////////////////////

// Scope      : RG-Networking
// Depends On : Hub Virtual Network and AzureFirewallSubnet
// Deploys    : Public IP
//              Firewall Policy
//              Azure Firewall
// Returns    : Firewall Resource ID
//              Firewall Private IP
//              Firewall Public IP

////////////////////////////////////////////////////////////
// PARAMETERS
////////////////////////////////////////////////////////////

@description('Environment name')
param environment string

@description('Hub Virtual Network name')
param hubVnetName string

@description('Azure Firewall subnet name')
param firewallSubnetName string = 'AzureFirewallSubnet'

////////////////////////////////////////////////////////////
// VARIABLES
////////////////////////////////////////////////////////////

var firewallName = 'AFW-WarehousePro-${environment}'
var firewallPolicyName = 'AFWP-WarehousePro-${environment}'
var firewallPublicIpName = 'PIP-AzureFirewall-${environment}'

////////////////////////////////////////////////////////////
// EXISTING HUB VNET
////////////////////////////////////////////////////////////

resource hubVnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: hubVnetName
}

resource firewallSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' existing = {
  parent: hubVnet
  name: firewallSubnetName
}

////////////////////////////////////////////////////////////
// FIREWALL PUBLIC IP
////////////////////////////////////////////////////////////

resource firewallPublicIp 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: firewallPublicIpName

  location: resourceGroup().location

  sku: {
    name: 'Standard'
  }

  properties: {
    publicIPAllocationMethod: 'Static'
  }

  tags: {
    Environment: environment
    Project: 'WarehousePro'
    Owner: 'Cloud Team'
    Department: 'IT'
    CostCenter: 'Infrastructure'
    ManagedBy: 'AzureBicep'
    BusinessUnit: 'Logistics'
    Criticality: 'High'
    Backup: 'Yes'
  }
}

////////////////////////////////////////////////////////////
// FIREWALL POLICY
////////////////////////////////////////////////////////////

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2024-05-01' = {
  name: firewallPolicyName

  location: resourceGroup().location

  properties: {
    sku: {
      tier: 'Standard'
    }
  }

  tags: {
    Environment: environment
    Project: 'WarehousePro'
    Owner: 'Cloud Team'
    Department: 'IT'
    CostCenter: 'Infrastructure'
    ManagedBy: 'AzureBicep'
    BusinessUnit: 'Logistics'
    Criticality: 'High'
    Backup: 'Yes'
  }
}

////////////////////////////////////////////////////////////
// AZURE FIREWALL
////////////////////////////////////////////////////////////

resource azureFirewall 'Microsoft.Network/azureFirewalls@2024-05-01' = {
  name: firewallName

  location: resourceGroup().location

  properties: {
    sku: {
      name: 'AZFW_VNet'
      tier: 'Standard'
    }

    firewallPolicy: {
      id: firewallPolicy.id
    }

    ipConfigurations: [
      {
        name: 'AzureFirewallIpConfiguration'

        properties: {
          subnet: {
            id: firewallSubnet.id
          }

          publicIPAddress: {
            id: firewallPublicIp.id
          }
        }
      }
    ]
  }

  tags: {
    Environment: environment
    Project: 'WarehousePro'
    Owner: 'Cloud Team'
    Department: 'IT'
    CostCenter: 'Infrastructure'
    ManagedBy: 'AzureBicep'
    BusinessUnit: 'Logistics'
    Criticality: 'High'
    Backup: 'Yes'
  }
  
}

////////////////////////////////////////////////////////////
// OUTPUTS
////////////////////////////////////////////////////////////

@description('Azure Firewall Resource ID')
output firewallId string = azureFirewall.id

@description('Azure Firewall Private IP Address')
output firewallPrivateIp string = azureFirewall.properties.ipConfigurations[0].properties.privateIPAddress

@description('Azure Firewall Public IP Resource ID')
output firewallPublicIpId string = firewallPublicIp.id

@description('Azure Firewall Public IP Address')
output firewallPublicIpAddress string = firewallPublicIp.properties.ipAddress

@description('Azure Firewall Policy Resource ID')
output firewallPolicyId string = firewallPolicy.id
