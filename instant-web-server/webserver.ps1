# Exit on error
$ErrorActionPreference = "Stop"

# Check environment variables
if (-not $env:WEBSERVER_DIR) {
    Write-Error "Environment variable WEBSERVER_DIR is not set"
    exit 1
}
if (-not $env:WEBSERVER_PORT) {
    Write-Error "Environment variable WEBSERVER_PORT is not set"
    exit 1
}

# Create directories
$confPath = Join-Path $env:WEBSERVER_DIR "conf"
$htmlPath = Join-Path $env:WEBSERVER_DIR "html"
New-Item -ItemType Directory -Force -Path $confPath | Out-Null
New-Item -ItemType Directory -Force -Path $htmlPath | Out-Null

# Write nginx.conf
@"
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
"@ | Set-Content -Path (Join-Path $confPath "nginx.conf") -Encoding UTF8

# Run Docker container
docker run -d `
  --name nginx-dirbrowser `
  -p "$env:WEBSERVER_PORT`:80" `
  -v "$htmlPath:/usr/share/nginx/html:ro" `
  -v "$confPath/nginx.conf:/etc/nginx/nginx.conf:ro" `
  nginx
