#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

echo "Starting user_data script execution..."

# Update system packages
echo "Updating system packages..."
yum update -y

# Install Git
echo "Installing Git..."
yum install -y git

# Clone the application code from a public Git repository
echo "Cloning application repository..."
git clone https://github.com/tech1savvy/aws.git /srv/key-sensei

# Navigate into the cloned repository
echo "Navigating to application directory..."
cd /srv/key-sensei

# Get EC2 Instance ID
echo "Fetching EC2 Instance ID..."
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
echo "Instance ID: $INSTANCE_ID"

# Replace placeholder in index.html with actual instance ID
echo "Replacing instance ID placeholder in index.html..."
sed -i "s/__INSTANCE_ID__/$INSTANCE_ID/g" /srv/key-sensei/index.html

# Install Nginx
echo "Installing Nginx..."
yum install -y nginx

# Configure Nginx to serve the app
echo "Configuring Nginx..."
cat <<EOF > /etc/nginx/conf.d/key-sensei.conf
server {
    listen 80;
    server_name localhost;

    root /srv/key-sensei;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
EOF

# Test Nginx configuration
echo "Testing Nginx configuration..."
nginx -t
if [ $? -ne 0 ]; then
  echo "Error: Nginx configuration test failed. Exiting."
  exit 1
fi
echo "Nginx configuration test successful."

# Set correct permissions for Nginx to serve files
echo "Setting file permissions for Nginx..."
chown -R nginx:nginx /srv/key-sensei
chmod -R 755 /srv/key-sensei

# Start and enable Nginx service
echo "Starting and enabling Nginx service..."
systemctl start nginx
systemctl enable nginx

# Check Nginx service status
echo "Checking Nginx service status..."
systemctl status nginx

echo "User_data script execution finished."