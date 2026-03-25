# Garage
 
 Garage is an open-source distributed S3-compatible object store.
 
 ## Usage
 
 ```bash
 docker compose --profile garage up -d
 ```
 
 ## Technical Overview
 
 This configuration starts a 1-node cluster. An initialization script runs automatically to create the necessary buckets and upload sample data.
 
 ## Ports
 
 | Port | Description |
 | :--- | :--- |
 | **3900** | S3 API Endpoint |
 | **3902** | Web Server |
 | **3903** | Admin API |
 | **3909** | **Web UI** ([http://localhost:3909](http://localhost:3909)) |
 
 ## Admin Web UI
 
 The Web UI is pre-configured to connect to the Admin API. Use the credentials defined in your `.env` file for S3 access.
