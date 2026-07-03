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