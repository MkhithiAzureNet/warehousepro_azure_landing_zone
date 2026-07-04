############################################################
# Project     : WarehousePro Logistics
# Sprint      : 02
# Script      : Route Table Associations
# Version     : 1.0
# Author      : Nhlanhla M
# Description : Associates Route Tables to Warehouse Subnets
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
# ROUTE TABLE ASSOCIATIONS
############################################################

$Associations = @(
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

function Set-RouteTableAssociation
{
    param
    (
        [string]$Site
    )

    $ResourceGroup = "RG-WH-$Site-$Environment"

    $VNetName = "VNET-WH-$Site-$Environment"

    $RouteTable = "RT-WH-$Site-$Environment"

    Write-Host ""

    Write-Host "=========================================="

    Write-Host " Associating Route Table for $Site"

    Write-Host "=========================================="

    Write-Host "Resource Group : $ResourceGroup"

    Write-Host "Virtual Network: $VNetName"

    Write-Host "Route Table    : $RouteTable"

    Write-Host ""

    Write-Host "[INFO] Validating Resource Group..."

$RGObject = Get-AzResourceGroup `
    -Name $ResourceGroup `
    -ErrorAction SilentlyContinue

if ($null -eq $RGObject)
{
    Write-Host "[ERROR] Resource Group not found." -ForegroundColor Red

    $Failed++

    return
}

Write-Host ""

Write-Host "[INFO] Validating Virtual Network..."

$VNetObject = Get-AzVirtualNetwork `
    -ResourceGroupName $ResourceGroup `
    -Name $VNetName `
    -ErrorAction SilentlyContinue

if ($null -eq $VNetObject)
{
    Write-Host "[ERROR] Virtual Network not found." -ForegroundColor Red

    $Failed++

    return
}

Write-Host ""

Write-Host "[INFO] Validating Route Table..."

$RouteTableObject = Get-AzRouteTable `
    -ResourceGroupName $ResourceGroup `
    -Name $RouteTable `
    -ErrorAction SilentlyContinue

if ($null -eq $RouteTableObject)
{
    Write-Host "[ERROR] Route Table not found." -ForegroundColor Red

    $Failed++

    return
}

Write-Host ""

Write-Host "[INFO] Retrieving Warehouse subnet..."

$SubnetObject = Get-AzVirtualNetworkSubnetConfig `
    -VirtualNetwork $VNetObject `
    -Name "WarehouseSubnet"

if ($null -eq $SubnetObject)
{
    Write-Host "[ERROR] Warehouse subnet not found." -ForegroundColor Red

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

Write-Host " Deploying Route Table Associations"

Write-Host "=========================================="

Write-Host ""

$Successful = 0

$Failed = 0

$Skipped = 0

foreach ($Site in $Associations)
{
    Set-RouteTableAssociation -Site $Site
}