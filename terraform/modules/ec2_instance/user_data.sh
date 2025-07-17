#!/bin/bash
yum update -y
yum install -y git

# Install Node.js and npm
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# Clone the application code from a public Git repository
# --- ACTION REQUIRED: Replace this URL with your repository's URL ---
git clone https://github.com/tech1savvy/aws.git /srv/key-sensei

# Navigate into the cloned repository
cd /srv/key-sensei

# Install npm dependencies
npm install

# Build the Vite application for production
npm run build

# Get EC2 Instance ID
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Replace placeholder in index.html with actual instance ID
sed -i "s/__INSTANCE_ID__/$INSTANCE_ID/g" /srv/key-sensei/dist/index.html

# Install Nginx
yum install -y nginx

# Configure Nginx to serve the Vite app
cat <<EOF > /etc/nginx/conf.d/vite-app.conf
server {
    listen 5173;
    server_name localhost;

    root /srv/key-sensei/dist;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF

# Start and enable Nginx service
systemctl start nginx
systemctl enable nginx