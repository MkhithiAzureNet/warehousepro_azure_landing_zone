############################################################
# Project     : WarehousePro Logistics
# Sprint      : 02
# Script      : Enterprise Spoke Subnets
# Version     : 1.0
# Author      : Nhlanhla M
# Description : Deploys Warehouse Subnets to Spoke VNets
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
# SPOKE SUBNET CONFIGURATION
############################################################

$SpokeSubnets = @(
    "JHB:10.1.0.0/24",
    "DBN:10.2.0.0/24",
    "CPT:10.3.0.0/24"
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

function Create-SpokeSubnet
{
   param
(
    [string]$Site,

    [string]$AddressPrefix
)

    $ResourceGroup = "RG-WH-$Site-$Environment"

    $VNetName = "VNET-WH-$Site-$Environment"

    $SubnetName = "WarehouseSubnet"

    Write-Host ""

    Write-Host "=========================================="

    Write-Host " Deploying Subnet for $Site"

    Write-Host "=========================================="

    Write-Host "Resource Group : $ResourceGroup"

    Write-Host "Virtual Network: $VNetName"

    Write-Host "Subnet         : $SubnetName"

    Write-Host "Address Prefix : $AddressPrefix"

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

Write-Host "[INFO] Checking existing subnet..."

$ExistingSubnet = Get-AzVirtualNetworkSubnetConfig `
    -VirtualNetwork $VNetObject `
    -Name $SubnetName `
    -ErrorAction SilentlyContinue

if ($null -ne $ExistingSubnet)
{
    Write-Host "[INFO] Subnet already exists." -ForegroundColor Yellow

    $Skipped++

    return
}

Write-Host ""

Write-Host "[INFO] Creating subnet..."

try
{
    Add-AzVirtualNetworkSubnetConfig `
    -Name $SubnetName `
    -VirtualNetwork $VNetObject `
    -AddressPrefix $AddressPrefix | Out-Null

    $VNetObject | Set-AzVirtualNetwork -ErrorAction Stop | Out-Null

    Write-Host "[SUCCESS] $SubnetName created." -ForegroundColor Green
}
catch
{
    Write-Host "[ERROR] Failed creating subnet." -ForegroundColor Red

    Write-Host $_.Exception.Message

    $Failed++

    return
}

Write-Host ""

Write-Host "[INFO] Verifying deployment..."

Get-AzVirtualNetworkSubnetConfig `
    -VirtualNetwork $VNetObject `
    -Name $SubnetName |
Select-Object Name, AddressPrefix |
Format-Table

$Successful++
}

############################################################
# DEPLOYMENT
############################################################

Write-Host ""

Write-Host "=========================================="

Write-Host " Deploying Warehouse Subnets"

Write-Host "=========================================="

Write-Host ""

$Successful = 0

$Failed = 0

$Skipped = 0

foreach ($Spoke in $SpokeSubnets)
{
    $Site = ($Spoke -split ":")[0]

    $AddressPrefix = ($Spoke -split ":")[1]

    Create-SpokeSubnet `
        -Site $Site `
        -AddressPrefix $AddressPrefix
}

############################################################
# SUMMARY
############################################################

Write-Host ""

Write-Host "=========================================="
Write-Host " Deployment Summary"
Write-Host "=========================================="

Write-Host "Successful : $Successful"
Write-Host "Skipped    : $Skipped"
Write-Host "Failed     : $Failed"

Write-Host ""