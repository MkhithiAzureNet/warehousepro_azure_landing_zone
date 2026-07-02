#!/bin/bash

############################################################
# Project     : WarehousePro Logistics
# Sprint      : 01
# Script      : Foundation Deployment
# Author      : Nhlanhla M
# Description : Creates the Azure Landing Zone Foundation
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
# VALIDATION
############################################################

echo "Checking Azure login..."

az account show > /dev/null 2>&1

if [ $? -ne 0 ]
then
    echo "ERROR: Not logged into Azure."
    exit 1
fi

echo "Azure login successful."

############################################################
# SUBSCRIPTION
############################################################

echo ""
echo "Current Subscription"

az account show \
    --query name \
    -o table

############################################################
# DEPLOYMENT INFORMATION
############################################################

echo ""
echo "=========================================="
echo " WarehousePro Deployment Information"
echo "=========================================="

echo "Project      : $PROJECT"
echo "Environment  : $ENVIRONMENT"
echo "Location     : $LOCATION"
echo "Owner        : $OWNER"
echo "Business     : $BUSINESS"
echo "Cost Center  : $COSTCENTER"
echo "Managed By   : $MANAGEDBY"

echo ""
echo "Foundation validation completed successfully."