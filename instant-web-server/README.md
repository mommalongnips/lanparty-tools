# NGINX Directory Browsing Docker Setup

This project sets up an NGINX web server running in a local Docker container with directory browsing enabled by default.

## Requirements

- Docker installed
- `WEBSERVER_DIR` and `WEBSERVER_PORT` environment variables set

## Environment Variables

| Variable        | Description                       |
|----------------|-----------------------------------|
| `WEBSERVER_DIR` | Local path for config and HTML    |
| `WEBSERVER_PORT`| Port to expose the web server     |

## Example

```bash
export WEBSERVER_DIR=$HOME/my-nginx-server
export WEBSERVER_PORT=8080
./run_nginx.sh


```powershell
$env:WEBSERVER_DIR="$env:USERPROFILE\my-nginx-server"
$env:WEBSERVER_PORT="8080"
.\run_nginx.ps1

