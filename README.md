# Task 2: Basic Firewall Configuration with UFW

This project demonstrate how to set up UFW "Uncomplicated Firewall" on your linux device.
Firewall are used to filter out the network traffic to ensure protection against the DOS, DDOS or anyb other network based attack, it also bee used to restrict the access of ntwork to specific network or entire subnet. 

### Objective
Set up a basic firewall using UFW with the following requirements:
- Allow SSH traffic (port 22)
- Deny HTTP traffic (port 80)
- Verification firewall status and rules

### Files Included
- `ufw_configuration.sh` - Configuration script
- `README.md` - This documentation file

## Prerequisites

### System Requirements
- Linux system (Ubuntu, Debian, CentOS, etc.)
- Root or sudo access
- Internet connection for package installation

## Installation and Usage

### Method 1: Using the Automated Script

1. **Download the script:**
```bash
   wget https://raw.githubusercontent.com/NyxTheDark/firewall-config/main/ufw_configuration.sh
   # OR
   curl -O https://raw.githubusercontent.com/NyxTheDark/firewall-config/main/ufw_configuration.sh
```
or 
```bash
git clone https://github.com/NyxTheDark/Basic-Firewall-Configuration-with-UFW.git
```
#### NOTE: mak sure to opn the folder wher you have your script in command prompt

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

2. **Set default policies:** [If needed only then.]
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

### to get help menu use
```bash
ufw --help
```
and for manual use
```bash
man ufw
```

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

### Log Files
```bash
# View UFW logs
sudo tail -f /var/log/ufw.log

# View system logs for firewall events
sudo journalctl -u ufw
```
## Screenshots

Are included for refrence purpose.
