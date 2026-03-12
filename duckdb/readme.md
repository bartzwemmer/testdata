# DuckDB

## Start

```bash
docker compose --profile duckdb up
```

## Data

This will start a DuckDB instance, together with Garage as S3 storage and creates a table of the parquet file in Garage.

## UI

The DuckDB UI is available at http://localhost:4213. It is connected to the S3 Garage instance using the credentials in the .env file.

## Stop

```bash
docker compose --profile duckdb down
```
