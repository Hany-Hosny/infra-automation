# Infrastructure Automation & Secure Nginx Deployment

A production-ready Bash automation script that provisions a secure Linux environment, deploys a Dockerized Nginx web server with HTTPS support, and validates the deployment automatically.

---

## 🚀 Features

The automation script performs the following tasks:

### 1. User & Access Security
- Verifies that the script is executed as `root` or with `sudo`.
- Creates a dedicated developer user (`devuser`).
- Creates a secure developer group (`devgroup`).
- Configures a protected deployment directory with appropriate ownership and permissions.

### 2. System Health Report
- Displays the current active user.
- Displays the internal IP address.
- Shows memory and swap usage.
- Audits active network ports.
- Removes legacy `cups` services if present.

### 3. TLS Certificate Generation
- Generates a self-signed SSL/TLS certificate using OpenSSL.
- Stores the generated certificate and private key for secure HTTPS communication.

### 4. Dockerized Nginx Deployment
- Verifies or installs Docker automatically.
- Deploys an Nginx container using a custom `nginx.conf`.
- Maps:
  - **HTTP:** `localhost:8080`
  - **HTTPS:** `localhost:8443`
- Redirects all HTTP requests to HTTPS.

### 5. Deployment Validation
- Performs an automated health check.
- Confirms the HTTP endpoint returns the expected **301 Redirect**.
- Verifies that the container is running successfully.

---

## 📁 Project Structure

```text
infra-automation/
├── onboarding_automation.sh
├── nginx.conf
├── README.md
└── certs/            # Generated automatically (not tracked)
```

---

## 🛠️ Requirements

- Rocky Linux
- Bash
- OpenSSL
- Docker

---

## ▶️ How to Run

Clone the repository:

```bash
git clone git@github.com:Hany-Hosny/infra-automation.git
cd infra-automation
```

Run the automation script:

```bash
sudo bash onboarding_automation.sh
```

---

## 🌐 Access the Web Server

HTTP:

```text
http://localhost:8080
```

HTTPS:

```text
https://localhost:8443
```

If accessing remotely:

```text
https://<SERVER_IP>:8443
```

---

## ⚠️ Notes

- The generated SSL certificate is **self-signed** and intended for testing purposes.
- Browsers will display a security warning because the certificate is not issued by a trusted Certificate Authority (CA).
- The `certs/` directory is generated automatically when the script runs and should not be committed to the repository.

---

## 📌 Technologies Used

- Bash
- Docker
- Nginx
- OpenSSL
- Linux System Administration

---

## 👨‍💻 Author

**Hany Hosny**

GitHub: https://github.com/Hany-Hosny
