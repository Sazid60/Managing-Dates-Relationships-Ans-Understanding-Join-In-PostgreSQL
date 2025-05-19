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

#### `age()` with dates

- suppose we have date now we want to calculate the age using `age()`.

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

## 9-2 Grouping and Filtering Data with GROUP BY and HAVING

#### `GROUP BY` Usage

- `aggregate` function is used basically with `group by` clause
- `group by` dose something like we have a lot of data and now we want to do grouping country wise. iF we want to do group by using blood group we can do this.

```sql
SELECT * FROM students
GROUP BY country;
```

![alt text](image-3.png)

- this is showing error because we are telling to show all the rows using `*`
- so the proper way of grouping is

```sql

SELECT country FROM students
GROUP BY country;
```

![alt text](image-5.png)

```sql
SELECT country,age FROM students
GROUP BY country;
```

![alt text](image-4.png)

- This also shows the error, since age must be in group by or we have to use aggregate function.
- this is happening age is not relevant to the country groups , does not understand whose age should be shown,

- if we want to see how many students are in each country we acn see that.

```sql
SELECT country, count(*) FROM students
GROUP BY country;
```

![alt text](image-6.png)

- here `count(*)` is acting differently. rather than counting all the students together its counting each grouped countries students and showing.

- this happening because group by works in split,apply and combine procedure when we use `aggregate ` function with `group by`.

![alt text](<WhatsApp Image 2025-05-19 at 11.30.56_fbaa4d2b.jpg>)

- now lets see country wise students average age with the country wise student count.

```sql
SELECT country, count(*), avg(age) from students
GROUP BY country;
```

![alt text](image-7.png)

#### `HAVING` Usage

- using `having` we can filter data made by `group by`
- lets think of like we have grouped using country and saw the average age based on the students of each country, now we want to set a condition like which group has average age greater than 22 show me. `filter groups using having to show only countries with average age above 22`

```sql
SELECT country, avg(age) FROM  students
GROUP BY country
HAVING avg(age) > 22;
```

- here `where` Condition will not workout since where works row by row.
- Lets solve this `Count Students Born In Each Year`

```sql
SELECT extract(year from dob) as birth_year, count(*)
FROM students
GROUP BY birth_year;
```

## 9-3 Constructing Relationships with Foreign Key Constraints

- `Foreign Key` Is Important to make relationship between different tables.

![alt text](<WhatsApp Image 2025-05-19 at 12.03.06_8d7c16a8.jpg>)

- `primary key` is used to identifying a data uniquely
- `Foreign Key` also uniquely identify a row uniquely but other table from where it came.

![alt text](<WhatsApp Image 2025-05-19 at 12.18.00_b2981c21.jpg>)

- we are defining `user_id INTEGER REFERENCES user(id)`.

- now tels do something like `retrieve all posts for user with id 4`

```sql
SELECT * FROM Post
where user_id = 4;
```

- this is ok but we want to see the `title` of post table and the `username` which is in user table.

- lets create the tables

```sql
CREATE TABLE "user" (
    id serial PRIMARY KEY,
    username VARCHAR(25) NOT NULL
)

CREATE TABLE post (
    id serial PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER REFERENCES "user" (id) NOT Null
)

```

## 9-4 Enforcing Referential Integrity: Behaviors During Data Insertion

- lets see the data we have inserted

```sql

-- Insert users
INSERT INTO "user" (username) VALUES
('alice'),
('bob'),
('charlie'),
('diana');

-- Insert posts
INSERT INTO
    post (title, user_id)
VALUES ('Alice first post', 1),
    ('Bob travel blog', 2),
    ('Charlie on coding', 3),
    ('Alice second post', 1),
    ('Diana book review', 4),
    (
        'Another tech tip from Bob',
        2
    );

SELECT * from "user";
SELECT * from post;
```

- during the insert of data who has dependency with foreign key, we have to make sure that the foreign key should exist in where it is coming from. I we do not do there will be no data integrity. validation is done so this will show error.

#### During the insertion there can be many cases.

1. attempting to insert a post with a user id that does not exist. this will show error of foreign key violation

```sql
INSERT INTO post (title, user_id) VALUES
('Alice  first post', 100)
```

2. Inserting a post with a valid user id

```sql
INSERT INTO post (title, user_id) VALUES
('Alice  first post', 1)
```

3. Attempting to insert a post without specifying a user id.

```sql
INSERT INTO post (title, user_id) VALUES
('Alice  first post', null)
```

- this is not a good thing, we have to prevent this using constrain `not null`

```sql
ALTER table post
alter column user_id set NOT Null;
```

#### Lets See the behavior while deleting foreign key related table.

- suppose we want to delete the user but the post is having the deleted users user id. this is happening data inconsistency and data integrity is not maintained.
- these default behavior we can control if we want. like if we delete a user the post of the user will be also deleted. or we can say something like if the user is deleted the post's user id will become null. or we can do something like if user is deleted we can set default value to the post user_id. or we can say something like the posts should be deleted before the deletion of the user.

## 9-5 Enforcing Referential Integrity: Behaviors During Data Deletion

#### Behaviors During Data Deletion

1. Cascading deletion --> `ON DELETE CASCADE` : When user is deleted delete the user posts as well.

```sql
CREATE TABLE post (
    id serial PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER REFERENCES "user" (id) ON DELETE CASCADE
)
```

2. Setting Null --> `ON DELETE SET NULL` : When user is deleted SET THE POSTS USER_ID `NULL`

```sql
CREATE TABLE post (
    id serial PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER REFERENCES "user" (id) ON DELETE SET NULL
)
```

3. Restrict Deletion --> `ON DELETE RESTRICT` / `ON DELETE NO ACTION` (default) : After the deletion of the posts of the user, then user will be deletable. basically we will not do it.

```sql
DELETE from "user"
WHERE id = 4;
```

```sql
CREATE TABLE post (
    id serial PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER REFERENCES "user" (id) ON DELETE RESTRICT
)
```

1. set Default Value --> `ON DELETE SET DEFAULT` : Will set a default value in the user_id of the post which user has been deleted. this is not also practical.

```sql
CREATE TABLE post (
    id serial PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER REFERENCES "user"(id) ON DELETE SET DEFAULT  DEFAULT 2
)
```

## 9-6 Joining Tables with Inner Join

![alt text](<WhatsApp Image 2025-05-19 at 14.57.22_f38e5ee3.jpg>)

#### Now lets retrieve all posts title with their user name using `Join`.

```sql
SELECT title, username FROM post;
```

- we can not do this since post table is not holding the username data, its just holding users foreign keys.

- the post table do not con tain `username` as well user table do not contain the `title`
- we can see both using `Join`. we can Do joining using foreign key.

```sql
SELECT title, username FROM post
JOIN "user" ON post.user_id = "user".id
```

- because of doing joining user and post(primary table) table has been combined.
- first keeps the primary table values
- then according to the primary tables user id finds the username and keep beside the user id of the primary table
- finally gives us what we need.

![alt text](<WhatsApp Image 2025-05-19 at 15.20.36_3cb376b4.jpg>)

![alt text](<WhatsApp Image 2025-05-19 at 15.23.38_8a3ef4da.jpg>)

![alt text](<WhatsApp Image 2025-05-19 at 15.24.16_4b009f95.jpg>)

![alt text](<WhatsApp Image 2025-05-19 at 15.24.53_ae5cd64c.jpg>)

#### I we want to see all the data with the user name

```sql
SELECT * from post
JOIN "user" ON post.user_id = "user".id
```

#### lets learn about context

- After doing join we have got a combined table. here we have 2 `id`. id of user and if of post.
- if we want to see the id this will show us error saying `column reference "id" is ambiguous`.

```sql
SELECT id FROM post
JOIN "user" ON post.user_id = "user".id
```

![alt text](image-8.png)

- we have to manage it by providing `context` that the which tables id should he show.

```sql
SELECT post.id FROM post JOIN "user" ON post.user_id = "user".id;
SELECT "user".id FROM post JOIN "user" ON post.user_id = "user".id;
```

- we are setting context that whose id it will be.
- where the table names are lengthy we can do aliasing.

```sql
SELECT p.id FROM post p
JOIN "user" u ON p.user_id = u.id;

-- we will use as as well.
SELECT * FROM post as p
JOIN "user" as u ON p.user_id = u.id;
```

- the `title` and `username` showing is said `inner join`

![alt text](<WhatsApp Image 2025-05-19 at 15.44.48_423d32c8.jpg>)

- whatever we have done we can say `INNER JOIN` Instead Of `JOIN`

```sql
SELECT id FROM post
INNER JOIN "user" ON post.user_id = "user".id
```

## 9-7 Understanding Left and Right Joins

```sql
SELECT * FROM post
INNER JOIN "user" ON post.user_id = "user".id;
```

![alt text](image-9.png)

```sql
SELECT * FROM "user"
INNER JOIN post ON post.user_id = "user".id;
```

![alt text](image-10.png)

- here swapping the place of post and user is not impacting just changing the table column position.
- This order do not matter now but when the order will be an issue and then based on the situation two type of joining is required

  1. Left Join
  2. Right Join

- suppose we want to add a post whose user_id will be `null` the order will be issue then.

```sql
INSERT INTO post (title, user_id) VALUES ('Alice first post', NULL);
```

![alt text](image-11.png)

```sql
SELECT * FROM post INNER JOIN "user" ON post.user_id = "user".id;
```

![alt text](image-12.png)

- we can see twh post whose user_id was `null` is not coming after doing the `inner join`.

##### so why this is happening?

- In the combined table while doing the inner join there only the values kept which matches the condition is given `post.user_id = "user".id`.
- In case of `null` user_id it could not match with any id of the `user` table so it did not sow in the combined table.
- same goes to id who have not posted their name is not kept.
- Basically it filter outs the things those do not met the condition

![alt text](<WhatsApp Image 2025-05-19 at 16.37.40_40790be3.jpg>)

#### `LEFT JOIN` Usage

- suppose we want the thing like even if the user_id is `null` we want to see the post
- this might happen when its not a post of a user its the post of a company.
- In this situation we have to use `LEFT JOIN`

![alt text](<WhatsApp Image 2025-05-19 at 16.41.41_8bc208ca.jpg>)

- so what is left table? the table we have wrote first. marked in teh picture.
  ![alt text](image-13.png)

- while doing the `LEFT JOIN` we have to keep all the data of left table.
- As its a combined table then it will fill the not found columns with `NULL`

![alt text](<WhatsApp Image 2025-05-19 at 16.45.22_20a45243.jpg>)

```sql
SELECT * FROM post
LEFT JOIN "user" ON post.user_id = "user".id;
```

![alt text](image-14.png)

#### `RIGHT JOIN` Usage

![alt text](<WhatsApp Image 2025-05-19 at 16.51.44_d28705fa.jpg>)

- In case of Right join Right table will get priority.
- All data of right table will be kept, which data is not found in left table will be ste null.

![alt text](<WhatsApp Image 2025-05-19 at 16.54.01_6c884696.jpg>)

![alt text](<WhatsApp Image 2025-05-19 at 16.54.20_5d1895ce.jpg>)

```sql
SELECT * FROM post
right JOIN "user" ON post.user_id = "user".id;
```

![alt text](image-15.png)

- In case of `LEFT JOIN` and `RIGHT JOIN` Order matters.
- we can tell `LEFT JOIN` and `RIGHT JOIN` like `LEFT OUTER JOIN` and `RIGHT OUTER JOIN`. both are same

```sql
SELECT * FROM post
LEFT OUTER JOIN "user" ON post.user_id = "user".id;

SELECT * FROM post
right outer JOIN "user" ON post.user_id = "user".id;
```
