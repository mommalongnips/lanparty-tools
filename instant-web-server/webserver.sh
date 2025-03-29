#!/bin/bash

# Exit on error
set -e

# Environment variables
: "${WEBSERVER_DIR:?Environment variable WEBSERVER_DIR not set}"
: "${WEBSERVER_PORT:?Environment variable WEBSERVER_PORT not set}"

# Create directory structure
mkdir -p "$WEBSERVER_DIR/html"
mkdir -p "$WEBSERVER_DIR/conf"

# Create nginx.conf with directory browsing
cat > "$WEBSERVER_DIR/conf/nginx.conf" <<EOF
events {}

http {
    server {
        listen 80;
        location / {
            root /usr/share/nginx/html;
            autoindex on;
        }
    }
}
EOF

# Run nginx in Docker
docker run -d \
  --name nginx-dirbrowser \
  -p "${WEBSERVER_PORT}:80" \
  -v "$WEBSERVER_DIR/html:/usr/share/nginx/html:ro" \
  -v "$WEBSERVER_DIR/conf/nginx.conf:/etc/nginx/nginx.conf:ro" \
  nginx
