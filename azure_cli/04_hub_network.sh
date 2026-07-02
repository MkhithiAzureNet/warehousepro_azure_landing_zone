#!/bin/bash

############################################################
# Project     : WarehousePro Logistics
# Sprint      : 01
# Script      : Hub Virtual Network Deployment
# Version     : 1.0
# Author      : Nhlanhla M
# Description : Deploys the Hub Virtual Network
############################################################

############################################################
# PREREQUISITES
############################################################

# Azure CLI Installed
# Azure CLI Logged In
# Contributor Role
# Correct Subscription Selected

############################################################
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
"RG-WH-Durban-$ENVIRONMENT"
"RG-WH-CPT-$ENVIRONMENT"
)

############################################################
# NETWORK VARIABLES
############################################################

NETWORK_RG="RG-Networking-$ENVIRONMENT"

VNET_NAME="VNET-Hub-$ENVIRONMENT"

VNET_ADDRESS_SPACE="10.0.0.0/16"

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
# DEPLOYMENT
############################################################

echo ""
echo "=========================================="
echo " Deploying Hub Virtual Network"
echo "=========================================="
echo ""

SUCCESS=0
FAILED=0
SKIPPED=0

echo "[INFO] Checking if $VNET_NAME exists..."

EXISTS=$(az network vnet list \
    --resource-group "$NETWORK_RG" \
    --query "[?name=='$VNET_NAME'] | length(@)" \
    --output tsv)

    if [ "$EXISTS" -eq 1 ]
then

    echo "[INFO] Virtual Network already exists."

    ((SKIPPED++))

else

    echo "[INFO] Creating Hub Virtual Network..."

    az network vnet create \
    --resource-group "$NETWORK_RG" \
    --name "$VNET_NAME" \
    --address-prefixes "$VNET_ADDRESS_SPACE" \
    --location "$LOCATION" \
    --output table

    if [ $? -eq 0 ]
then
    echo "[SUCCESS] Hub Virtual Network created successfully."
    ((SUCCESS++))
else
    echo "[ERROR] Failed to create Hub Virtual Network."
    ((FAILED++))  
fi

fi

############################################################
# VERIFICATION
############################################################

echo ""
echo "=========================================="
echo " Verifying Hub Virtual Network"
echo "=========================================="

az network vnet show \
    --resource-group "$NETWORK_RG" \
    --name "$VNET_NAME" \
    --query "{Name:name,AddressSpace:addressSpace.addressPrefixes}" \
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
echo "Address Space   : $VNET_ADDRESS_SPACE"

echo ""
echo "Successful : $SUCCESS"
echo "Failed     : $FAILED"
echo "Skipped    : $SKIPPED"

echo ""
echo "Hub Virtual Network deployment completed."

exit 0