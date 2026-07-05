############################################################
# Project     : WarehousePro Logistics
# Sprint      : 02
# Script      : Connectivity Validation
# Version     : 1.0
# Author      : Nhlanhla M
# Description : Validates Enterprise Network Deployment
############################################################

############################################################
# PREREQUISITES
############################################################

# Az PowerShell Module Installed

# Azure Logged In

# Contributor Role

# Correct Subscription Selected

############################################################
# VARIABLES
############################################################

$Environment = "Prod"

############################################################
# VALIDATION CONFIGURATION
############################################################

$Sites = @(
    "JHB",
    "DBN",
    "CPT"
)

############################################################
# VALIDATION
############################################################

Write-Host ""

Write-Host "Checking Azure Login..."

try
{
    Get-AzContext -ErrorAction Stop | Out-Null
}
catch
{
    Write-Host ""

    Write-Host "ERROR: Not logged into Azure." -ForegroundColor Red

    return
}

Write-Host ""

Write-Host "Azure login successful." -ForegroundColor Green

Write-Host ""

Write-Host "Current Subscription"

(Get-AzContext).Subscription.Name

############################################################
# FUNCTIONS
############################################################

function Test-WarehouseDeployment
{
    param
    (
        [string]$Site
    )

    $ResourceGroup = "RG-WH-$Site-$Environment"

    $VNetName = "VNET-WH-$Site-$Environment"

    $SubnetName = "WarehouseSubnet"

    $NSGName = "NSG-WH-$Site-$Environment"

    $RouteTableName = "RT-WH-$Site-$Environment"

    Write-Host ""

    Write-Host "=========================================="

    Write-Host " Validating $Site"

    Write-Host "=========================================="

    Write-Host "Resource Group : $ResourceGroup"

    Write-Host "Virtual Network: $VNetName"

    Write-Host "Subnet         : $SubnetName"

    Write-Host "NSG            : $NSGName"

    Write-Host "Route Table    : $RouteTableName"

    Write-Host ""

########################################################
# Validate Resource Group
########################################################

Write-Host "[INFO] Validating Resource Group..."

$RGObject = Get-AzResourceGroup `
    -Name $ResourceGroup `
    -ErrorAction SilentlyContinue

if ($null -eq $RGObject)
{
    Write-Host "[FAILED] Resource Group not found." -ForegroundColor Red

    $Failed++

    return
}

Write-Host "[PASS] Resource Group found." -ForegroundColor Green

Write-Host ""

########################################################
# Validate Virtual Network
########################################################

Write-Host "[INFO] Validating Virtual Network..."

$VNetObject = Get-AzVirtualNetwork `
    -ResourceGroupName $ResourceGroup `
    -Name $VNetName `
    -ErrorAction SilentlyContinue

if ($null -eq $VNetObject)
{
    Write-Host "[FAILED] Virtual Network not found." -ForegroundColor Red

    $Failed++

    return
}

Write-Host "[PASS] Virtual Network found." -ForegroundColor Green

Write-Host ""

########################################################
# Validate Warehouse Subnet
########################################################

Write-Host "[INFO] Validating Warehouse Subnet..."

$SubnetObject = Get-AzVirtualNetworkSubnetConfig `
    -VirtualNetwork $VNetObject `
    -Name $SubnetName `
    -ErrorAction SilentlyContinue

if ($null -eq $SubnetObject)
{
    Write-Host "[FAILED] Warehouse Subnet not found." -ForegroundColor Red

    $Failed++

    return
}

Write-Host "[PASS] Warehouse Subnet found." -ForegroundColor Green

Write-Host ""

########################################################
# Validate Network Security Group
########################################################

Write-Host "[INFO] Validating Network Security Group..."

$NSGObject = Get-AzNetworkSecurityGroup `
    -ResourceGroupName $ResourceGroup `
    -Name $NSGName `
    -ErrorAction SilentlyContinue

if ($null -eq $NSGObject)
{
    Write-Host "[FAILED] Network Security Group not found." -ForegroundColor Red

    $Failed++

    return
}

Write-Host "[PASS] Network Security Group found." -ForegroundColor Green

Write-Host ""

########################################################
# Validate Route Table
########################################################

Write-Host "[INFO] Validating Route Table..."

$RouteTableObject = Get-AzRouteTable `
    -ResourceGroupName $ResourceGroup `
    -Name $RouteTableName `
    -ErrorAction SilentlyContinue

if ($null -eq $RouteTableObject)
{
    Write-Host "[FAILED] Route Table not found." -ForegroundColor Red

    $Failed++

    return
}

Write-Host "[PASS] Route Table found." -ForegroundColor Green

Write-Host ""

########################################################
# Validate Route Table Association
########################################################

Write-Host "[INFO] Validating Route Table Association..."

if ($SubnetObject.RouteTable.Id -eq $RouteTableObject.Id)
{
    Write-Host "[PASS] Route Table association verified." -ForegroundColor Green
}
else
{
    Write-Host "[FAILED] Route Table association incorrect." -ForegroundColor Red

    $Failed++

    return
}

Write-Host ""

########################################################
# Validate Hub Peering
########################################################

Write-Host "[INFO] Validating Hub Peering..."

$Peering = Get-AzVirtualNetworkPeering `
    -ResourceGroupName $ResourceGroup `
    -VirtualNetworkName $VNetName `
    -Name "$Site-To-Hub" `
    -ErrorAction SilentlyContinue

if ($null -eq $Peering)
{
    Write-Host "[FAILED] Hub peering not found." -ForegroundColor Red

    $Failed++

    return
}

if ($Peering.PeeringState -eq "Connected")
{
    Write-Host "[PASS] Hub peering connected." -ForegroundColor Green

    $Successful++
}
else
{
    Write-Host "[FAILED] Hub peering not connected." -ForegroundColor Red

    $Failed++

    return
}

Write-Host ""

}

############################################################
# DEPLOYMENT
############################################################

Write-Host ""

Write-Host "=========================================="

Write-Host " Enterprise Connectivity Validation"

Write-Host "=========================================="

Write-Host ""

$Successful = 0

$Failed = 0

foreach ($Site in $Sites)
{
    Test-WarehouseDeployment -Site $Site
}

############################################################
# SUMMARY
############################################################

Write-Host ""

Write-Host "=========================================="
Write-Host " Validation Summary"
Write-Host "=========================================="

Write-Host "Successful : $Successful"
Write-Host "Failed     : $Failed"

Write-Host ""