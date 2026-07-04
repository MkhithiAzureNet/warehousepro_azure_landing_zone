############################################################
# Project     : WarehousePro Logistics
# Sprint      : 02
# Script      : Enterprise Route Tables
# Version     : 1.0
# Author      : Nhlanhla M
# Description : Deploys Enterprise Route Tables
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
# ROUTE TABLE CONFIGURATION
############################################################

$RouteTables = @(
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

function Create-RouteTable
{
    param
    (
        [string]$Site
    )

    $ResourceGroup = "RG-WH-$Site-$Environment"

    $RouteTable = "RT-WH-$Site-$Environment"

    Write-Host ""

    Write-Host "=========================================="

    Write-Host " Deploying Route Table for $Site"

    Write-Host "=========================================="

    Write-Host "Resource Group : $ResourceGroup"

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

Write-Host "[INFO] Checking existing Route Table..."

$ExistingRouteTable = Get-AzRouteTable `
    -ResourceGroupName $ResourceGroup `
    -Name $RouteTable `
    -ErrorAction SilentlyContinue

if ($null -ne $ExistingRouteTable)
{
    Write-Host "[INFO] Route Table already exists." -ForegroundColor Yellow

    $Skipped++

    return
}

Write-Host ""

Write-Host "[INFO] Creating Route Table..."

try
{
    $RouteTableObject = New-AzRouteTable `
        -Name $RouteTable `
        -ResourceGroupName $ResourceGroup `
        -Location $Location `
        -ErrorAction Stop

    Write-Host "[SUCCESS] $RouteTable created." -ForegroundColor Green

    Write-Host ""

Write-Host "[INFO] Verifying deployment..."

Get-AzRouteTable `
    -ResourceGroupName $ResourceGroup `
    -Name $RouteTable |
Select-Object Name, Location |
Format-Table

$Successful++
}
catch
{
    Write-Host "[ERROR] Failed creating $RouteTable." -ForegroundColor Red

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

Write-Host " Deploying Route Tables"

Write-Host "=========================================="

Write-Host ""

$Successful = 0

$Failed = 0

$Skipped = 0

foreach ($Site in $RouteTables)
{
    Create-RouteTable -Site $Site
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