#!/bin/bash

############################################################
# Project     : WarehousePro Logistics
# Sprint      : 01
# Script      : Hub Subnet Deployment
# Version     : 1.0
# Author      : Nhlanhla M
# Description : Deploys the Hub Virtual Network Subnets
############################################################

############################################################
# PREREQUISITES
############################################################

# Azure CLI Installed

# Azure CLI Logged In

# Contributor Role

# Correct Subscription Selected

###########################################################
# VARIABLES
############################################################

LOCATION="southafricanorth"

PROJECT="WarehousePro"

ENVIRONMENT="Prod"

OWNER="Cloud Team"

BUSINESS="Logistics"

COSTCENTER="Infrastructure"

MANAGEDBY="AzureCLI"

CRITICALITY="High"

BACKUP="Yes"

RESOURCE_GROUPS=(
"RG-Networking-$ENVIRONMENT"
"RG-Identity-$ENVIRONMENT"
"RG-Management-$ENVIRONMENT"
"RG-Monitoring-$ENVIRONMENT"
"RG-SharedServices-$ENVIRONMENT"
"RG-WH-JHB-$ENVIRONMENT"
"RG-WH-DBN-$ENVIRONMENT"
"RG-WH-CPT-$ENVIRONMENT"
)

############################################################
# NETWORK VARIABLES
############################################################

NETWORK_RG="RG-Networking-$ENVIRONMENT"

VNET_NAME="VNET-Hub-$ENVIRONMENT"

FIREWALL_SUBNET="AzureFirewallSubnet"
FIREWALL_PREFIX="10.0.0.0/24"

BASTION_SUBNET="AzureBastionSubnet"
BASTION_PREFIX="10.0.1.0/26"

GATEWAY_SUBNET="GatewaySubnet"
GATEWAY_PREFIX="10.0.2.0/27"

SHARED_SUBNET="SharedServicesSubnet"
SHARED_PREFIX="10.0.10.0/24"

MANAGEMENT_SUBNET="ManagementSubnet"
MANAGEMENT_PREFIX="10.0.20.0/24"

############################################################
# VALIDATION
############################################################

echo "Checking Azure login..."

if ! az account show > /dev/null 2>&1
then
    echo "ERROR: Not logged into Azure."
    exit 1
fi

echo "Azure login successful."

echo ""

echo "Current Subscription"

az account show \
    --query name \
    -o table

echo ""

############################################################
# FUNCTIONS
############################################################

CreateSubnet() {

    SUBNET_NAME=$1
    SUBNET_PREFIX=$2

    echo ""
    echo "------------------------------------------"
    echo "[INFO] Processing subnet: $SUBNET_NAME"

    EXISTS=$(az network vnet subnet show \
        --resource-group "$NETWORK_RG" \
        --vnet-name "$VNET_NAME" \
        --name "$SUBNET_NAME" \
        --query "name" \
        --output tsv 2>/dev/null)

    if [ "$EXISTS" = "$SUBNET_NAME" ]
    then
        echo "[INFO] Subnet already exists."
        ((SKIPPED++))
        return
    fi

    echo "[INFO] Creating subnet..."

    az network vnet subnet create \
        --resource-group "$NETWORK_RG" \
        --vnet-name "$VNET_NAME" \
        --name "$SUBNET_NAME" \
        --address-prefixes "$SUBNET_PREFIX" \
        --output none

    if [ $? -eq 0 ]
    then
        echo "[SUCCESS] $SUBNET_NAME created successfully."
        ((SUCCESS++))
    else
        echo "[ERROR] Failed to create $SUBNET_NAME."
        ((FAILED++))
    fi

}

############################################################
# DEPLOYMENT
############################################################

echo ""
echo "=========================================="
echo " Deploying Hub Subnets"
echo "=========================================="
echo ""

SUCCESS=0
FAILED=0
SKIPPED=0

CreateSubnet "$FIREWALL_SUBNET" "$FIREWALL_PREFIX"

CreateSubnet "$BASTION_SUBNET" "$BASTION_PREFIX"

CreateSubnet "$GATEWAY_SUBNET" "$GATEWAY_PREFIX"

CreateSubnet "$SHARED_SUBNET" "$SHARED_PREFIX"

CreateSubnet "$MANAGEMENT_SUBNET" "$MANAGEMENT_PREFIX"

############################################################
# VERIFICATION
############################################################

echo ""
echo "=========================================="
echo " Verifying Hub Subnets"
echo "=========================================="

az network vnet subnet list \
    --resource-group "$NETWORK_RG" \
    --vnet-name "$VNET_NAME" \
    --query "[].{Subnet:name,Prefix:addressPrefix}" \
    --output table

############################################################
# SUMMARY
############################################################

echo ""
echo "=========================================="
echo " Deployment Summary"
echo "=========================================="

echo "Virtual Network : $VNET_NAME"

echo "Resource Group  : $NETWORK_RG"

echo ""

echo "Successful : $SUCCESS"

echo "Failed     : $FAILED"

echo "Skipped    : $SKIPPED"

echo ""

echo "Hub subnet deployment completed successfully."

exit 0