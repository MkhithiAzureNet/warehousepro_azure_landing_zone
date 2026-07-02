#!/bin/bash

############################################################
# Project     : WarehousePro Logistics
# Sprint      : 01
# Script      : Enterprise Resource Tagging
# Version     : 1.0
# Author      : Nhlanhla M
# Description : Applies enterprise tags to Resource Groups
############################################################

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
echo " Applying Enterprise Tags"
echo "=========================================="
echo ""

SUCCESS=0
FAILED=0
SKIPPED=0

for RG in "${RESOURCE_GROUPS[@]}"
do

    echo ""
    echo "------------------------------------------"
    echo "[INFO] Processing: $RG"

    EXISTS=$(az group exists --name "$RG")

    if [ "$EXISTS" = "false" ]
    then

        echo "[WARNING] Resource Group not found."
        ((FAILED++))

        continue

    fi

    echo "[INFO] Applying enterprise tags..."

az group update \
    --name "$RG" \
    --set tags.Project="$PROJECT" \
          tags.Environment="$ENVIRONMENT" \
          tags.BusinessUnit="$BUSINESS" \
          tags.CostCenter="$COSTCENTER" \
          tags.Owner="$OWNER" \
          tags.ManagedBy="$MANAGEDBY" \
          tags.Criticality="$CRITICALITY" \
          tags.Backup="$BACKUP" \
    --output none

    if [ $? -eq 0 ]
then

    echo "[SUCCESS] Tags applied successfully."

    ((SUCCESS++))

else

    echo "[ERROR] Failed to apply tags."

    ((FAILED++))

fi

done

############################################################
# VERIFICATION
############################################################

echo ""
echo "=========================================="
echo " Verifying Resource Group Tags"
echo "=========================================="

az group list \
    --query "[].{Name:name,Project:tags.Project,Environment:tags.Environment}" \
    --output table

############################################################
# SUMMARY
############################################################

echo ""
echo "=========================================="
echo " Deployment Summary"
echo "=========================================="

echo "Resource Groups Processed : ${#RESOURCE_GROUPS[@]}"
echo "Successful               : $SUCCESS"
echo "Failed                   : $FAILED"
echo "Skipped                  : $SKIPPED"

echo ""
echo "Enterprise tagging completed."

exit 0