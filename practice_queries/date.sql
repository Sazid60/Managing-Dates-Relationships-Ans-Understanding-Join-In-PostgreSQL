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

-- Insert users
INSERT INTO
    "user" (username)
VALUES ('alice'),
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

SELECT * FROM "user";

SELECT * FROM post;

ALTER TABLE post ALTER COLUMN user_id SET NOT NULL;

DELETE FROM "user" WHERE id = 4;

DROP TABLE post;

DROP TABLE "user";

CREATE TABLE "user" (
    id serial PRIMARY KEY,
    username VARCHAR(25) NOT NULL
)

CREATE TABLE post (
    id serial PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER REFERENCES "user" (id) ON DELETE CASCADE
)

INSERT INTO  "user" (username)
VALUES ('alice'),
    ('bob'),
    ('charlie'),
    ('diana');

INSERT INTO  "user" (username)
VALUES ('sazid');

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

DELETE FROM "user" WHERE id = 4;

SELECT * FROM post

SELECT * FROM "user"

CREATE TABLE post (
    id serial PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER REFERENCES "user" (id) ON DELETE SET NULL
)

CREATE TABLE post (
    id serial PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER REFERENCES "user" (id) ON DELETE SET DEFAULT DEFAULT 2
)

SELECT * FROM post

SELECT * FROM "user"

SELECT title, username FROM post;

SELECT title, username
FROM post
    JOIN "user" ON post.user_id = "user".id;

SELECT * FROM post 
JOIN "user" ON post.user_id = "user".id;

SELECT id FROM post 
JOIN "user" ON post.user_id = "user".id;

SELECT post.id FROM post 
JOIN "user" ON post.user_id = "user".id;

SELECT "user".id FROM post 
JOIN "user" ON post.user_id = "user".id;

SELECT p.id FROM post p 
JOIN "user" u ON p.user_id = u.id;

SELECT * FROM post p 
JOIN "user" u ON p.user_id = u.id;

SELECT * FROM post 
INNER JOIN "user" ON post.user_id = "user".id;

SELECT * FROM "user" 
INNER JOIN post ON post.user_id = "user".id;

SELECT * FROM post;

INSERT INTO post (title, user_id) 
VALUES ('Alice first post', NULL);

SELECT * FROM post 
INNER JOIN "user" ON post.user_id = "user".id;

SELECT * FROM post 
LEFT JOIN "user" ON post.user_id = "user".id;

SELECT * FROM post 
right JOIN "user" ON post.user_id = "user".id;

SELECT * FROM post 
LEFT OUTER JOIN "user" ON post.user_id = "user".id;

SELECT * FROM post 
right outer JOIN "user" ON post.user_id = "user".id;

SELECT * FROM post 
FULL OUTER JOIN "user" on post.user_id = "user".id