#!/bin/bash

############################################################
# Project     : WarehousePro Logistics
# Sprint      : 02
# Script      : Spoke Virtual Network Deployment
# Version     : 1.0
# Author      : Nhlanhla M
# Description : Deploys Enterprise Spoke Virtual Networks
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

############################################################
# NETWORK VARIABLES
############################################################

HUB_RG="RG-Networking-$ENVIRONMENT"

############################################################
# SPOKE CONFIGURATION
############################################################

SPOKES=(
"JHB:10.1.0.0/16"
"DBN:10.2.0.0/16"
"CPT:10.3.0.0/16"
)

############################################################
# FUNCTIONS
############################################################

CreateSpokeVNet() {

    SITE=$1

    ADDRESS_SPACE=$2

    RG_NAME="RG-WH-$SITE-$ENVIRONMENT"

    VNET_NAME="VNET-WH-$SITE-$ENVIRONMENT"

    echo ""

    echo "=========================================="

    echo " Deploying $SITE Regional Site"

    echo "=========================================="

    echo "Resource Group : $RG_NAME"

    echo "Virtual Network: $VNET_NAME"

    echo "Address Space  : $ADDRESS_SPACE"

    echo ""

    echo "[INFO] Checking if Resource Group exists..."

RG_EXISTS=$(az group exists \
    --name "$RG_NAME")

if [ "$RG_EXISTS" = "false" ]
then

    echo "[ERROR] Resource Group $RG_NAME does not exist."

    ((FAILED++))

    return

fi

echo "[INFO] Checking if Virtual Network exists..."

EXISTS=$(az network vnet list \
    --resource-group "$RG_NAME" \
    --query "[?name=='$VNET_NAME'] | length(@)" \
    --output tsv)

    if [ "$EXISTS" -eq 1 ]
then

    echo "[INFO] Virtual Network already exists."

    ((SKIPPED++))

    return

fi

echo "[INFO] Creating Virtual Network..."

az network vnet create \
    --resource-group "$RG_NAME" \
    --name "$VNET_NAME" \
    --location "$LOCATION" \
    --address-prefixes "$ADDRESS_SPACE" \
    --output none

    if [ $? -eq 0 ]
then

    echo "[SUCCESS] $VNET_NAME deployed successfully."

    ((SUCCESS++))

else

    echo "[ERROR] Failed deploying $VNET_NAME."

    ((FAILED++))

    return

fi

echo ""

echo "[INFO] Verifying deployment..."

az network vnet show \
    --resource-group "$RG_NAME" \
    --name "$VNET_NAME" \
    --query "{Name:name,AddressSpace:addressSpace.addressPrefixes[0]}" \
    --output table

}

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

echo " Deploying Regional Site Networks"

echo "=========================================="

echo ""

SUCCESS=0

FAILED=0

SKIPPED=0

for SPOKE in "${SPOKES[@]}"
do

    SITE=$(echo "$SPOKE" | cut -d':' -f1)

    PREFIX=$(echo "$SPOKE" | cut -d':' -f2)

    CreateSpokeVNet "$SITE" "$PREFIX"

done

############################################################
# SUMMARY
############################################################

echo ""

echo "=========================================="

echo " Deployment Summary"

echo "=========================================="

echo "Successful : $SUCCESS"

echo "Skipped    : $SKIPPED"

echo "Failed     : $FAILED"

echo ""