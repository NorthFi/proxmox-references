# 🚀 Proxmox Toolkit

A comprehensive collection of scripts, tools, and utilities for Proxmox VE administration and automation.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Proxmox](https://img.shields.io/badge/Proxmox-VE-orange)](https://www.proxmox.com/)
[![Shell](https://img.shields.io/badge/Shell-Bash-green)](https://www.gnu.org/software/bash/)

## 📋 Table of Contents

- [Features](#features)
- [Quick Start](#quick-start)
- [Scripts & Tools](#scripts--tools)
- [Installation](#installation)
- [Usage Examples](#usage-examples)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

- **Container Management**: LXC creation, migration, and ID management
- **VM Operations**: Automated VM deployment and configuration
- **Backup Solutions**: Automated backup scripts and restore procedures
- **Monitoring Tools**: System health checks and performance monitoring
- **Network Management**: VLAN configuration and firewall automation
- **Storage Operations**: Disk management and storage optimization
- **Cluster Management**: Multi-node cluster administration tools

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/proxmox-toolkit.git
cd proxmox-toolkit

# Make scripts executable
chmod +x scripts/*.sh

# Run the setup script
./setup.sh
```

## 🛠️ Scripts & Tools

### Container Management

| Script | Description | Usage |
|--------|-------------|-------|
| `lxc-id-change.sh` | Change LXC container ID | `./scripts/lxc-id-change.sh 116 100` |
| `lxc-bulk-create.sh` | Create multiple LXC containers | `./scripts/lxc-bulk-create.sh config.yaml` |
| `lxc-backup.sh` | Automated LXC backup | `./scripts/lxc-backup.sh [container-id]` |
| `lxc-clone.sh` | Clone LXC containers | `./scripts/lxc-clone.sh source target` |

### VM Management

| Script | Description | Usage |
|--------|-------------|-------|
| `vm-deploy.sh` | Deploy VM from template | `./scripts/vm-deploy.sh template.conf` |
| `vm-snapshot.sh` | Create VM snapshots | `./scripts/vm-snapshot.sh [vm-id]` |
| `vm-migrate.sh` | Migrate VMs between nodes | `./scripts/vm-migrate.sh [vm-id] [target-node]` |

### System Operations

| Script | Description | Usage |
|--------|-------------|-------|
| `system-health.sh` | System health check | `./scripts/system-health.sh` |
| `cleanup-storage.sh` | Clean up unused storage | `./scripts/cleanup-storage.sh` |
| `backup-config.sh` | Backup Proxmox configuration | `./scripts/backup-config.sh` |

### Network & Security

| Script | Description | Usage |
|--------|-------------|-------|
| `firewall-setup.sh` | Configure firewall rules | `./scripts/firewall-setup.sh` |
| `vlan-config.sh` | VLAN configuration | `./scripts/vlan-config.sh` |
| `ssl-cert-update.sh` | Update SSL certificates | `./scripts/ssl-cert-update.sh` |

## 📦 Installation

### Prerequisites

- Proxmox VE 7.0 or later
- Root access to Proxmox host
- Basic understanding of Linux command line

### Method 1: Direct Download

```bash
wget -O - https://raw.githubusercontent.com/yourusername/proxmox-toolkit/main/install.sh | bash
```

### Method 2: Manual Installation

```bash
git clone https://github.com/yourusername/proxmox-toolkit.git
cd proxmox-toolkit
sudo ./install.sh
```

## 💡 Usage Examples

### Change LXC Container ID

```bash
# Change container ID from 116 to 100
./scripts/lxc-id-change.sh 116 100

# With verbose output
./scripts/lxc-id-change.sh 116 100 --verbose
```

### Create Multiple Containers

```bash
# Create containers from YAML config
./scripts/lxc-bulk-create.sh configs/containers.yaml

# Create with custom template
./scripts/lxc-bulk-create.sh configs/containers.yaml --template ubuntu-20.04
```

### System Health Check

```bash
# Basic health check
./scripts/system-health.sh

# Detailed report with email notification
./scripts/system-health.sh --detailed --email admin@example.com
```

## 📁 Repository Structure

```
proxmox-toolkit/
├── scripts/
│   ├── container/
│   │   ├── lxc-id-change.sh
│   │   ├── lxc-bulk-create.sh
│   │   └── lxc-backup.sh
│   ├── vm/
│   │   ├── vm-deploy.sh
│   │   └── vm-snapshot.sh
│   ├── system/
│   │   ├── system-health.sh
│   │   └── cleanup-storage.sh
│   └── network/
│       ├── firewall-setup.sh
│       └── vlan-config.sh
├── configs/
│   ├── containers.yaml
│   ├── vm-templates/
│   └── firewall-rules/
├── templates/
│   ├── lxc/
│   └── vm/
├── docs/
│   ├── INSTALLATION.md
│   ├── CONFIGURATION.md
│   └── TROUBLESHOOTING.md
├── tests/
├── LICENSE
└── README.md
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the project root:

```bash
# Proxmox Configuration
PROXMOX_HOST="your-proxmox-host"
PROXMOX_USER="root@pam"
PROXMOX_PASSWORD="your-password"

# Storage Configuration
DEFAULT_STORAGE="local-lvm"
BACKUP_STORAGE="backup-storage"

# Network Configuration
DEFAULT_BRIDGE="vmbr0"
VLAN_RANGE="100-200"

# Notification Settings
SMTP_SERVER="smtp.example.com"
ADMIN_EMAIL="admin@example.com"
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Setup

```bash
# Fork the repository
git fork https://github.com/yourusername/proxmox-toolkit.git

# Create a feature branch
git checkout -b feature/amazing-feature

# Make your changes and commit
git commit -m "Add amazing feature"

# Push to your fork and submit a pull request
git push origin feature/amazing-feature
```

## 📚 Documentation

- [Installation Guide](docs/INSTALLATION.md)
- [Configuration Guide](docs/CONFIGURATION.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)
- [API Reference](docs/API.md)

## 🐛 Known Issues

- LXC ID change requires container to be stopped
- Some scripts require root privileges
- Backup scripts need sufficient storage space

## 🔄 Changelog

### v1.2.0 (Latest)
- Added bulk container creation
- Improved error handling
- Added system health monitoring
- Enhanced logging

### v1.1.0
- Added VM management scripts
- Network configuration tools
- SSL certificate management

### v1.0.0
- Initial release
- Basic LXC management
- Container ID change functionality

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Proxmox VE team for the amazing virtualization platform
- Community contributors and testers
- Open source tools and libraries used

## 📞 Support

- 📧 Email: support@example.com
- 💬 Discord: [Join our server](https://discord.gg/proxmox-toolkit)
- 📖 Wiki: [GitHub Wiki](https://github.com/yourusername/proxmox-toolkit/wiki)
- 🐛 Issues: [GitHub Issues](https://github.com/yourusername/proxmox-toolkit/issues)

---

⭐ **Sta
