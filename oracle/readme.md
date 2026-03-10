# Oracle

Start the Oracle Free database with the HR schema installed.

```bash
docker compose --profile oracle up -d
```

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
