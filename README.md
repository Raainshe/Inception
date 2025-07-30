# 🐳 Inception

A complete **LEMP stack** (Linux, NGINX, MariaDB, PHP) containerized with **Docker** and orchestrated with **Docker Compose**. This project demonstrates modern DevOps practices by creating a multi-service web application infrastructure using custom Docker containers.

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![NGINX](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-%23117AC9.svg?style=for-the-badge&logo=WordPress&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)

## 📋 Table of Contents

- [🎯 Project Overview](#-project-overview)
- [🏗️ Architecture](#️-architecture)
- [⚙️ Services](#️-services)
- [🚀 Quick Start](#-quick-start)
- [📁 Project Structure](#-project-structure)
- [🔧 Configuration](#-configuration)
- [🛠️ Available Commands](#️-available-commands)
- [🌐 Accessing Your Site](#-accessing-your-site)
- [🔍 Monitoring & Debugging](#-monitoring--debugging)
- [🧹 Cleanup](#-cleanup)
- [⚠️ Troubleshooting](#️-troubleshooting)
- [📚 Technical Details](#-technical-details)

## 🎯 Project Overview

**Inception** is a **42 School project** that challenges students to set up a complete web infrastructure using **Docker containers**. The project emphasizes:

- **Containerization** with custom Docker images
- **Service orchestration** with Docker Compose
- **Security** with HTTPS/TLS encryption
- **Database management** with MariaDB
- **Web server configuration** with NGINX
- **Content management** with WordPress

### 🎯 Learning Objectives

- Master Docker containerization concepts
- Understand multi-service application architecture
- Learn NGINX reverse proxy configuration
- Practice database management and security
- Implement HTTPS with SSL certificates
- Develop DevOps and system administration skills

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     🌐 Internet                             │
│                         │                                   │
│                    HTTPS (443)                              │
│                         │                                   │
│  ┌─────────────────────────────────────────────────────────┐│
│  │                🔒 NGINX Container                        ││
│  │                                                         ││
│  │  • SSL Termination                                      ││
│  │  • Reverse Proxy                                        ││
│  │  • Static File Serving                                  ││
│  │                                                         ││
│  └─────────────────┬───────────────────────────────────────┘│
│                    │ FastCGI (9000)                         │
│                    │                                        │
│  ┌─────────────────▼───────────────────────────────────────┐│
│  │               🐘 WordPress Container                     ││
│  │                                                         ││
│  │  • PHP-FPM 7.4                                          ││
│  │  • WordPress CMS                                        ││
│  │  • WP-CLI Management                                    ││
│  │                                                         ││
│  └─────────────────┬───────────────────────────────────────┘│
│                    │ MySQL Protocol (3306)                 │
│                    │                                        │
│  ┌─────────────────▼───────────────────────────────────────┐│
│  │               🗄️ MariaDB Container                      ││
│  │                                                         ││
│  │  • Database Server                                      ││
│  │  • Data Persistence                                     ││
│  │  • User Management                                      ││
│  │                                                         ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

## ⚙️ Services

### 🔒 NGINX
- **Purpose**: Web server and reverse proxy
- **Features**: 
  - HTTPS/SSL termination with self-signed certificates
  - Serves static files
  - Proxies PHP requests to WordPress container
- **Port**: 443 (HTTPS), 80 (HTTP redirect)

### 🐘 WordPress
- **Purpose**: Content Management System
- **Features**:
  - PHP 7.4 with PHP-FPM
  - WordPress installation and configuration
  - WP-CLI for management
  - Automatic database setup
- **Port**: 9000 (FastCGI, internal)

### 🗄️ MariaDB
- **Purpose**: Database server
- **Features**:
  - MySQL-compatible database
  - Persistent data storage
  - Automatic database and user creation
  - Secure configuration
- **Port**: 3306 (internal only)

## 🚀 Quick Start

### Prerequisites
- **Docker** (20.10+)
- **Docker Compose** (2.0+)
- **Make** utility
- **Linux/macOS** (WSL2 for Windows)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Raainshe/Inception.git
   cd Inception
   ```

2. **Start the application**
   ```bash
   make
   ```

3. **Access your site**
   - Open your browser and go to: **https://rmakoni.42.fr**
   - Accept the SSL certificate warning (self-signed certificate)

That's it! Your complete web stack is now running.

## 📁 Project Structure

```
Inception/
├── Makefile                    # Build and management commands
├── README.md                   # This file
├── .gitignore                  # Git ignore rules
└── srcs/                       # Source code directory
    ├── docker-compose.yml      # Service orchestration
    ├── .env                    # Environment variables
    └── requirements/           # Service configurations
        ├── nginx/              # NGINX web server
        │   ├── Dockerfile      # NGINX container build
        │   └── conf            # NGINX configuration
        ├── wordpress/          # WordPress CMS
        │   ├── Dockerfile      # WordPress container build
        │   └── install.sh      # WordPress setup script
        └── mariadb/            # MariaDB database
            ├── Dockerfile      # MariaDB container build
            └── start.sh        # Database initialization script
```

## 🔧 Configuration

### Environment Variables
The project uses a `.env` file for configuration. Key variables include:

```bash
# Database Configuration
MYSQL_DATABASE=wordpress_db
MYSQL_USER=wp_user
MYSQL_PASSWORD=wp_password
MYSQL_HOST=mariadb

# WordPress Configuration  
DOMAIN_NAME=rmakoni.42.fr
WP_TITLE=My WordPress Site
WP_ADMIN=admin
WP_ADMIN_PASS=admin_password
WP_ADMIN_EMAIL=admin@example.com
```

### Domain Configuration
To access the site locally, the domain is automatically added to your `/etc/hosts` file:
```
127.0.0.1 rmakoni.42.fr www.rmakoni.42.fr
```

## 🛠️ Available Commands

| Command | Description |
|---------|-------------|
| `make` or `make up` | 🚀 Build and start all containers |
| `make down` | ⏹️ Stop all containers |
| `make clean` | 🧹 Stop and remove containers, volumes, and images |
| `make fclean` | 🧽 Complete cleanup |
| `make re` | 🔄 Restart everything (fclean + up) |
| `make ps` | 📊 Show container status |
| `make logs` | 📋 View all logs |
| `make logs-follow` | 👀 Follow logs in real time |
| `make help` | ❓ Show all available commands |

### Advanced Commands

```bash
# View logs for specific service
make logs-service SERVICE=mariadb

# Open shell in container
make shell SERVICE=wordpress

# Restart specific service
make restart SERVICE=nginx
```

## 🌐 Accessing Your Site

### Primary Access
- **HTTPS**: https://rmakoni.42.fr
- **HTTP**: http://rmakoni.42.fr (redirects to HTTPS)

### Alternative Access
- **Localhost HTTPS**: https://localhost
- **Localhost HTTP**: http://localhost

### Login Credentials
- **Username**: `admin`
- **Password**: `admin_password`
- **Email**: `admin@example.com`

## 🔍 Monitoring & Debugging

### Check Container Status
```bash
make ps
```

### View All Logs
```bash
make logs
```

### Follow Logs in Real Time
```bash
make logs-follow
```

### Access Container Shell
```bash
# Access WordPress container
make shell SERVICE=wordpress

# Access MariaDB container  
make shell SERVICE=mariadb

# Access NGINX container
make shell SERVICE=nginx
```

### Test Connectivity
```bash
# Test HTTPS endpoint
curl -k https://localhost -I

# Test HTTP endpoint
curl http://localhost -I
```

## 🧹 Cleanup

### Stop Containers
```bash
make down
```

### Remove Everything
```bash
make clean
```

### Complete Reset
```bash
make fclean
```

This will remove:
- All containers
- All volumes (including data)
- All custom images
- All networks
- Docker build cache

## ⚠️ Troubleshooting

### Common Issues

**🔴 Port Already in Use**
```bash
# Check what's using the ports
sudo netstat -tulpn | grep :443
sudo netstat -tulpn | grep :80

# Stop conflicting services
sudo systemctl stop apache2
sudo systemctl stop nginx
```

**🔴 Permission Denied**
```bash
# Ensure Docker is running
sudo systemctl start docker

# Add user to docker group
sudo usermod -aG docker $USER
# Logout and login again
```

**🔴 Database Connection Issues**
```bash
# Check MariaDB logs
make logs-service SERVICE=mariadb

# Restart MariaDB service
make restart SERVICE=mariadb
```

**🔴 SSL Certificate Warnings**
- This is normal for self-signed certificates
- Click "Advanced" → "Proceed to site" in your browser
- Or use `curl -k` to bypass SSL verification

### Container Won't Start

1. **Check logs**:
   ```bash
   make logs-service SERVICE=<service-name>
   ```

2. **Rebuild containers**:
   ```bash
   make clean
   make up
   ```

3. **Check disk space**:
   ```bash
   df -h
   docker system df
   ```

## 📚 Technical Details

### Docker Images
- **Base Images**: Debian Bullseye (stable, secure)
- **Custom Builds**: All containers built from Dockerfiles
- **No Pre-built Images**: Following 42 project requirements

### Security Features
- **HTTPS Only**: SSL/TLS encryption for all traffic
- **Network Isolation**: Services communicate on isolated Docker network
- **No Root Access**: Containers run with appropriate user privileges
- **Environment Variables**: Sensitive data stored in `.env` file

### Performance Optimizations
- **PHP-FPM**: Efficient PHP processing
- **NGINX**: High-performance web server
- **Volume Mounting**: Persistent data storage
- **Container Networking**: Optimized service communication

### 42 School Compliance
- ✅ Custom Dockerfiles for all services
- ✅ Docker Compose orchestration
- ✅ HTTPS with TLS
- ✅ No latest tags
- ✅ Proper volume management
- ✅ Environment variables usage
- ✅ Network isolation
- ✅ Makefile with standard targets

---

## 👨‍💻 Author

**rmakoni** - [rmakoni@student.42heilbronn.de](mailto:rmakoni@student.42heilbronn.de)

---

## 📄 License

This project is part of the 42 School curriculum.

---

## 🏆 Acknowledgments

- **42 School** for the project specifications
- **Docker Community** for excellent documentation
- **NGINX**, **WordPress**, and **MariaDB** teams for their robust software

---

**Happy Containerizing! 🐳**