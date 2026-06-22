# Apache Superset

This service provides a preconfigured Apache Superset instance with the DuckDB database driver installed and initialized with test data.

## Usage

```bash
docker compose --profile superset up -d
```

## Connections

- **Web UI**: [http://localhost:8088](http://localhost:8088)
- **Admin Username**: `${SUPERSET_ADMIN_USERNAME}` (default: `admin`)
- **Admin Password**: `${SUPERSET_ADMIN_PASSWORD}` (default: `admin`)

## Initialization

On startup, the Superset container:
1. Upgrades the metadata database and initializes Superset.
2. Creates the admin user using the configured username and password.
3. Installs the DuckDB CLI if not present:
   ```bash
   curl https://install.duckdb.org | sh
   ```
4. Initializes a local DuckDB file `/tmp/depot.db` using the schema/data in `./init_database.sql`:
   ```bash
   /app/superset_home/.duckdb/cli/latest/duckdb /tmp/depot.db
   ```
5. Registers the DuckDB database in Superset with the URI `duckdb:////tmp/depot.db`.
6. Starts the Superset application server on port `8088`.