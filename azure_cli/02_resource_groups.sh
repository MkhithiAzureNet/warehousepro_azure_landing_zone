#!/bin/bash

############################################################
# Project     : WarehousePro Logistics
# Sprint      : 01
# Script      : Resource Group Deployment
# Version     : 1.0
# Author      : Nhlanhla M
# Description : Deploys enterprise Resource Groups
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
# DEPLOY RESOURCE GROUPS
############################################################

echo ""
echo "=========================================="
echo " Deploying Enterprise Resource Groups"
echo "=========================================="
echo ""

for RG in "${RESOURCE_GROUPS[@]}"
do

    echo "------------------------------------------"
    echo "Checking Resource Group: $RG"

    EXISTS=$(az group exists --name "$RG")

    if [ "$EXISTS" = "true" ]
    then

        echo "Resource Group already exists."
        echo "Skipping..."

    else

        echo "Creating Resource Group..."

        az group create \
            --name "$RG" \
            --location "$LOCATION" \
            --output table

        echo "Deployment completed."

    fi

    echo ""

done

############################################################
# VERIFICATION
############################################################

echo ""
echo "=========================================="
echo " Verifying Resource Groups"
echo "=========================================="

az group list \
    --query "[?starts_with(name, 'RG-')].[name,location]" \
    --output table

############################################################
# SUMMARY
############################################################

echo ""
echo "=========================================="
echo " Resource Group Deployment Complete"
echo "=========================================="

echo "Project      : $PROJECT"
echo "Environment  : $ENVIRONMENT"
echo "Location     : $LOCATION"

echo ""
echo "Enterprise Resource Groups successfully processed."

exit 0