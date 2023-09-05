# Additional Notes

## Installing psql on windows

In a terminal, run:

```shell
choco install psql
```

## Drivers and ODBC

* [PostgreSQL ODBC driver](https://www.postgresql.org/ftp/odbc/versions/)
  * https://www.sqlshack.com/configure-odbc-drivers-for-postgresql/
  * https://www.migops.com/blog/powershell-with-odbc-to-interact-with-postgresql-linux-and-windows/
* PSQL Commands
  * https://hasura.io/blog/top-psql-commands-and-flags-you-need-to-know-postgresql/

## Commands

```shell
psql -h host -U username -d databasename -a -f sqlfile
psql -h host -U username -d databasename -W
```

## Docker

```shell
docker pull dpage/pgadmin4
docker run -p 9090:80 -e 'PGADMIN_DEFAULT_EMAIL=user@domain.com' -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret'  -d dpage/pgadmin4
```

[Back to README](README.md)