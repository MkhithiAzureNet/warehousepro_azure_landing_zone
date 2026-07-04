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

$RouteTableAssociations = @(
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

function Associate-RouteTable
{
    param
    (
        [string]$Site
    )

    $ResourceGroup = "RG-WH-$Site-$Environment"

    $VNetName = "VNET-WH-$Site-$Environment"

    $SubnetName = "WarehouseSubnet"

    $RouteTableName = "RT-WH-$Site-$Environment"

    Write-Host ""

    Write-Host "=========================================="

    Write-Host " Associating Route Table for $Site"

    Write-Host "=========================================="

    Write-Host "Resource Group : $ResourceGroup"

    Write-Host "Virtual Network: $VNetName"

    Write-Host "Subnet         : $SubnetName"

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
    Write-Host "[ERROR] Resource Group not found." -ForegroundColor Red

    $Failed++

    return
}

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
    Write-Host "[ERROR] Virtual Network not found." -ForegroundColor Red

    $Failed++

    return
}

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
    Write-Host "[ERROR] Route Table not found." -ForegroundColor Red

    $Failed++

    return
}

Write-Host ""

########################################################
# Retrieve Warehouse Subnet
########################################################

Write-Host "[INFO] Retrieving Warehouse subnet..."

$SubnetObject = Get-AzVirtualNetworkSubnetConfig `
    -VirtualNetwork $VNetObject `
    -Name $SubnetName `
    -ErrorAction SilentlyContinue

if ($null -eq $SubnetObject)
{
    Write-Host "[ERROR] Warehouse subnet not found." -ForegroundColor Red

    $Failed++

    return
}

Write-Host ""

########################################################
# Associate Route Table
########################################################

Write-Host "[INFO] Associating Route Table..."

try
{
    $SubnetObject.RouteTable = $RouteTableObject

    $VNetObject | Set-AzVirtualNetwork `
        -ErrorAction Stop | Out-Null

    Write-Host "[SUCCESS] Route Table associated." -ForegroundColor Green
}
catch
{
    Write-Host "[ERROR] Failed associating Route Table." -ForegroundColor Red

    Write-Host $_.Exception.Message

    $Failed++

    return
}

Write-Host ""

########################################################
# Verify Association
########################################################

Write-Host "[INFO] Verifying association..."

$Verification = Get-AzVirtualNetworkSubnetConfig `
    -VirtualNetwork $VNetObject `
    -Name $SubnetName

$Verification |
Select-Object Name,
@{
    Name="RouteTable"
    Expression={
        if ($_.RouteTable)
        {
            $_.RouteTable.Id.Split("/")[-1]
        }
        else
        {
            "None"
        }
    }
} |
Format-Table

$Successful++

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

foreach ($Site in $RouteTableAssociations)
{
    Associate-RouteTable -Site $Site
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