# SlowPro

Multi-Distro Linux DFIR & Incident Response Framework

SlowPro is a Bash-based Digital Forensics and Incident Response (DFIR) framework designed to collect, analyze, and report forensic evidence across multiple Linux distributions.

---

## Features

### Case Management
- Automatic case creation
- Structured evidence storage
- Investigation workflow management

### Multi-Distro Support
- Ubuntu
- Debian
- Kali Linux
- RHEL
- Rocky Linux
- AlmaLinux
- Arch Linux

### Evidence Collection
- Host information
- User accounts
- Running processes
- Network connections
- System services
- Installed packages

### Evidence Integrity
- SHA256 evidence hashing
- Chain-of-custody support

### Analysis
- IOC detection
- Threat scoring
- Timeline reconstruction

### Reporting
- HTML investigation reports

---

## Project Structure

```text
SlowPro/
├── adapters/
├── analyzers/
├── collectors/
├── core/
├── data/
├── reports/
├── cases/
└── slowpro.sh