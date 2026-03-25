# DuckDB
 
 DuckDB is configured to work with the Garage S3 service to demonstrate cloud-native analytics.
 
 ## Usage
 
 ```bash
 docker compose --profile duckdb up -d
 ```
 
 ## Connections
 
 - **Web UI**: [http://localhost:4213](http://localhost:4213)
 - **Database File**: Located at `/data/duckdb.db` inside the container.
 
 ## Data Initialization
 
 On startup, DuckDB executes `init_duckdb.sql` which:
 1. Configures the S3 endpoint to point to the `garage` service.
 2. Loads credentials from environment variables.
 3. Creates a view or table pointing to the Simpsons/House Price parquet data in S3.
