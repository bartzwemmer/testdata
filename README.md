# testdata

A repo with dockerized test databases and datasets. Each database has its own docker compose profile to be able to start and stop the database independently.

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
