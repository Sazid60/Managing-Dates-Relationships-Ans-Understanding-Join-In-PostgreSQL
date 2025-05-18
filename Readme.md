# Managing-Dates-Relationships-Ans-Understanding-Join-In-PostgreSQL

GitHub Link: https://github.com/Apollo-Level2-Web-Dev/dbms-postgres

## 9-1 Handling Date and Date Functions in PostgreSQL

#### `Timezone`

- we can see our timezone

```sql
SHOW timezone
```

#### `Timestamp`

- Timestamp means combination of date,time and time zone.

- timestamp is two type

  1. timestamp with timezone

  2. timestamp without timezone

```sql

  CREATE TABLE timeZ(
  ts TIMESTAMP without time zone,
  tsz TIMESTAMP with time zone
  )

  INSERT INTO timeZ VALUES('2024-01-12 10:45:00', '2024-01-12 10:45:00')

  SELECT * FROM timeZ
```

![alt text](image-1.png)

```sql
SELECT now();
```

![alt text](image.png)

- `SELECT now()` Gives us gives us timestamp with time zone.

- now we want to see just `date`

```sql
SELECT CURRENT_DATE
```

![alt text](image-2.png)

- we can also see just the date using `SELECT now()`

```sql
SELECT now()::date;
```

- this is called casting.
- we can also do the casting with time as well and just see the time

```sql
SELECT now()::time;
```

#### converting timestamp format using `to_char(timestamp,text)`

- This takes timestamp and converts to a required text mentioned

```sql
SELECT to_char(now(), 'yyyy/mm/dd')
```

```sql
SELECT to_char(now(), 'dd/yyyy/mm');
SELECT to_char(now(), 'month');
SELECT to_char(now(), 'dd');
```

https://www.postgresql.org/docs/current/functions-formatting.html

- we can format any type following the documentation

#### `Interval` with dates

- we want to see the date of last year from todays date

```sql
SELECT CURRENT_DATE - INTERVAL '1 year'
```

- we see 1 month previous date from todays date

```sql
SELECT CURRENT_DATE - INTERVAL '1 month'
```

- we can play more around

```sql
SELECT CURRENT_DATE - INTERVAL '1 year 2 month'
```

#### suppose we have date now we want to calculate the age using `age()`.

```sql
SELECT age(CURRENT_DATE,'1997-07-02')
```

- If we have date of birth we can easily find the age

```sql
SELECT * , age(CURRENT_DATE,dob) from students;
```

#### `Extract()` function usage

- using this we can extract month, day year etc from a date

```sql
SELECT extract(year from '2025-01-25'::date);
SELECT extract(month from '2025-01-25'::date);
SELECT extract(day from '2025-01-25'::date);
```

- ::date Convert the value on the left (in this case, the string '2025-01-25') into the date data type.

#### Lets discuss about `casting`

- sone using `::`

```sql
SELECT '0' :: BOOLEAN
```

- its similar like type casting like nwe are telling `0` will be boolean type. the casting must be logical.
