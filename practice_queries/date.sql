-- Active: 1747459510114@@localhost@5432@ph

SHOW timezone

SELECT now();

CREATE TABLE timeZ(
    ts TIMESTAMP without time zone, 
    tsz TIMESTAMP with time zone
)

INSERT INTO timeZ VALUES('2024-01-12 10:45:00', '2024-01-12 10:45:00')


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


SELECT age(CURRENT_DATE,'1999-07-02');

SELECT * , age(CURRENT_DATE,dob) from students;

SELECT extract(year from '2025-01-25'::date);

SELECT extract(month from '2025-01-25'::date);
SELECT extract(day from '2025-01-25'::date);

SELECT '0' :: BOOLEAN