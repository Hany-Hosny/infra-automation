# Infrastructure Automation & Node Provisioning

A production-ready Bash automation script designed for secure infrastructure setup, node provisioning, and containerized deployment validation on Rocky Linux environments.

## 🚀 Tasks Covered

The script dynamically executes and validates the following infrastructure operations split into 4 major milestones:

### 1. User & Access Security Enforcement
* **Root Execution Guard:** Restricts script execution strictly to the `root` user or via `sudo`.
* **Isolated Environment Provisioning:** Automatically provisions a dedicated developer user (`devuser`) and an isolated secure group (`devgroup`).
* **Secured Directory Setup:** Configures a restricted deployment directory with strict ownership and permission inheritance.

### 2. System Metrics Auditing & Port Hardening
* **System Health Reporting:** Aggregates and prints clean, real-time metrics for current active user, internal IP address, and memory/swap utilization.
* **Port Hardening:** Audits active network ports and purges legacy unsecure print services (`cups`) to secure the attack surface.

### 3. Silent Docker Infrastructure Setup
* **Runtime Verification:** Checks for existing Docker installations to prevent redundant overhead.
* **Automated Installation:** Silently provisions the stable Docker Engine, activates the daemon, and appends the custom developer group to Docker permissions seamlessly.

### 4. Container Deployment & Health Check Validation
* **Nginx Container Deployment:** Launches a customized, lightweight Nginx container bound to local port `8080` serving a dedicated local configuration asset (`index.html`).
* **Automated Health Check:** Executes a localized HTTP validation check against the endpoint and verifies successful deployment by tracking the `200 OK` status response.

---

## 🛠️ How to Run

1. Clone the repository and navigate to the directory:
   ```bash
   git clone git@github.com:Hany-Hosny/infra-automation.git
   cd infra-automation
