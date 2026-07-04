############################################################
# Project     : WarehousePro Logistics
# Sprint      : 02
# Script      : Enterprise Network Security Groups
# Version     : 1.0
# Author      : Nhlanhla M
# Description : Deploys Enterprise Network Security Groups
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

$Location = "South Africa North"

$Environment = "Prod"

############################################################
# NSG CONFIGURATION
############################################################

$NetworkSecurityGroups = @(
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

function Create-NSG
{
    param
    (
        [string]$Site
    )

    $ResourceGroup = "RG-WH-$Site-$Environment"

    $NSGName = "NSG-WH-$Site-$Environment"

    Write-Host ""

    Write-Host "=========================================="

    Write-Host " Deploying NSG for $Site"

    Write-Host "=========================================="

    Write-Host "Resource Group : $ResourceGroup"

    Write-Host "NSG            : $NSGName"

    Write-Host ""

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

Write-Host "[INFO] Checking existing Network Security Group..."

$ExistingNSG = Get-AzNetworkSecurityGroup `
    -ResourceGroupName $ResourceGroup `
    -Name $NSGName `
    -ErrorAction SilentlyContinue

if ($null -ne $ExistingNSG)
{
    Write-Host "[INFO] Network Security Group already exists." -ForegroundColor Yellow

    $Skipped++

    return
}

Write-Host ""

Write-Host "[INFO] Creating Network Security Group..."

try
{
    $NSGObject = New-AzNetworkSecurityGroup `
        -ResourceGroupName $ResourceGroup `
        -Location $Location `
        -Name $NSGName `
        -ErrorAction Stop

    Write-Host "[SUCCESS] $NSGName created." -ForegroundColor Green

    Write-Host ""

Write-Host "[INFO] Verifying deployment..."

Get-AzNetworkSecurityGroup `
    -ResourceGroupName $ResourceGroup `
    -Name $NSGName |
Select-Object Name, Location |
Format-Table

$Successful++
}
catch
{
    Write-Host "[ERROR] Failed creating $NSG." -ForegroundColor Red

    Write-Host $_.Exception.Message

    $Failed++

    return
}
}

############################################################
# DEPLOYMENT
############################################################

Write-Host ""

Write-Host "=========================================="

Write-Host " Deploying Network Security Groups"

Write-Host "=========================================="

Write-Host ""

$Successful = 0

$Failed = 0

$Skipped = 0

foreach ($Site in $NetworkSecurityGroups)
{
    Create-NSG -Site $Site
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