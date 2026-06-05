# Kenyatta National Hospital (KNH) Digital Infrastructure

This repository contains the DevOps automated data management environment and analytical dashboard designed for the KNH core data engine. The system governs, processes, and archives metrics for 12 critical medical sensors.

## 👥 Team & Role Mapping (Group 37)
Due to a 3-member team structure, responsibilities were consolidated to fulfill all operational milestones efficiently:

* **Isaac Musaedi Mbongo (Isa1ac309)**: Handled directory initialization and strict data permission controls (`chmod 700`) within `hospital_admin.sh`.
* **Adhieu Alier (aalier1-dot)**: Developed `hospital_analysis.sh` utilizing advanced filtering (`grep`, `awk`) to track critical clinical vitals and compute facility resource utilization averages.
* **Gwiza Rwagitare Ian (iangw00)**: Scripted `hospital_archive.sh` to implement structured log rotation, timestamp generation, and touch parameters to guarantee data engine system continuity.

---

## 📁 Repository Structure Overview
* `hospital_system.py`: Core background Python medical data simulator engine.
* `hospital_admin.sh`: Sets up required directories and locks down environment access permissions.
* `hospital_analysis.sh`: Scans active logs for alerts and generates statistical vital reporting summaries.
* `hospital_archive.sh`: Automatically rotates active logs into secure timestamped historical archives.
* `.gitignore`: Excludes runtime variables, process IDs, and sensitive logs from production source control tracking.

---

## 🚀 Deployment Instructions

### 1. Initialize & Secure Environment
```bash
./hospital_admin.sh
