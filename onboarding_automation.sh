#!/bin/bash

#========================================================
# Task: Onboarding Automation & Port Hardening (Staging Node: rocky-node-01)
# # Reference File: enterprise_devops_email_2.pdf
# =======================================================
# --- 1. Access & Security: Enforce root/sudo execution ---

if [ "$EUID" -ne 0 ]; then

	echo "Error: This script must be run as root or with sudo!"
    exit 1
fi

echo  "[1/5] Root execution verified. Starting configuration..."

DEVELOPER_USER="dev_contractor"
DEVELOPER_GROUP="dev_workflow"
DEPLOY_DIR="/opt/secure_deployment"

groupadd "$DEVELOPER_GROUP"

useradd -m -g "$DEVELOPER_GROUP" "$DEVELOPER_USER"

mkdir -p "$DEPLOY_DIR"

chown -R "$DEVELOPER_USER":"$DEVELOPER_GROUP" "$DEPLOY_DIR"

chmod 770 "$DEPLOY_DIR"

echo "Task 1 Complete: User, Group, and Secured Directory are ready!"

# --- 2. Audit & Port Hardening ---

echo -e "\n🔹 [2/5] Printing System Health Report..."
echo "----------------------------------------"
echo "Current Active User: $(whoami)"
echo "Internal IP Address: $(hostname -I | awk '{print $1}')"
echo "Total Memory Statistics:"
free -h
echo "----------------------------------------"

echo "🧹 Auditing active ports and purging legacy print/cups services..."
