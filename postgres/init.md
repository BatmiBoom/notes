# Postgres

PostgreSQL is a production-ready, open-source database. It's a great choice for many web applications, and as a back-end engineer.

## How Does PostgreSQL Work?

Postgres, is itself a server. It listens for requests on a port (Postgres' default is :5432), and responds to those requests. To interact with Postgres, first you will install the server and start it. Then, you can connect to it using a client like `psql` or `PGAdmin`.

### Install Postgres v15 or later.

- Mac with brew `brew install postgresql`
- Linux / WSL (Debian). `sudo apt install postgresql postgresql-contrib`

(Linux only) Update postgres password:
`sudo passwd postgres`

## Start the Postgres server in the background

- Mac: `brew services start postgresql`
- Linux: `sudo service postgresql start`

Connect to the server using `psql`

Mac: `psql postgres`
Linux: `sudo -u postgres psql`

You should see a new prompt that looks like this:

`postgres=#`

- Create a new database. `CREATE DATABASE database_name;`
- Connect to the new database: `\c gator`

You should see a new prompt that looks like this:

`gator=#`

Set the user password (Linux only)
`ALTER USER postgres PASSWORD 'postgres';`

I used postgres as the password. Before, we altered the system user's password, now we're altering the database user's password.

- Query the database

From here you can run SQL queries against the gator database. For example, to see the version of Postgres you're running, you can run:

`SELECT version();`

## Connection String

`protocol://username:password@host:port/database?sslmode=disable`
