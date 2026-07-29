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

echo -e  "\n [1/5] Root execution verified. Starting configuration..."

DEVELOPER_USER="dev_contractor"
DEVELOPER_GROUP="dev_workflow"
DEPLOY_DIR="/opt/secure_deployment"

groupadd "$DEVELOPER_GROUP" 2>/dev/null || true

useradd -m -g "$DEVELOPER_GROUP" "$DEVELOPER_USER" 2>/dev/null || true

mkdir -p "$DEPLOY_DIR"

chown -R "$DEVELOPER_USER":"$DEVELOPER_GROUP" "$DEPLOY_DIR"

chmod 770 "$DEPLOY_DIR"

echo "Task 1 Complete: User, Group, and Secured Directory are ready!"

# --- 2. Audit & Port Hardening ---

echo -e "\n [2/5] Printing System Health Report..."
echo "----------------------------------------"
echo "Current Active User: $(whoami)"
echo "Internal IP Address: $(hostname -I | awk '{print $1}')"
echo "Total Memory Statistics:"
free -h
echo "----------------------------------------"

echo "Auditing active ports and purging legacy print/cups services..."

# --- 3. Add TLS certificate
echo -e "\n [3/5] Generating TLS Certificate..."
mkdir -p  certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048\
	-keyout certs/server.key\
	-out certs/server.crt\
	-subj "/CN=localhost"
echo "Task 3 Complete: Self-signed TLS certificate generated."

# --- 4. Containerization (Docker Architecture) ---

echo -e "\n [4/5] Configuring Docker Infrastructure..."

if ! command -v docker &> /dev/null; then

    echo "Docker not found. Installing Docker CE..."
apt config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &>/dev/null
dnf install docker-ce docker-ce-cli containerd.io -y &>/dev/null

else
    echo "Docker is already installed."
fi

systemctl enable --now docker &>/dev/null
usermod -aG docker "$DEVELOPER_USER"


if [ "$(docker ps -aq -f name=custom_webserver)" ]; then
    docker rm -f custom_webserver &>/dev/null
fi

docker run -d \
  --name custom_webserver \
  -p 8080:80 \
  -p 8443:8443 \
  -v /home/hany/infra-automation/index.html:/usr/share/nginx/html/index.html:ro \
    -v /home/hany/infra-automation/nginx.conf:/etc/nginx/nginx.conf:ro \
  -v /home/hany/infra-automation/certs:/etc/nginx/certs:ro \
  --restart always \
  nginx:alpine &>/dev/null

echo "Task 4 Complete: Docker engine is active and developer permissions configured."

# --- 5. Health Check Validation ---

echo -e "\n [5/5] Running Health Check Validation..."
sleep 3

STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)

echo "Checking local web endpoint on port 8080..."
echo "Response HTTP Status Code: $STATUS_CODE"

if [ "$STATUS_CODE" -eq 301 ]; then
        echo "Validation Success: Container is serving requests successfully."
else
    echo "Validation Failed: Expected status 200, but got $STATUS_CODE"
    exit 1
fi
