############################################################
# Project     : WarehousePro Logistics
# Sprint      : 02
# Script      : Hub and Spoke VNet Peering
# Version     : 1.0
# Author      : Nhlanhla M
# Description : Creates Enterprise Hub-and-Spoke VNet Peerings
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

$Location="South Africa North"

$Environment="Prod"

$HubRG="RG-Networking-$Environment"

$HubVNet="VNET-Hub-$Environment"

############################################################
# PEERING CONFIGURATION
############################################################

$Peerings=@(

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

Write-Host ""

Write-Host "Current Subscription"

(Get-AzContext).Subscription.Name

############################################################
# FUNCTIONS
############################################################

function Create-VNetPeering
{
    param
    (
        [string]$Site
    )

    $SpokeRG = "RG-WH-$Site-$Environment"

    $SpokeVNet = "VNET-WH-$Site-$Environment"

    $HubToSpoke = "Hub-To-$Site"

    $SpokeToHub = "$Site-To-Hub"

    Write-Host ""

    Write-Host "=========================================="

    Write-Host " Creating Peering for $Site"

    Write-Host "=========================================="

    Write-Host "Hub VNet     : $HubVNet"

    Write-Host "Spoke VNet   : $SpokeVNet"

    Write-Host ""

    Write-Host "[INFO] Validating Resource Groups..."

$HubRGExists = Get-AzResourceGroup `
    -Name $HubRG `
    -ErrorAction SilentlyContinue

if ($null -eq $HubRGExists)
{
    Write-Host "[ERROR] Hub Resource Group not found." -ForegroundColor Red

    $Failed++

    return
}

$SpokeRGExists = Get-AzResourceGroup `
    -Name $SpokeRG `
    -ErrorAction SilentlyContinue

if ($null -eq $SpokeRGExists)
{
    Write-Host "[ERROR] Spoke Resource Group not found." -ForegroundColor Red

    $Failed++

    return
}

Write-Host ""

Write-Host "[INFO] Validating Virtual Networks..."

$HubVNetObject = Get-AzVirtualNetwork `
    -ResourceGroupName $HubRG `
    -Name $HubVNet `
    -ErrorAction SilentlyContinue

if ($null -eq $HubVNetObject)
{
    Write-Host "[ERROR] Hub Virtual Network not found." -ForegroundColor Red

    $Failed++

    return
}

$SpokeVNetObject = Get-AzVirtualNetwork `
    -ResourceGroupName $SpokeRG `
    -Name $SpokeVNet `
    -ErrorAction SilentlyContinue

if ($null -eq $SpokeVNetObject)
{
    Write-Host "[ERROR] Spoke Virtual Network not found." -ForegroundColor Red

    $Failed++

    return
}

Write-Host ""

Write-Host "[INFO] Checking existing peerings..."

$ExistingHubPeering = Get-AzVirtualNetworkPeering `
    -ResourceGroupName $HubRG `
    -VirtualNetworkName $HubVNet `
    -Name $HubToSpoke `
    -ErrorAction SilentlyContinue

if ($null -ne $ExistingHubPeering)
{
    Write-Host "[INFO] Peering already exists." -ForegroundColor Yellow

    $Skipped++

    return
}

Write-Host ""

Write-Host "[INFO] Creating Hub -> $Site peering..."

try
{
    Add-AzVirtualNetworkPeering `
        -Name $HubToSpoke `
        -VirtualNetwork $HubVNetObject `
        -RemoteVirtualNetworkId $SpokeVNetObject.Id `
        -ErrorAction Stop | Out-Null

    Write-Host "[SUCCESS] Hub -> $Site peering created." -ForegroundColor Green
}
catch
{
    Write-Host "[ERROR] Failed creating Hub -> $Site peering." -ForegroundColor Red

    Write-Host $_.Exception.Message

    $Failed++

    return
}

Write-Host ""

Write-Host "[INFO] Creating $Site -> Hub peering..."

try
{
    Add-AzVirtualNetworkPeering `
        -Name $SpokeToHub `
        -VirtualNetwork $SpokeVNetObject `
        -RemoteVirtualNetworkId $HubVNetObject.Id `
        -ErrorAction Stop | Out-Null

    Write-Host "[SUCCESS] $Site -> Hub peering created." -ForegroundColor Green

    $Successful++
}
catch
{
    Write-Host "[ERROR] Failed creating $Site -> Hub peering." -ForegroundColor Red

    Write-Host $_.Exception.Message

    $Failed++

    return
}

Write-Host ""

Write-Host "[INFO] Verifying peerings..."

Get-AzVirtualNetworkPeering `
    -VirtualNetworkName $HubVNet `
    -ResourceGroupName $HubRG |
Select-Object Name, PeeringState |
Format-Table
}

############################################################
# DEPLOYMENT
############################################################

Write-Host ""

Write-Host "=========================================="

Write-Host " Deploying Hub and Spoke Peerings"

Write-Host "=========================================="

Write-Host ""

$Successful = 0

$Failed = 0

$Skipped = 0

foreach ($Site in $Peerings)
{
    Create-VNetPeering -Site $Site
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