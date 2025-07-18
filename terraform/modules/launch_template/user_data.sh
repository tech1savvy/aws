#!/bin/bash
# Install necessary packages
yum install -y git nginx

# Clone the repository into /app
git clone https://github.com/tech1savvy/aws.git /app

# Copy index.html to nginx web root
cp /app/index.html /usr/share/nginx/html/

# Start and enable nginx
systemctl start nginx
systemctl enable nginx