#!/bin/bash

# Task 2: Basic Firewall Configuration with UFW


echo "=========================================="
echo "UFW Basic Firewall Configuration Script"
echo "=========================================="

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)"
    exit 1
fi

# Function to display current UFW status. It will only work if UFW is installed.
display_status() {
    echo ""
    echo "Current UFW Status:"
    echo "==================="
    ufw status verbose
    echo ""
}

# Step 1: Install UFW (Ubuntu/Debian systems)
echo "Step 1: Installing UFW..."
if command -v apt-get &> /dev/null; then
    apt-get update
    apt-get install -y ufw
    echo "UFW installation completed."
elif command -v yum &> /dev/null; then
    yum install -y ufw
    echo "UFW installation completed."
elif command -v dnf &> /dev/null; then
    dnf install -y ufw
    echo "UFW installation completed."
else
    echo "Package manager not found. Please install UFW manually."
    exit 1
fi

echo ""
echo "Step 2: Configuring UFW default policies..."

# Reset UFW to default state (optional - removes all existing rules)
echo "Resetting UFW to default state..."
ufw --force reset

# Set default policies
echo "Setting default policies..."
ufw default deny incoming
ufw default allow outgoing

echo "Default policies set:"
echo "- Incoming: DENY"
echo "- Outgoing: ALLOW"

echo ""
echo "Step 3: Configuring specific rules..."

# Allow SSH (port 22) - IMPORTANT: Do this before enabling UFW
echo "Allowing SSH connections (port 22)..."
ufw allow ssh
# Alternative: ufw allow 22/tcp

# Deny HTTP traffic (port 80)
echo "Denying HTTP traffic (port 80)..."
ufw deny http
# Alternative: ufw deny 80/tcp

# Optional: Allow HTTPS (port 443) - commented out as per requirements
# echo "Allowing HTTPS connections (port 443)..."
# ufw allow https

echo ""
echo "Step 4: Enabling UFW..."
# Enable UFW
ufw --force enable

echo ""
echo "UFW has been enabled and configured successfully!"

# Display final status
display_status

echo "=========================================="
echo "Configuration Summary:"
echo "- UFW is now ACTIVE"
echo "- SSH (port 22): ALLOWED"
echo "- HTTP (port 80): DENIED"
echo "- Default incoming policy: DENY"
echo "- Default outgoing policy: ALLOW"
echo "=========================================="

echo ""
echo "Additional Commands for Management:"
echo "- View status: sudo ufw status"
echo "- View detailed status: sudo ufw status verbose"
echo "- View numbered rules: sudo ufw status numbered"
echo "- Disable UFW: sudo ufw disable"
echo "- Delete a rule: sudo ufw delete [rule_number]"
echo ""

echo "IMPORTANT SECURITY NOTES:"
echo "1. SSH access is allowed - ensure you have strong authentication"
echo "2. HTTP traffic is blocked as requested"
echo "3. Always test firewall rules carefully to avoid losing access"
echo "4. Consider allowing HTTPS (port 443) if needed: sudo ufw allow https"
echo ""

echo "Script execution completed successfully!"
