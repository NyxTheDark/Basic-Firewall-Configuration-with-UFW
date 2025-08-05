# UFW Basic Firewall Configuration

## Task 2: Basic Firewall Configuration with UFW

### Overview
This project demonstrates the setup and configuration of UFW (Uncomplicated Firewall) on a Linux system. UFW is a user-friendly front-end for managing iptables firewall rules.

### Objective
Set up a basic firewall using UFW with the following requirements:
- Allow SSH traffic (port 22)
- Deny HTTP traffic (port 80)
- Verify firewall status and rules

### Files Included
- `ufw_configuration.sh` - Main configuration script
- `README.md` - This documentation file

## Prerequisites

### System Requirements
- Linux system (Ubuntu, Debian, CentOS, etc.)
- Root or sudo access
- Internet connection for package installation

### Supported Distributions
- Ubuntu 18.04+
- Debian 9+
- CentOS 7+
- RHEL 7+
- Fedora 25+

## Installation and Usage

### Method 1: Using the Automated Script

1. **Download the script:**
   ```bash
   wget https://raw.githubusercontent.com/yourusername/firewall-config/main/ufw_configuration.sh
   # OR
   curl -O https://raw.githubusercontent.com/yourusername/firewall-config/main/ufw_configuration.sh
   ```

2. **Make the script executable:**
   ```bash
   chmod +x ufw_configuration.sh
   ```

3. **Run the script with sudo:**
   ```bash
   sudo ./ufw_configuration.sh
   ```

### Method 2: Manual Configuration

If you prefer to configure UFW manually, follow these steps:

1. **Install UFW:**
   ```bash
   # Ubuntu/Debian
   sudo apt update
   sudo apt install ufw
   
   # CentOS/RHEL
   sudo yum install ufw
   # OR for newer versions
   sudo dnf install ufw
   ```

2. **Set default policies:**
   ```bash
   sudo ufw default deny incoming
   sudo ufw default allow outgoing
   ```

3. **Configure specific rules:**
   ```bash
   # Allow SSH (IMPORTANT: Do this before enabling UFW)
   sudo ufw allow ssh
   # OR
   sudo ufw allow 22/tcp
   
   # Deny HTTP traffic
   sudo ufw deny http
   # OR
   sudo ufw deny 80/tcp
   ```

4. **Enable UFW:**
   ```bash
   sudo ufw enable
   ```

5. **Check status:**
   ```bash
   sudo ufw status verbose
   ```

## Expected Output

After running the configuration, you should see output similar to:

```
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere
80/tcp                     DENY IN     Anywhere
22/tcp (v6)                ALLOW IN    Anywhere (v6)
80/tcp (v6)                DENY IN     Anywhere (v6)
```

## Verification Commands

### Check UFW Status
```bash
# Basic status
sudo ufw status

# Detailed status
sudo ufw status verbose

# Numbered rules (useful for deletion)
sudo ufw status numbered
```

### Test Connectivity
```bash
# Test SSH connectivity (should work)
ssh username@your-server-ip

# Test HTTP connectivity (should be blocked)
curl -I http://your-server-ip
# This should fail or timeout
```

## Common UFW Commands

### Rule Management
```bash
# Allow a specific port
sudo ufw allow 443/tcp

# Deny a specific port
sudo ufw deny 21/ftp

# Allow from specific IP
sudo ufw allow from 192.168.1.100

# Allow specific IP to specific port
sudo ufw allow from 192.168.1.100 to any port 22

# Delete a rule by number
sudo ufw delete 2

# Delete a rule by specification
sudo ufw delete allow 80/tcp
```

### UFW Management
```bash
# Enable UFW
sudo ufw enable

# Disable UFW
sudo ufw disable

# Reset UFW (removes all rules)
sudo ufw reset

# Reload UFW
sudo ufw reload
```

## Security Best Practices

1. **Always allow SSH before enabling UFW** to avoid losing remote access
2. **Use strong SSH authentication** (key-based authentication recommended)
3. **Regularly review firewall rules** with `sudo ufw status`
4. **Test rules in a safe environment** before applying to production
5. **Keep logs enabled** for monitoring: `sudo ufw logging on`
6. **Consider rate limiting** for SSH: `sudo ufw limit ssh`

## Troubleshooting

### Common Issues

1. **Locked out via SSH:**
   - Access the system via console/KVM
   - Run: `sudo ufw disable`
   - Reconfigure rules properly

2. **UFW not starting:**
   - Check if UFW service is enabled: `systemctl status ufw`
   - Enable if needed: `sudo systemctl enable ufw`

3. **Rules not working:**
   - Verify rule syntax: `sudo ufw status numbered`
   - Check for conflicting rules
   - Reload UFW: `sudo ufw reload`

### Log Files
```bash
# View UFW logs
sudo tail -f /var/log/ufw.log

# View system logs for firewall events
sudo journalctl -u ufw
```

## Advanced Configuration

### Application Profiles
UFW includes predefined application profiles:

```bash
# List available profiles
sudo ufw app list

# Get info about a profile
sudo ufw app info 'Apache Full'

# Allow an application profile
sudo ufw allow 'Apache Full'
```

### IPv6 Support
UFW supports IPv6 by default. To disable IPv6:

```bash
# Edit UFW configuration
sudo nano /etc/default/ufw

# Set IPV6=no
IPV6=no

# Restart UFW
sudo ufw disable
sudo ufw enable
```

## Testing and Validation

### Automated Testing Script
```bash
#!/bin/bash
echo "Testing UFW configuration..."

# Test SSH port (should be open)
if nc -z localhost 22; then
    echo "✓ SSH port 22 is accessible"
else
    echo "✗ SSH port 22 is not accessible"
fi

# Test HTTP port (should be blocked)
if timeout 5 nc -z localhost 80; then
    echo "✗ HTTP port 80 is accessible (should be blocked)"
else
    echo "✓ HTTP port 80 is properly blocked"
fi

echo "UFW Status:"
sudo ufw status
```

## Screenshots

To capture the UFW status screenshot as required:

```bash
# Capture UFW status to a file
sudo ufw status verbose > ufw_status_output.txt

# Or take a screenshot using gnome-screenshot (GUI)
gnome-screenshot -w

# Or using scrot (command line)
scrot ufw_status_screenshot.png
```

## GitHub Repository Structure

```
firewall-configuration/
├── README.md
├── ufw_configuration.sh
├── screenshots/
│   └── ufw_status_active_rules.png
├── tests/
│   └── test_ufw_config.sh
└── docs/
    └── advanced_configuration.md
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions:
- Create an issue in the GitHub repository
- Check the troubleshooting section above
- Consult the official UFW documentation

---

**Created by:** RUDRA  
**Date:** August 4, 2025  
**Version:** 1.0
