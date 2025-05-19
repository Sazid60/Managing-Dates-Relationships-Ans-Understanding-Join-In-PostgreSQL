-- Active: 1747459510114@@localhost@5432@ph

SHOW timezone

SELECT now();

CREATE TABLE timeZ (
    ts TIMESTAMP WITHOUT TIME ZONE,
    tsz TIMESTAMP WITH TIME ZONE
)

INSERT INTO
    timeZ
VALUES (
        '2024-01-12 10:45:00',
        '2024-01-12 10:45:00'
    )

SELECT * FROM timeZ

SELECT CURRENT_DATE

SELECT now()::date;

SELECT now()::time;

SELECT to_char(now(), 'yyyy/mm/dd');

SELECT to_char(now(), 'dd/yyyy/mm');

SELECT to_char(now(), 'month');

SELECT to_char(now(), 'dd');

SELECT CURRENT_DATE - INTERVAL '1 year';

SELECT CURRENT_DATE - INTERVAL '1 month';

SELECT CURRENT_DATE - INTERVAL '1 year 2 month';

SELECT age (CURRENT_DATE, '2005-02-20');

SELECT *, age (CURRENT_DATE, dob) FROM students;

SELECT extract( YEAR FROM '2025-01-25'::date );

SELECT extract( MONTH FROM '2025-01-25'::date );

SELECT extract( DAY FROM '2025-01-25'::date );

SELECT '0'::BOOLEAN

SELECT * FROM students GROUP BY country;

SELECT country FROM students GROUP BY country;

SELECT country, age FROM students GROUP BY country;

SELECT country, count(*) FROM students GROUP BY country;

SELECT country, count(*), avg(age) FROM students GROUP BY country;

SELECT country, avg(age)
FROM students
GROUP BY
    country
HAVING
    avg(age) > 22;

SELECT extract(
        YEAR
        FROM dob
    ) AS birth_year, count(*)
FROM students
GROUP BY
    birth_year;

-- retrieve all posts for user with id 4

CREATE TABLE "user" (
    id serial PRIMARY KEY,
    username VARCHAR(25) NOT NULL
)

CREATE TABLE post (
    id serial PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER REFERENCES "user" (id)
)