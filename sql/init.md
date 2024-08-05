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
- groot

## LIMIT

The `LIMIT` keyword can be used at the end of a select statement to reduce the number of records returned.

```sql
SELECT * FROM products
    WHERE product_name LIKE '%berry%'
    LIMIT 50;
```

The query above retrieves all the records from the `products` table where the name contains the word `berry`. The `LIMIT` statement only allows the database to return _up_ to 50 records matching the query. This means that if there aren't that many records matching the query, the `LIMIT` statement will **not have an effect**.

## ORDER BY

The `ORDER BY` keyword by default sorts records by the given field in ascending order, or `ASC` for short. However, `ORDER BY` does support descending order as well with the keyword `DESC`.

### Examples

This query returns the `name`, `price`, and `quantity` fields from the `products` table sorted by `price` in _ascending_ order:

```sql
SELECT name, price, quantity FROM products
    ORDER BY price;
```

This query returns the `name`, `price`, and `quantity` of the products ordered by the quantity in _descending_ order:

```sql
SELECT name, price, quantity FROM products
    ORDER BY quantity DESC;
```

## ORDER BY AND LIMIT

When using both `ORDER BY` and `LIMIT`, the `ORDER BY` clause must come _first_.

## AGGREGATIONS

An "aggregation" is a _single_ value that's derived by combining _several_ other values. We performed an aggregation earlier when we used the `count` statement to count the number of records in a table

Data stored in a database should generally be stored `raw`. When we need to calculate some additional data from the raw data, we can use an _aggregation_.

Take the following `count` aggregation as an example:

```sql
SELECT COUNT(*)
    FROM products
    WHERE quantity = 0;
```

This query returns the number of products that have a `quantity` of `0`. We _could_ store a count of the products in a separate database table, and increment/decrement it whenever we make changes to the `products` table - but that would be _redundant_.

It's _much simpler_ to store the products in a single place ( we call this a single source of truth ) and run an aggregation when we need to derive additional information from the raw data.

## SUM

The `sum` aggregation functions returns the sum of a set of values.

For example, the query below returns a single record containing a single field. The returned value is equal to the _total_ salary being collected by all of the `employees` in the `employees` table.

```sql
SELECT sum(salary)
    FROM employees;
```

## MAX

The `max` function retrieves the _largest_ values from a set of values

```sql
SELECT max(price)
    FROM products;
```

## MIN

The `min` function retrieves the _lowest_ values from a set of values

```sql
SELECT product_name, min(price)
    FROM products;
```

## GROUP BY

`GROUP BY` clause which can group rows that have similar values into "summary" rows. It returns one row for each group. The interesting part is that each group can have an aggregate function applied to it that operates only on the grouped data.

EXAMPLE:

```sql
SELECT album_id, count(song_id)
    FROM songs
    GROUP BY album_id;
```

This query retrieves a count of all the songs on each album. One record is returned per album, and they each have their own `count`.

## AVERAGE

`avg` calculated the average of all non-NULL values.

```sql
SELECT avg(song_length)
    FROM songs;
```

This query returns the average `song_length` in the `songs` table

## HAVING

When we need to filter the results of a `GROUP BY` query even further, we can use the `HAVING` clause. The `HAVING` clause specifies a search condition for a group.

The `HAVING` clause is similar to the `WHERE` clause, but it operates on groups after they've been grouped, rather than rows _before_ they've been grouped.

```sql
SELECT album_id, count(id) as count
    FROM songs
    GROUP BY album_id
    HAVING count > 5;
```

This query returns the `album_id` and count of its songs, but only for albums with more than `5` songs.

### HAVING VS WHERE

The difference between this two statements:

- A `WHERE` condition is applied to _all_ the data in a query _before_ it's grouped by a `GROUP BY` clause.

- A `HAVING` condition is only applied to the _grouped rows_ that are returned _after_ a `GROUP BY` is applied

> If you want to filter based on the result of an aggregation, you need to use `HAVING`.
> If you want to filter on a value that's present in the raw data, you should use a simple `WHERE`.

## ROUND

Sometimes we need to round some numbers, particularly when working with the results of an aggregation. We can use the `ROUND()` function to get the job done.

The SQL `round()` function allows you to specify both the value you wish to round and the precision to which you wish to round it:

`round(value, precision)`

If no precision is given, SQL will round the value to the nearest whole value:

```sql
select song_name, round(avg(song_length), 1)
from songs
```

This query returns the average song_length from the songs table, rounded to a single decimal point.

## SUB QUERIES

It is possible to run a query on the result set of another query - a query within a query!

Subqueries can be very useful in a number of situations when trying to retrieve specific data that wouldn't be accessible by simply querying a single table.

**RETRIEVING DATA FROM MULTIPLE TABLES**

```sql
SELECT id, song_name, artist_id
FROM songs
WHERE artist_id IN (
    SELECT id
    FROM artists
    WHERE artist_name LIKE 'Rick%'
);
```

In this hypothetical database, the query above selects all of the `ids`, `song_names`, and `artist_ids` from the `songs` table that are written by artists whose name starts with "Rick". Notice that the subquery allows us to use information from a different table - in this case the `artists` table.

### SUBQUERY SYNTAX

The only syntax unique to a subquery is the parentheses surrounding the nested query. The `IN` operator could be different, for example, we could use the `=` operator if we expect a single value to be returned.

## NO TABLES

**SQL is a full programming language**

We usually use it to interact with data stored in tables, but it's quite flexible and powerful.

For example, you can `SELECT` information that's simply calculated, with no tables necessary.

`SELECT 5 + 10 as sum;`

## RELATIONSHIPS

### Table Relationships

Relational databases are powerful because of the relationships between the tables. These relationships help us to keep our databases clean and efficient. A relationship between tables assumes that one of these tables has a `foreign key` that references the `primary key` of another table.

### Types of Relationships

There are 3 primary types of relationships in a relational database:

- One-to-one
- One-to-many
- Many-to-many

### One-to-one

```
One to One
|--------|    |--------|
|        |<---|        |
|        |--->|        |
|________|    |--------|
```

A one-to-one relationship most often manifests as a field or set of fields on a row in a table. For example, a user will have exactly one password.

Settings fields might be another example of a one-to-one relationship. A user will have exactly one email_preference and exactly one birthday.

### One to many

```
One to Many
              |--------|
|--------|    |        |
|        |<---|________|
|        |
|________|<---|--------|
              |        |
              |________|
```

A one-to-many relationship occurs when a single record in one table is related to potentially many records in another table.

Note: The one->many relation only goes one way, a record in the second table can not be related to multiple records in the first table!

**Exp of one-to-many relationships**

- A `customers` table and an `orders` table. Each customer has `0`, `1`, or many orders that they've placed.
- A `users` table and a `transactions` table. Each `user` has `0`, `1`, or many transactions that they've taken part in.

### Many to many

```
Many to Many
|--------|     |--------|
|        |<-|--|        |
|        |--|->|        |
|________|  |  |--------|
            |
|--------|  |  |--------|
|        |<-|--|        |
|        |--|->|        |
|________|  |  |--------|
            |
|--------|  |  |--------|
|        |<-|--|        |
|        |--|->|        |
|________|     |--------|
```

A many-to-many relationship occurs when multiple records in one table can be related to multiple records in another table.

**Exp of many-to-many relationships**

- A `products` table and a `suppliers` table - Products may have `0` to many suppliers, and suppliers can supply `0` to many products.
- A `classes` table and a `students` table - Students can take potentially many classes and classes can have many students enrolled.

#### Joining table

Joining tables help define many-to-many relationships between data in a database. As an example when defining the relationship above between `products` and `suppliers`, we would define a joining table called `products_suppliers` that contains the primary keys from the tables to be joined.

Then, when we want to see if a supplier supplies a specific product, we can look in the joining table to see if the ids share a row.

#### Unique Constraint across 2 fields

When enforcing specific schema constraints we may need to enforce the UNIQUE constraint across two different fields.

```sql
CREATE TABLE product_suppliers (
  product_id INTEGER,
  supplier_id INTEGER,
  UNIQUE(product_id, supplier_id)
);
```

This ensures that we can have multiple rows with the same `product_id` or `supplier_id`, but we can't have two rows where both the `product_id` and `supplier_id` are the same.

## DATABASE NORMALIZATION

Database normalization is a method for structuring your database schema in a way that helps:

- Improve data integrity
- Reduce data redundancy

There are four tiers of database normalization. The different tiers have rules assigned to them, for example 1st NF ( First Normal Formal ) has two rules, and 2st NF has 1 additional rules + rules from 1st NF

- 1st NF:
  - Every row must have a unique primary key
  - There can be no nested tables
- 2st NF:
  - All columns that are not part of the primary key must only be dependent on the entire primary key
- 3rd NF:
  - All the columns not in the primary key are dependent ONLY on the primary key
- Boyce-Codd NF:
  - A column that IS part of the primary key may NOT be dependent on a column that is NOT part of the primary key

In the context of database normalization, we're going to use the term "primary key" slightly differently.

When we're talking more generally about data normalization, the term "primary key" means the collection of columns that uniquely identify a row. That can be a single column, but it can actually be any number of columns that form a composite key. A primary key is the minimum number of columns needed to uniquely identify a row in a table.

If you think back to the many-to-many joining table `product_suppliers`, that table's "primary key" was actually a combination of the 2 ids, `product_id` and `supplier_id`:

**What is data integrity?**

"Data integrity" refers to the accuracy and consistency of data. For example, if a user's age is stored in a database, rather than their birthday, that data becomes incorrect automatically with the passage of time.

It would be better to store a birthday and calculate the age as needed.

**What is data redundancy?**

"Data redundancy" occurs when the same piece of data is stored in multiple places. For example: saving the same file multiple times to different hard drives.

Data redundancy can be problematic, especially when data in one place is changed such that the data is no longer consistent across all copies of that data.

**Rules of thumb for database design**

- Every table should always have a unique identifier (primary key)
- 90% of the time, that unique identifier will be a single column named id
- Avoid duplicate data
- Avoid storing data that is completely dependent on other data. Instead, compute it on the fly when you need it.
- Keep your schema as simple as you can. Optimize for a normalized database first. Only denormalize for speed's sake when you start to run into performance problems.

## NAMESPACE ON TABLES

When working with multiple tables, you can specify which table a field exists on using a `.`. For example:

`table_name.column_name`

```sql
SELECT students.name, classes.name
FROM students
INNER JOIN classes on classes.class_id = students.class_id;
```

The above query returns the name field from the students table and the name field from the classes table.

### NAMESPACE ALIAS

A small trick you can do to make writing the SQL query easier is define an alias for each table. Here's an example:

```sql
SELECT e.name, d.name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.id;
```

Notice the simple alias declarations `e` and `d` for employees and departments respectively.

## JOINS

One of the most important features that SQL offers. Joins allow us to make use of the relationships we have set up between our tables.

### ON

In order to perform a join, we need to tell the database which fields should be "matched up". The `ON` clause is used to specify these columns to join.

### INNER JOINS

The simplest and most common type of join in SQL is the `INNER JOIN`. By default, a `JOIN` command is an `INNER JOIN`.

- `INNER JOIN` returns all of the records in `table_a` that have matching records in `table_b`

```sql
SELECT *
    FROM employees
    INNER JOIN departments
    ON employees.department_id = departments.id;
```

The query above returns all the fields from both tables. The INNER keyword doesn't have anything to do with the number of columns returned - it only affects the number of rows returned.

### LEFT JOIN

A `LEFT JOIN` will return every record from `table_a` regardless of whether or not any of those records have a match in `table_b`. A left join will also return any matching records from `table_b`

### RIGHT JOIN

A `RIGHT JOIN` is, as you may expect, the opposite of a `LEFT JOIN`. It returns all records from `table_b` regardless of matches, and all matching records between the two tables.

### FULL JOIN

A `FULL JOIN` combines the result set of the `LEFT JOIN` and `RIGHT JOIN` commands. It returns all records from both from `table_a` and `table_b` regardless of whether or not they have matches.

### MULTIPLE JOINS

To incorporate data from more than two tables, you can utilize multiple joins to execute more complex queries!

```sql
SELECT *
FROM employees
LEFT JOIN departments
ON employees.department_id = departments.id
INNER JOIN regions
ON departments.region_id = regions.id
```

## PERFORMANCE

### INDEXES

An index is an in-memory structure that ensures that queries we run on a database are performant, that is to say, they run quickly. Most database indexes are just binary trees or B-trees! The binary tree can be stored in ram as well as on disk, and it makes it easy to lookup the location of an entire row

`PRIMARY KEY` columns are indexed by default, ensuring you can look up a row by its `id` very quickly. However, if you have other columns that you want to be able to do quick lookups on, you'll need to index them.

### CREATE INDEX

`CREATE INDEX index_name on table_name (column_name);`

It's fairly common to name an index after the column it's created on with a suffix of `_idx`.

```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    email TEXT,
    name TEXT,
    age INTEGER
);

CREATE INDEX email_idx on users (email);
```

By indexing a column, we create a new in-memory structure, usually a binary-tree, where the values in the indexed column are sorted into the tree to keep lookups fast. In terms of Big-O complexity, a binary tree index ensures that lookups are `O(log(n))`.

While indexes make specific kinds of lookups much faster, they also add performance overhead - they can slow down a database in other ways. It also means that each time you insert a record, that record needs to be added to many trees - slowing down your insert speed.

> Add an index to columns you know you'll be doing frequent lookups on. Leave everything else un-indexed. You can always add indexes later.

### MULTI-COLUMN INDEXES

Are useful for the exact reason you might think - they speed up lookups that depend on multiple columns.

```sql
CREATE INDEX first_name_last_name_age_idx
ON users (first_name, last_name, age);
```

A multi-column index is sorted by the first column first, the second column next, and so forth. A lookup on only the first column in a multi-column index gets almost all of the performance improvements that it would get from its own single-column index. However, lookups on only the second or third column will have very degraded performance.

> Unless you have specific reasons to do something special, only add multi-column indexes if you're doing frequent lookups on a specific combination of columns.

### DENORMALIZING FOR SPEED

As it turns out, data integrity and deduplication come at a cost, and that cost is usually speed.

Joining tables together, using subqueries, performing aggregations, and running calculations take time.

Storing duplicate information can drastically speed up an application that needs to look it up in different ways.

> It should be used as a kind of "last resort" in the name of speed.

## SQL INJECTION

SQL is a very common way hackers attempt to cause damage or breach a database.

We have this query:

```sql
INSERT INTO students(name) VALUES (?);
```

And we receive the value from a `stdin`

`'Robert'); DROP TABLE students;--`

Then the resulting SQL query would look like this:

```sql
INSERT INTO students(name) VALUES ('Robert'); DROP TABLE students;--)
```

As you can see, this is actually 2 queries! The first one inserts "Robert" into the database, and the second one deletes the students table!

The solution is to sanitize SQL inputs.
