# Secure CI/CD Pipeline with DevSecOps Controls

This project demonstrates how security can be integrated directly into the CI/CD pipeline using modern DevSecOps practices.

The repository contains a simple Python Flask API that is containerized with Docker and automatically scanned for security issues during the CI pipeline.

The goal is to implement **shift-left security**, ensuring vulnerabilities are detected early before reaching production.

---

# Technologies Used

- Python Flask API
- Docker (multi-stage secure container build)
- GitHub Actions CI/CD
- Gitleaks (Secret scanning)
- Semgrep (SAST)
- pip-audit (Dependency vulnerability scanning)
- Trivy (Container vulnerability scanning)
- CycloneDX (SBOM generation)

This pipeline simulates the type of automated security checks used in modern DevSecOps environments.

---

# Architecture

The system uses GitHub Actions to automatically run security checks whenever code is pushed to the repository.

Developer
│
▼
GitHub Repository
│
▼
GitHub Actions Pipeline
│
├── Secret Scanning (Gitleaks)
├── Static Code Analysis (Semgrep)
├── Dependency Vulnerability Scan (pip-audit)
├── Container Image Scan (Trivy)
└── SBOM Generation (CycloneDX)
│
▼
Secure Container Image


Each stage ensures that vulnerabilities are detected early in the development lifecycle.

---

# Application

The application is a simple Flask API used to demonstrate the CI/CD pipeline security workflow.

### Endpoints

| Endpoint | Description |
|--------|-------------|
| `/` | Returns a welcome message |
| `/health` | Health check endpoint |
| `/external` | Makes a request to an external API |

The application itself is intentionally simple because the focus of this project is **CI/CD security automation**.

---

# Container Security Design

The Docker container follows several best practices.

## Multi-stage Build

The image uses a builder stage to install dependencies and a separate runtime stage to reduce the final image size.

## Non-root Execution

The container runs as a non-root user.

```dockerfile
USER appuser
```
## Slim Base Image

The container uses:

```dockerfile
python:3.12-slim

```

Deterministic Dependencies
--------------------------

Dependencies are pinned in requirements.txt to ensure **reproducible builds** and prevent unexpected dependency changes.

Security Pipeline
-----------------

The CI/CD pipeline automatically runs several security checks whenever code is pushed to the repository.

### 1\. Secret Scanning

**Tool:** Gitleaks

Detects accidentally committed secrets such as:

*   API keys
    
*   passwords
    
*   tokens
    

### 2\. Static Application Security Testing (SAST)

**Tool:** Semgrep

Analyzes source code for insecure patterns.

Example findings include:

*   insecure Flask configurations
    
*   unsafe input handling
    
*   exposed application servers
    

### 3\. Dependency Vulnerability Scanning

**Tool:** pip-audit

Detects known vulnerabilities in Python packages using vulnerability databases.

### 4\. Container Image Scanning

**Tool:** Trivy

Scans the Docker image for:

*   OS vulnerabilities
    
*   dependency vulnerabilities
    
*   container misconfigurations
    

### 5\. Software Bill of Materials (SBOM)

**Tool:** CycloneDX

Generates a dependency inventory that helps detect supply-chain vulnerabilities.

The generated SBOM artifact is attached to the CI pipeline for auditing.

Security Gate
-------------

The CI pipeline fails if high-severity vulnerabilities are detected.

Example configuration:
```bash
   --exit-code 1  

--severity HIGH,CRITICAL
```

This ensures (highly) insecure code cannot be merged into the main branch.

Lessons Learned
---------------

During this project several important DevSecOps concepts were explored:

*   Integrating security checks directly into CI/CD pipelines
    
*   Preventing vulnerable containers from being deployed
    
*   Using automated scanning tools to detect security issues early
    
*   Generating SBOMs for software supply chain transparency
    
*   Implementing security gates that block vulnerable builds
    