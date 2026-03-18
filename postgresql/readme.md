# PostgreSQL

This service provides a classic relational database experience with the [Pagila](https://github.com/devrimgunduz/pagila) and Simpsons datasets.

## Usage

```bash
docker compose --profile postgresql up -d
```

## Connections

- **Host**: `localhost`
- **Port**: `5432`
- **Database**: `${POSTGRES_DB}` (default: `postgres`)
- **User**: `${POSTGRES_USER}` (default: `postgres`)

## Initialization

Scripts in `./docker-entrypoint-initdb.d/` are executed in alphabetical order:

1.  `01-pagila-schema.sql`
2.  `02-pagila-data.sql`
3.  `01-simpsons-schema.sql`
4.  `02-simpsons-data.sql`
