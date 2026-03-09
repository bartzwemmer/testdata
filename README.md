# testdata

A repo with dockerized test databases and datasets. Each database has its own docker compose profile to be able to start and stop the database independently.

## Garage

Start the Garage database:

```bash
docker compose --profile garage up -d
```

This will create a single node S3 instance, with 1 bucket and 1 file in that bucket.

## Postgresql

Start the Postgresql database:

```bash
docker compose --profile postgresql up -d
```

This will create a single node Postgresql instance, with 1 database and 1 table in that database you will find the [Pagila](https://github.com/devrimgunduz/pagila) dataset.

## Oracle

Start the Oracle Free database with the HR schema installed:

```bash
docker compose --profile oracle up -d
```

The source of the HR schema is located at https://github.com/oracle-samples/db-sample-schemas/tree/main/human_resources.

Connect to the database:

```bash
docker compose --profile oracle exec oracle sqlcl /nolog <<EOF
connect sys/\$ORACLE_PASSWORD@localhost:1521/pdb1 as sysdba
EOF
```

Host: localhost
Port: 1521
Service name: pdb1
Username: hr
Password: see your .env file

### Variables

| Variable        | Description               |
| --------------- | ------------------------- |
| ORACLE_PASSWORD | Password for the SYS user |
