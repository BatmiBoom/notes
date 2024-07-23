# SQL

Structured Query Language, or SQL, is the primary programming language used to manage and interact with relational databases. SQL can perform various operations such as creating, updating, reading, and deleting records within a database.

## Which databases use SQL?

SQL is just a query language. You typically use it to interact with a specific database technology. For example:

- SQLite
- PostgreSQL
- MySQL
- CockroachDB
- Oracle
- etc...

Although many different databases use the SQL language, most of them will have their own dialect. It's critical to understand that not all databases are created equal. Just because one SQL-compatible database does things a certain way, doesn't mean every SQL-compatible database will follow those exact same patterns.

We are using `SQLite`

`SQLite` is great for embedded projects, web browsers, and toy projects. It's lightweight, but has limited functionality compared to the likes of `PostgreSQL` or `MySQL` - two of the more common production SQL technologies.

### NOSQL VS SQL

When talking about SQL databases, we also have to mention the elephant in the room: NoSQL.

To put it simply, a NoSQL database is a database that does not use SQL (Structured Query Language). Each NoSQL typically has its own way of writing and executing queries. For example, MongoDB uses MQL (MongoDB Query Language) and ElasticSearch simply has a JSON API.

While most relational databases are fairly similar, NoSQL databases tend to be fairly unique and are used for more niche purposes. Some of the main differences between a SQL and NoSQL databases are:

1. NoSQL databases are usually non-relational, SQL databases are usually relational (we'll talk more about what this means later).
2. SQL databases usually have a defined schema, NoSQL databases usually have dynamic schema.
3. SQL databases are table-based, NoSQL databases have a variety of different storage methods, such as document, key-value, graph, wide-column, and more.

### TYPES OF NOSQL DATABASES

- Document Database
- Key-Value Store
- Wide-Column
- Graph

A few of the most popular NoSQL databases are:

- MongoDB
- Cassandra
- CouchDB
- DynamoDB
- ElasticSearch

### COMPARING SQL DATABASES

#### SQLITE VS POSTGRESQL

Personally, SQLite and PostgreSQL are my favorites from the list above. Postgres is a very powerful, open-source, production-ready SQL database. SQLite is a lightweight, embeddable, open-source database. I usually choose one of these technologies if I'm doing SQL work.

SQLite is a serverless database management system (DBMS) that has the ability to run within applications, whereas PostgreSQL uses a Client-Server model and requires a server to be installed and listening on a network, similar to an HTTP server.

## CREATE TABLE

To create a table, use the `CREATE TABLE` statement followed by the name of the table and the fields you want in the table

`CREATE TABLE <tablename> (<fieldname> <fieldtype>, <fieldname> <fieldtype>, ...);`

Each field name is followed by its _datatype_.

Example:

```sql
CREATE TABLE people (
    id INTEGER,
    handle TEXT,
    name TEXT,
    age INTEGER,
    balance INTEGER,
    is_admin BOOLEAN
);
```

## ALTER TABLE

We can use the `ALTER TABLE` statement to make changes in place without deleting any data.

1. RENAME A TABLE OR COLUMN

   ```sql
   ALTER TABLE employees RENAME TO contractors;

   ALTER TABLE contractors RENAME COLUMN salary to invoice;
   ```

2. ADD OR DROP A COLUMN

   ```sql
   ALTER TABLE contractors ADD COLUMN job_title TEXT;

   ALTER TABLE contractors DROP COLUMN is_manager;
   ```

## INSERT INTO

A `INSERT INTO` statement is the operation to insert a single row in a table. This is the syntax

`INSERT into <tablename> (<fieldname>, <fieldname>, ...) values (<value>, <value>, ...);`

Example:

```sql
INSERT INTO employees(
    id,
    name,
    title
)
VALUES (
    1,
    'Allan',
    'Engineer'
);
```

## SELECT

A `SELECT` statement is the most common operation in SQL - often called a "query". `SELECT` retrieves data from one or more tables. Standard `SELECT` statements do _not_ alter the sate of the database.

`SELECT id from users;`

### Single field

A `SELECT` statement begins with the keyword `SELECT` followed by the fields you want to retrieve.

`SELECT id from users;`

### Multiple fields

If you want to select more than one field you can specify multiple fields separated by commas

`SELECT id, name from users;`

### All fields

If you want to select every field in a record you can use the shorthand `*` syntax.

`SELECT * from users;`

After specifying fields, you need to indicate which table you want to pull the records from using the `from` statement followed by the name of the table.

_ALL_ statements end with a semi-colon `;`.

## MIGRATIONS

A database migration is a set of changes to a relational database. In fact, the `ALTER TABLE` statements are examples of migrations!

Migrations are helpful when transitioning from one state to another, fixing mistakes, or adapting a database to changes.

Good migrations are _small_, _incremental_ and _reversible_ changes to a database.

When writing reversible migrations, we use the terms `up` and `down` migrations. An `up` migration is simply the set of changes you want to make, like altering/removing/adding/editing a table in some way. A `down` migration includes the changes that would revert any of the `up` migration's changes.

## SQL DATA TYPES

SQL as a language can support many different `datatypes`. However, the `datatypes` that your database management system (DBMS) supports will vary depending on the specific database you're using.

### POSTGRESQL Data types

| Name                                    | Aliases            |
| --------------------------------------- | ------------------ |
| bigint                                  | int8               |
| bigserial                               | serial8            |
| bit [ (n) ]                             |                    |
| bit varying [ (n) ]                     | varbit [ (n) ]     |
| boolean                                 | bool               |
| box                                     |                    |
| bytea                                   |                    |
| character [ (n) ]                       | char [ (n) ]       |
| character varying [ (n) ]               | varchar [ (n) ]    |
| cidr                                    |                    |
| circle                                  |                    |
| date                                    |                    |
| double precision                        | float8             |
| inet                                    |                    |
| integer                                 | int, int4          |
| interval [ fields ] [ (p) ]             |                    |
| json                                    |                    |
| jsonb                                   |                    |
| line                                    |                    |
| lseg                                    |                    |
| macaddr                                 |                    |
| macaddr8                                |                    |
| money                                   |                    |
| numeric [ (p, s) ]                      | decimal [ (p, s) ] |
| path                                    |                    |
| pg_lsn                                  |                    |
| pg_snapshot                             |                    |
| point                                   |                    |
| polygon                                 |                    |
| real                                    | float4             |
| smallint                                | int2               |
| smallserial                             | serial2            |
| serial                                  | serial4            |
| text                                    |                    |
| time [ (p) ] [ without time zone ]      |                    |
| time [ (p) ] with time zone             | timetz             |
| timestamp [ (p) ] [ without time zone ] |                    |
| timestamp [ (p) ] with time zone        | timestamptz        |
| tsquery                                 |                    |
| tsvector                                |                    |
| txid_snapshot                           |                    |
| uuid                                    |                    |
| xml                                     |                    |

### SQLite Data types

| Name    | Description                                                          |
| ------- | -------------------------------------------------------------------- |
| NULL    | Null value.                                                          |
| INTEGER | A signed integer stored in 0,1,2,3,4,6, or 8 bytes.                  |
| REAL    | Floating point value stored as an 64-bit IEEE floating point number. |
| TEXT    | Text string stored using database encoding such as UTF-8             |
| BLOB    | Short for Binary large object and typically used for multimedia.     |
| BOOLEAN | Values are written in as true or false, but are stored as 1 or 0.    |

## NULL Values

In SQL, a cell with `NULL` value indicates that the value is _missing_. A `NULL` value is _very_ different from a _zero_ value.

## Constraints

When creating a table we can define whether or not a field _can_ or _cannot_ be `NULL`, and that's a kind of **Constraint**

A **Constraint** is a rule we create on a database that _enforces_ some specific behavior. For example, setting a `NOT NULL` constraint on a column **ensures** that the column will not accept `NULL` values.

The **Constraints** are:

- `NOT NULL` - Ensures that a column cannot have a NULL value
- `UNIQUE` - Ensures that all values in a column are different
- `PRIMARY KEY` - Uniquely identifies each row in a table (NOT NULL AND UNIQUE sort of)
- `FOREIGN KEY` - Prevents actions that would destroy links between tables
- `CHECK` - Ensures that the values in a column satisfies a specific condition
- `DEFAULT` - Sets a default value for a column if no value is specified
- `CREATE INDEX` - Used to create and retrieve data from the database very quickly

```sql
CREATE TABLE employees(
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE,
    title TEXT NOT NULL
);
```

We can do it also on `ALTER TABLE` but not all DB supports this, for example `SQLite` doesn't support this.

A **KEY** defines and protects relationships between tables.

- `PRIMARY KEY` is a special column that uniquely identifies records within a table. Each table can have one, and only one primary key.

- `FOREIGN KEY` define the relationships _between_ tables. A `FOREIGN KEY` is a field in one table that references another table's `PRIMARY KEY`.

  For example:

  ```sql
  CREATE TABLE departments (
      id INTEGER PRIMARY KEY,
      department_name TEXT NOT NULL
  );

  CREATE TABLE employees (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      department_id INTEGER,
      CONSTRAINT fk_departments
      FOREIGN KEY (department_id)
      REFERENCES departments(id)
  );
  ```

  In this example, an `employee` has a `department_id`. The `department_id` must be the same as the `id` field of a record from the departments table. `fk_departments` is the specified name of the `constraint`.

## AUTO INCREMENT

Many dialects of SQL support an `AUTO INCREMENT` feature. When inserting records into a table with `AUTO INCREMENT` enabled, the database will assign the next value automatically. In _SQLITE_ an `integer` `id` field that has the `PRIMARY KEY` constraint will auto increment by default!

## SCHEMA

Data types, table names, field names, constraints, and the relationships between all of those entities are part of a database's _schema_.

## CRUD

CRUD is an acronym that stands for `CREATE`, `READ`, `UPDATE` and `DELETE`.

### CRUD - HTTP - SQL

The CRUD operations correlate with the HTTP methods and SQL methods.

- CREATE - `POST` - `INSERT`
- READ - `GET` - `SELECT`
- UPDATE - `PUT` - `UPDATE`
- DELETE - `DELETE` - `DELETE FROM`

### HTTP CRUD DATABASE LIFECICLY

```
Front end           Banck end Server          Database

|--------|             |--------|          |------------|
|        |    HTTP     |        |   SQL    |____________|
| device | --------->  |        | -------> |------------|
|        | <---------  |        | <------- |____________|
|        |             |        |          |------------|
|________|             |________|          |____________|
```

1. The front-end processes some data from user input - maybe a form is submitted.
2. The front-end sends that data to the server through an HTTP request - maybe a POST.
3. The server makes a SQL query to its database to create an associated record - Probably using an INSERT statement.
4. Once the server has processed that the database query was successful, it responds to the front-end with a status code! Hopefully a 200-level code (success)!

## COUNT

We can use a `SELECT` statement to get a `COUNT` of the records within a table.

```sql
SELECT COUNT(*) FROM employees;
```

## WHERE

SQL accepts a `WHERE` statement within a query that allows us to be very specific with our instructions.

### USING A WHERE CLAUSE

```sql
SELECT name FROM users WHERE power_level >= 9000;
```

This will select only the name field of any user within the users table WHERE the power_level field is greater than or equal to 9000.

### Filtering by `NULL` Values

```sql
SELECT name FROM users WHERE first_name IS NULL;
SELECT name FROM users WHERE first_name IS NOT NULL;
```

## DELETE

A `DELETE` statement removes all records from a table that match the `WHERE` clause.

As an example:

```sql
DELETE from employees
    WHERE id = 251;
```

This `DELETE` statement removes all records from the employees table that have an id of 251!

Deleting data can be a dangerous operation. Once removed, data can be really hard if not impossible to restore!.

### STRATEGY 1 - BACKUPS

If you're using a cloud-service like GCP's Cloud SQL or AWS's RDS you should always turn on automated backups. They take an automatic snapshot of your entire database on some interval, and keep it around for some length of time.

You should have a backup strategy for production databases.

### STRATEGY 2 - SOFT DELETES

A "soft delete" is when you don't actually delete data from your database, but instead just "mark" the data as deleted. For example, you might set a deleted_at date on the row you want to delete. Then, in your queries you ignore anything that has a deleted_at date set. The idea is that this allows your application to behave as if it's deleting data, but you can always go back and restore any data that's been removed.

You should probably only soft-delete if you have a specific reason to do so. Automated backups should be "good enough" for most applications that are just interested in protecting against developer mistakes.

## UPDATE

The `UPDATE` statement in SQL allows us to update the fields of a record. We can even update many records depending on how we write the statement.

An `UPDATE` statement specifies the table that needs to be updated, followed by the fields and their new values by using the `SET` keyword. Lastly a `WHERE` clause indicates the record(s) to update.

```sql
UPDATE employees
SET job_title = 'Backend Engineer', salary = 150000
WHERE id = 251;
```

## OBJECT-RELATIONAL MAPPING ( _ORM_ )

An Object-Relational Mapping or an _ORM_ for short, is a tool that allows you to perform _CRUD_ operations on a database using a traditional programming language. These typically come in the form of a library or framework that you would use in your back-end code.

The primary benefit an _ORM_ provides is that it maps your database records to in-memory objects.

For example, in Go we might have a `struct` that we use in our code:

```go

type User struct {
    ID int
    Name string
    IsAdmin bool
}
```

This `struct` definition conveniently represents a database table called users, and an instance of the `struct` represents a row in the table.

### EXAMPLE: USING AN ORM

Using an ORM we might be able to write simple code like this:

```go
user := User{
    ID: 10,
    Name: "Lane",
    IsAdmin: false,
}

// generates a SQL statement and runs it,
// creating a new record in the users table
db.Create(user)
```

### EXAMPLE: USING STRAIGHT SQL

Using straight SQL we might have to do something a bit more manual:

```go
user := User{
    ID: 10,
    Name: "Lane",
    IsAdmin: false,
}

db.Exec("INSERT INTO users (id, name, is_admin) VALUES (?, ?, ?);",
    user.ID, user.Name, user.IsAdmin)
```

## AS Clause

Sometimes we need to structure the data we return from our queries in a specific way. An `AS` clause allows us to "alias" a piece of data in our query. The alias only exists for the duration of the query.

The following queries return the same data

```sql
SELECT employee_id AS id, employee_name AS name
FROM employees;

SELECT employee_id, employee_name
FROM employees;
```

The difference is that the results from the aliased query would have column names `id` and `name` instead of `employee_id` and `employee_name`.

## SQL Functions

We can use functions and aliases to _calculate_ new columns in a query. Similar to how we use formulas in Excel.

### `IIF` Function

Works like a ternary

```go
IIF(carA > carB, "Car a is bigger", "Car b is bigger")
```

If `a` is greater than `b`, this statement evaluates to the string "Car a is bigger". Otherwise, it evaluates to "Car b is bigger".

Here's how we can use `IIF()` and a `directive` alias to add a new calculated column to our result set:

```sql
SELECT quantity,
    IIF(quantity < 10, "Order more", "In Stock") AS directive
    from products
```

## BETWEEN

We can check if values are between two numbers using the `WHERE` clause in an intuitive way! The `WHERE` clause doesn't always have to be used to specify specific id's or values. We can also use it to help narrow down our result set. Here's an example:

```sql
SELECT employee_name, salary
FROM employees
WHERE salary BETWEEN 30000 and 60000;

SELECT product_name, quantity
FROM products
WHERE quantity NOT BETWEEN 20 and 100;
```

## DISTINCT

Retrieve records from a table without getting back any duplicates.

### SELECT DISTINCT

SQL offers us the `DISTINCT` keyword that removes duplicate records from the resulting query.

```sql
SELECT DISTINCT previous_company
    FROM employees;
```

## Logical Operators

### AND

The logical AND operator can be used to narrow down our result sets even more!

```sql
SELECT product_name, quantity, shipment_status
    FROM products
    WHERE shipment_status = 'pending'
    AND quantity BETWEEN 0 and 10;
```

This only retrieves records where both the shipment_status is "pending" AND the quantity is between 0 and 10.

### OR

```sql
SELECT product_name, quantity, shipment_status
    FROM products
    WHERE shipment_status = 'out of stock'
    OR quantity BETWEEN 10 and 100;
```

This query retrieves records where either the shipment_status condition OR the quantity condition are met.

### Order of operations

You can group logical operations with parentheses to specify the order of operations.

```sql
(this AND that) OR the_other
```

### Equality operators

All of the followig operators are supported in SQL

- =
- <
- >
- <=
- > =

## IN

The `IN` operator is a shorthand for multiple `OR` conditions.

These two queries are equivalent:

```sql
SELECT product_name, shipment_status
    FROM products
    WHERE shipment_status IN ('shipped', 'preparing', 'out of stock');

SELECT product_name, shipment_status
    FROM products
    WHERE shipment_status = 'shipped'
        OR shipment_status = 'preparing'
        OR shipment_status = 'out of stock';
```

## LIKE

The `LIKE` keyword allows for the use of the `%` and `_` wild-card operators.

### & Operator

The `%` operator will match zero or more characters. We can use this operator within our query string to find more than just exact matches depending on where we place it.

**PRODUCT STARTS WITH "BANANA"**

```sql
SELECT * FROM products
WHERE product_name LIKE 'banana%';
```

**PRODUCT ENDS WITH "BANANA"**

```sql
SELECT * FROM products
WHERE product_name LIKE '%banana';
```

**PRODUCT CONTAINS "BANANA"**

```sql
SELECT * FROM products
WHERE product_name LIKE '%banana%';
```

### `_` Operator

The `_` operator only matches a single character.

```sql
SELECT * FROM products
    WHERE product_name LIKE '_oot';
```

The query above matches products like:

- boot
- root
- foot

```sql
SELECT * FROM products
    WHERE product_name LIKE '__oot';
```

The query above matches products like:

- shoot
- groo
