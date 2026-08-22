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
// RESOURCE GROUPS
////////////////////////////////////////////////////////////

resource rgNetworking 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'RG-Networking-${environment}'
  location: location
  tags: resourceTags
}

resource rgIdentity 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'RG-Identity-${environment}'
  location: location
  tags: resourceTags
}

resource rgManagement 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'RG-Management-${environment}'
  location: location
  tags: resourceTags
}

resource rgMonitoring 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'RG-Monitoring-${environment}'
  location: location
  tags: resourceTags
}

resource rgSharedServices 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'RG-SharedServices-${environment}'
  location: location
  tags: resourceTags
}

resource rgWHJHB 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'RG-WH-JHB-${environment}'
  location: location
  tags: resourceTags
}

resource rgWHDBN 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'RG-WH-DBN-${environment}'
  location: location
  tags: resourceTags
}

resource rgWHCPT 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'RG-WH-CPT-${environment}'
  location: location
  tags: resourceTags
}

////////////////////////////////////////////////////////////
// VARIABLES
////////////////////////////////////////////////////////////

var resourceTags = {
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

// Security rule definitions for workload subnet Network Security Groups.

////////////////////////////////////////////////////////////
// SECURITY CONFIGURATION
////////////////////////////////////////////////////////////
var workloadSubnetSecurityRules = [

  {
    name: 'Allow-AzureLoadBalancer'

    priority: 110

    direction: 'Inbound'

    access: 'Allow'

    protocol: '*'

    sourcePortRange: '*'

    destinationPortRange: '*'

    sourceAddressPrefix: 'AzureLoadBalancer'

    destinationAddressPrefix: '*'
  }

  {
    name: 'Deny-Internet'

    priority: 4096

    direction: 'Inbound'

    access: 'Deny'

    protocol: '*'

    sourcePortRange: '*'

    destinationPortRange: '*'

    sourceAddressPrefix: 'Internet'

    destinationAddressPrefix: '*'
  }
]

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

  scope: rgNetworking

  params: {
    location: location
    environment: environment
  }
}

// Creates the Hub subnets.

module hubSubnets './modules/networking/hubSubnets.bicep' = {
  name: 'hubSubnetsDeployment'

  scope: rgNetworking

  dependsOn: [
    hubVirtualNetwork
  ]

  params: {
    environment: environment
  }
}

// Creates Azure Bastion for secure administrative access.

module azureBastion './modules/security/azureBastion.bicep' = {
  name: 'azureBastionDeployment'

  scope: rgNetworking

  params: {
    location: location
    environment: environment
    bastionSubnetId: hubSubnets.outputs.azureBastionSubnetId
  }
}

// Creates the Johannesburg Spoke Virtual Network.

module spokeVirtualNetworkJHB './modules/networking/spokeVirtualNetworks.bicep' = {
  name: 'spokeVirtualNetworkJHBDeployment'

  scope: rgWHJHB

  dependsOn: [
  rgNetworking
]

  params: {
    environment: environment
    site: 'JHB'
    addressSpace: '10.1.0.0/16'
    location: location
  }
}

// Creates the Durban Spoke Virtual Network.

module spokeVirtualNetworkDBN './modules/networking/spokeVirtualNetworks.bicep' = {
  name: 'spokeVirtualNetworkDBNDeployment'

  scope: rgWHDBN

  dependsOn: [
  rgNetworking
]

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

  scope: rgWHCPT

  dependsOn: [
  rgNetworking
]

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

  scope: rgWHJHB

   dependsOn: [
    spokeVirtualNetworkJHB
  ]

  params: {
    environment: environment
    site: 'JHB'
    subnetPrefix: '10.1.1.0/24'
    routeTableId: routeTableJHB.outputs.routeTableId
  }
}

// Creates the Durban Workload Subnet.

module workloadSubnetDBN './modules/networking/workloadSubnets.bicep' = {
  name: 'workloadSubnetDBNDeployment'

  scope: rgWHDBN

  dependsOn: [
    spokeVirtualNetworkDBN
]

  params: {
    environment: environment
    site: 'DBN'
    subnetPrefix: '10.2.1.0/24'
    routeTableId: routeTableDBN.outputs.routeTableId
  }
}

// Creates the Cape Town Workload Subnet.

module workloadSubnetCPT './modules/networking/workloadSubnets.bicep' = {
  name: 'workloadSubnetCPTDeployment'

  scope: rgWHCPT

  dependsOn: [
    spokeVirtualNetworkCPT
]

  params: {
    environment: environment
    site: 'CPT'
    subnetPrefix: '10.3.1.0/24'
    routeTableId: routeTableCPT.outputs.routeTableId
  }
}

// Creates the Johannesburg Route Table.

module routeTableJHB './modules/networking/routeTables.bicep' = {
  name: 'routeTableJHBDeployment'

  scope: rgWHJHB

  params: {
    location: location
    environment: environment
    site: 'JHB'
    firewallPrivateIp: azureFirewall.outputs.firewallPrivateIp
  }
}

// Creates the Durban Route Table.

module routeTableDBN './modules/networking/routeTables.bicep' = {
  name: 'routeTableDBNDeployment'

  scope: rgWHDBN

  params: {
    location: location
    environment: environment
    site: 'DBN'
    firewallPrivateIp: azureFirewall.outputs.firewallPrivateIp
  }
}

// Creates the Cape Town Route Table.

module routeTableCPT './modules/networking/routeTables.bicep' = {
  name: 'routeTableCPTDeployment'

  scope: rgWHCPT

  params: {
    location: location
    environment: environment
    site: 'CPT'
    firewallPrivateIp: azureFirewall.outputs.firewallPrivateIp
  }
}

// Creates Hub to Johannesburg Virtual Network Peering.

module hubToJHBPeering './modules/networking/vnetPeerings.bicep' = {
  name: 'hubToJHBPeeringDeployment'

  scope: rgNetworking

  params: {
    localVirtualNetworkName: 'VNET-Hub-${environment}'
    remoteVirtualNetworkId: spokeVirtualNetworkJHB.outputs.virtualNetworkId
    peeringName: 'Hub-To-JHB'
  }
}

// Creates Johannesburg to Hub Virtual Network Peering.

module jhbToHubPeering './modules/networking/vnetPeerings.bicep' = {
  name: 'jhbToHubPeeringDeployment'

  scope: rgWHJHB

  params: {
    localVirtualNetworkName: 'VNET-WH-JHB-${environment}'
    remoteVirtualNetworkId: hubVirtualNetwork.outputs.virtualNetworkId
    peeringName: 'JHB-To-Hub'
  }
}

// Creates Hub to Durban Virtual Network Peering.

module hubToDBNPeering './modules/networking/vnetPeerings.bicep' = {
  name: 'hubToDBNPeeringDeployment'

  scope: rgNetworking

  params: {
    localVirtualNetworkName: 'VNET-Hub-${environment}'
    remoteVirtualNetworkId: spokeVirtualNetworkDBN.outputs.virtualNetworkId
    peeringName: 'Hub-To-DBN'
  }
}

// Creates Durban to Hub Virtual Network Peering.

module dbnToHubPeering './modules/networking/vnetPeerings.bicep' = {
  name: 'dbnToHubPeeringDeployment'

  scope: rgWHDBN

  dependsOn: [
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

  scope: rgNetworking

  params: {
    localVirtualNetworkName: 'VNET-Hub-${environment}'
    remoteVirtualNetworkId: spokeVirtualNetworkCPT.outputs.virtualNetworkId
    peeringName: 'Hub-To-CPT'
  }
}

// Creates Cape Town to Hub Virtual Network Peering.

module cptToHubPeering './modules/networking/vnetPeerings.bicep' = {
  name: 'cptToHubPeeringDeployment'

  scope: rgWHCPT

  dependsOn: [
    spokeVirtualNetworkCPT
  ]

  params: {
    localVirtualNetworkName: 'VNET-WH-CPT-${environment}'
    remoteVirtualNetworkId: hubVirtualNetwork.outputs.virtualNetworkId
    peeringName: 'CPT-To-Hub'
  }
}

// Creates the Johannesburg Network Security Group.

module networkSecurityGroupJHB './modules/security/networkSecurityGroups.bicep' = {
  name: 'networkSecurityGroupJHBDeployment'

  scope: rgWHJHB

  params: {
    location: location
    environment: environment
    site: 'JHB'
  }
}

// Creates the Durban Network Security Group.

module networkSecurityGroupDBN './modules/security/networkSecurityGroups.bicep' = {
  name: 'networkSecurityGroupDBNDeployment'

  scope: rgWHDBN

  params: {
    location: location
    environment: environment
    site: 'DBN'
  }
}

// Creates the Cape Town Network Security Group.

module networkSecurityGroupCPT './modules/security/networkSecurityGroups.bicep' = {
  name: 'networkSecurityGroupCPTDeployment'

  scope: rgWHCPT

  params: {
    location: location
    environment: environment
    site: 'CPT'
  }
}

////////////////////////////////////////////////////////////
// STAGE 3 - NETWORK SECURITY
////////////////////////////////////////////////////////////

// Creates Azure Firewall in the central Hub.

module azureFirewall './modules/security/azureFirewall.bicep' = {
  name: 'azureFirewallDeployment'

  scope: rgNetworking

  dependsOn: [
    hubSubnets
  ]

  params: {
    environment: environment
    hubVnetName: 'VNET-Hub-${environment}'
  }
}

// Creates Johannesburg Network Security Rules.

module networkSecurityRulesJHB './modules/security/networkSecurityRules.bicep' = {
  name: 'networkSecurityRulesJHBDeployment'

  scope: rgWHJHB

  dependsOn: [
  networkSecurityGroupJHB
]

  params: {
    environment: environment

    site: 'JHB'

    securityRules: workloadSubnetSecurityRules
  }
}

// Creates Durban Network Security Rules.

module networkSecurityRulesDBN './modules/security/networkSecurityRules.bicep' = {
  name: 'networkSecurityRulesDBNDeployment'

  scope: rgWHDBN

  dependsOn: [
    networkSecurityGroupDBN
  ]

  params: {
    environment: environment

    site: 'DBN'

    securityRules: workloadSubnetSecurityRules
  }
}

// Creates Cape Town Network Security Rules.

module networkSecurityRulesCPT './modules/security/networkSecurityRules.bicep' = {
  name: 'networkSecurityRulesCPTDeployment'

  scope: rgWHCPT

  dependsOn: [
    networkSecurityGroupCPT
  ]

  params: {
    environment: environment

    site: 'CPT'

    securityRules: workloadSubnetSecurityRules
  }
}

// Creates Private Endpoint connectivity for Azure PaaS services.

resource hubVnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: 'VNET-Hub-${environment}'
  scope: rgNetworking
}

resource sharedServicesSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' existing = {
  parent: hubVnet
  name: 'SharedServicesSubnet'
}

// Creates a Private Endpoint for Azure PaaS services.

module privateEndpoint './modules/security/privateEndpoint.bicep' = {
  name: 'privateEndpointDeployment'
  scope: rgSharedServices

  params: {
    location: location
    subnetId: sharedServicesSubnet.id
    targetResourceId: keyVault.outputs.keyVaultId
    groupId: 'vault'
    privateEndpointName: 'PE-KeyVault-${environment}'
  }
}

// Creates Azure Key Vault for secure secret management.

module keyVault './modules/security/keyVault.bicep' = {
  name: 'keyVaultDeployment'
  scope: rgSharedServices

  params: {
    location: location
    environment: environment
  }
}


