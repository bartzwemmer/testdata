# Postgresql

This will create a single node Postgresql instance, with 1 database and 1 table in that database you will find the [Pagila](https://github.com/devrimgunduz/pagila) dataset.

Scripts in `/docker-entrypoint-initdb.d/` are executed in alphabetical order when the container starts and the database is initialized.
