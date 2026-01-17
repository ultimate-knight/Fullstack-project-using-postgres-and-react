postgres=# CREATE TABLE fitness (
    id INT PRIMARY KEY,
    exercise_name VARCHAR(50),
    reps INT NOT NULL,
    sets INT NOT NULL,
    date_added DATE,
    created_at TIMESTAMP
);
CREATE TABLE
postgres=# \d fitness
                            Table "public.fitness"
    Column     |            Type             | Collation | Nullable | Default
---------------+-----------------------------+-----------+----------+---------
 id            | integer                     |           | not null |
 exercise_name | character varying(50)       |           |          |
 reps          | integer                     |           | not null |
 sets          | integer                     |           | not null |
 date_added    | date                        |           |          |
 created_at    | timestamp without time zone |           |          |
Indexes:
    "fitness_pkey" PRIMARY KEY, btree (id)

postgres=# insert into fitness values(1,jumping jacks,2,4)
postgres-# insert into fitness values(1,jumping jacks,2,4);
ERROR:  syntax error at or near "jacks"
LINE 1: insert into fitness values(1,jumping jacks,2,4)
                                             ^
postgres=# insert into fitness values(1,jumping_jacks,2,4)
postgres-# insert into fitness values(1,jumping_jacks,2,4);
ERROR:  syntax error at or near "insert"
LINE 2: insert into fitness values(1,jumping_jacks,2,4);
        ^
postgres=#  insert into fitness values(1,"jumping_jacks",2,4,"24-03-2025",CURRENT_TIMESTAMP);
ERROR:  column "jumping_jacks" does not exist
LINE 1: insert into fitness values(1,"jumping_jacks",2,4,"24-03-2025...
                                     ^
postgres=# INSERT INTO fitness
VALUES (1, 'jumping_jacks', 2, 4, '2025-03-24', CURRENT_TIMESTAMP);
INSERT 0 1
postgres=# \d fitness
                            Table "public.fitness"
    Column     |            Type             | Collation | Nullable | Default
---------------+-----------------------------+-----------+----------+---------
 id            | integer                     |           | not null |
 exercise_name | character varying(50)       |           |          |
 reps          | integer                     |           | not null |
 sets          | integer                     |           | not null |
 date_added    | date                        |           |          |
 created_at    | timestamp without time zone |           |          |
Indexes:
    "fitness_pkey" PRIMARY KEY, btree (id)

postgres=# SELECT * from fitness;
 id | exercise_name | reps | sets | date_added |        created_at
----+---------------+------+------+------------+---------------------------
  1 | jumping_jacks |    2 |    4 | 2025-03-24 | 2026-01-14 21:12:16.56463
(1 row)

postgres=# INSERT INTO fitness(2, "chest press", 7, 5, "2025-08-30", CURRENT_TIMESTAMP);
ERROR:  syntax error at or near "2"
LINE 1: INSERT INTO fitness(2, "chest press", 7, 5, "2025-08-30", CU...
                            ^
postgres=# INSERT INTO fitness VALUES(2, "chest press", 7, 5, "2025-08-30", CURRENT_TIMESTAMP);
ERROR:  column "chest press" does not exist
LINE 1: INSERT INTO fitness VALUES(2, "chest press", 7, 5, "2025-08-...
                                      ^
postgres=# INSERT INTO fitness VALUES(2, 'chest press', 7, 5, '2025-08-30', CURRENT_TIMESTAMP);
INSERT 0 1
postgres=# SELECT * FROM fitness;
 id | exercise_name | reps | sets | date_added |         created_at
----+---------------+------+------+------------+----------------------------
  1 | jumping_jacks |    2 |    4 | 2025-03-24 | 2026-01-14 21:12:16.56463
  2 | chest press   |    7 |    5 | 2025-08-30 | 2026-01-14 21:18:04.406366
(2 rows)

postgres=# select reps from fitness;
 reps
------
    2
    7
(2 rows)

postgres=# select sets from fitness
postgres-# select sets from fitness;
ERROR:  syntax error at or near "select"
LINE 2: select sets from fitness;
        ^
postgres=# select exercise_name from fitness;
 exercise_name
---------------
 jumping_jacks
 chest press
(2 rows)

postgres=# select date_added from fitness;
 date_added
------------
 2025-03-24
 2025-08-30
(2 rows)

postgres=# select created_at from fitness;
         created_at
----------------------------
 2026-01-14 21:12:16.56463
 2026-01-14 21:18:04.406366
(2 rows)

postgres=# select id from fitness;
 id
----
  1
  2
(2 rows)

postgres=# select reps from fitness;
 reps
------
    2
    7
(2 rows)

postgres=# insert into fitness values(3,'bench press',56,45,'2025-06-08',current_timestamp);
INSERT 0 1
postgres=# select * from fitness;
 id | exercise_name | reps | sets | date_added |         created_at
----+---------------+------+------+------------+----------------------------
  1 | jumping_jacks |    2 |    4 | 2025-03-24 | 2026-01-14 21:12:16.56463
  2 | chest press   |    7 |    5 | 2025-08-30 | 2026-01-14 21:18:04.406366
  3 | bench press   |   56 |   45 | 2025-06-08 | 2026-01-14 21:23:17.414929
(3 rows)

postgres=# /d fitness;
ERROR:  syntax error at or near "/"
LINE 1: /d fitness;
        ^
postgres=# \d fitness;
                            Table "public.fitness"
    Column     |            Type             | Collation | Nullable | Default
---------------+-----------------------------+-----------+----------+---------
 id            | integer                     |           | not null |
 exercise_name | character varying(50)       |           |          |
 reps          | integer                     |           | not null |
 sets          | integer                     |           | not null |
 date_added    | date                        |           |          |
 created_at    | timestamp without time zone |           |          |
Indexes:
    "fitness_pkey" PRIMARY KEY, btree (id)

postgres=# update fitness exercise_name='lat press' where exercise_name='jumping_jacks';
ERROR:  syntax error at or near "="
LINE 1: update fitness exercise_name='lat press' where exercise_name...
                                    ^
postgres=# update fitness set  exercise_name='lat press' where exercise_name='jumping_jacks';
UPDATE 1
postgres=# select * from fitness;
 id | exercise_name | reps | sets | date_added |         created_at
----+---------------+------+------+------------+----------------------------
  2 | chest press   |    7 |    5 | 2025-08-30 | 2026-01-14 21:18:04.406366
  3 | bench press   |   56 |   45 | 2025-06-08 | 2026-01-14 21:23:17.414929
  1 | lat press     |    2 |    4 | 2025-03-24 | 2026-01-14 21:12:16.56463
(3 rows)

postgres=# update fitness set reps=90 where reps=56;
UPDATE 1
postgres=# select * from fitness;
 id | exercise_name | reps | sets | date_added |         created_at
----+---------------+------+------+------------+----------------------------
  2 | chest press   |    7 |    5 | 2025-08-30 | 2026-01-14 21:18:04.406366
  1 | lat press     |    2 |    4 | 2025-03-24 | 2026-01-14 21:12:16.56463
  3 | bench press   |   90 |   45 | 2025-06-08 | 2026-01-14 21:23:17.414929
(3 rows)

postgres=# insert into fitness values(4,'dumbbell_workout',23,45,'2025-09-23',current_timestamp);
INSERT 0 1
postgres=# select * from fitness;
 id |  exercise_name   | reps | sets | date_added |         created_at
----+------------------+------+------+------------+----------------------------
  2 | chest press      |    7 |    5 | 2025-08-30 | 2026-01-14 21:18:04.406366
  1 | lat press        |    2 |    4 | 2025-03-24 | 2026-01-14 21:12:16.56463
  3 | bench press      |   90 |   45 | 2025-06-08 | 2026-01-14 21:23:17.414929
  4 | dumbbell_workout |   23 |   45 | 2025-09-23 | 2026-01-14 21:27:27.245746
(4 rows)

postgres=# update fitness set exercise_name='weightlifting' where exercise_name='lat press';
UPDATE 1
postgres=# select * from fitness;
 id |  exercise_name   | reps | sets | date_added |         created_at
----+------------------+------+------+------------+----------------------------
  2 | chest press      |    7 |    5 | 2025-08-30 | 2026-01-14 21:18:04.406366
  3 | bench press      |   90 |   45 | 2025-06-08 | 2026-01-14 21:23:17.414929
  4 | dumbbell_workout |   23 |   45 | 2025-09-23 | 2026-01-14 21:27:27.245746
  1 | weightlifting    |    2 |    4 | 2025-03-24 | 2026-01-14 21:12:16.56463
(4 rows)

postgres=# alter table fitness drop column reps;
ALTER TABLE
postgres=# select * from fitness;
 id |  exercise_name   | sets | date_added |         created_at
----+------------------+------+------------+----------------------------
  2 | chest press      |    5 | 2025-08-30 | 2026-01-14 21:18:04.406366
  3 | bench press      |   45 | 2025-06-08 | 2026-01-14 21:23:17.414929
  4 | dumbbell_workout |   45 | 2025-09-23 | 2026-01-14 21:27:27.245746
  1 | weightlifting    |    4 | 2025-03-24 | 2026-01-14 21:12:16.56463
(4 rows)

postgres=# alter table fitness drop column created_at;
ALTER TABLE
postgres=# select * from fitness;
 id |  exercise_name   | sets | date_added
----+------------------+------+------------
  2 | chest press      |    5 | 2025-08-30
  3 | bench press      |   45 | 2025-06-08
  4 | dumbbell_workout |   45 | 2025-09-23
  1 | weightlifting    |    4 | 2025-03-24
(4 rows)

postgres=# alter table fitness add column created_at timestamp;
ALTER TABLE
postgres=# select * from fitness;
 id |  exercise_name   | sets | date_added | created_at
----+------------------+------+------------+------------
  2 | chest press      |    5 | 2025-08-30 |
  3 | bench press      |   45 | 2025-06-08 |
  4 | dumbbell_workout |   45 | 2025-09-23 |
  1 | weightlifting    |    4 | 2025-03-24 |
(4 rows)

postgres=# insert into fitness(5,'treadmill',34,56,'2025-06-07',current_timestamp);
ERROR:  syntax error at or near "5"
LINE 1: insert into fitness(5,'treadmill',34,56,'2025-06-07',current...
                            ^
postgres=# insert into fitness values(5,'treadmill',34,56,'2025-06-07',current_timestamp);
ERROR:  INSERT has more expressions than target columns
LINE 1: ...o fitness values(5,'treadmill',34,56,'2025-06-07',current_ti...
                                                             ^
postgres=# insert into fitness values(5,'treadmill',34,'2025-06-07',current_timestamp);
INSERT 0 1
postgres=# select * from fitness;
 id |  exercise_name   | sets | date_added |         created_at
----+------------------+------+------------+----------------------------
  2 | chest press      |    5 | 2025-08-30 |
  3 | bench press      |   45 | 2025-06-08 |
  4 | dumbbell_workout |   45 | 2025-09-23 |
  1 | weightlifting    |    4 | 2025-03-24 |
  5 | treadmill        |   34 | 2025-06-07 | 2026-01-14 21:32:01.397684
(5 rows)

postgres=# alter table fitness rename table fitness_tracker;
ERROR:  syntax error at or near "table"
LINE 1: alter table fitness rename table fitness_tracker;
                                   ^
postgres=# alter table fitness rename to fitness_tracker;
ALTER TABLE
postgres=# select * from fitness;
ERROR:  relation "fitness" does not exist
LINE 1: select * from fitness;
                      ^
postgres=# select * from fitness_tracker;
 id |  exercise_name   | sets | date_added |         created_at
----+------------------+------+------------+----------------------------
  2 | chest press      |    5 | 2025-08-30 |
  3 | bench press      |   45 | 2025-06-08 |
  4 | dumbbell_workout |   45 | 2025-09-23 |
  1 | weightlifting    |    4 | 2025-03-24 |
  5 | treadmill        |   34 | 2025-06-07 | 2026-01-14 21:32:01.397684
(5 rows)

postgres=# select * from fitness where sets>10;
ERROR:  relation "fitness" does not exist
LINE 1: select * from fitness where sets>10;
                      ^
postgres=# select * from fitness_tracker where sets>10;
 id |  exercise_name   | sets | date_added |         created_at
----+------------------+------+------------+----------------------------
  3 | bench press      |   45 | 2025-06-08 |
  4 | dumbbell_workout |   45 | 2025-09-23 |
  5 | treadmill        |   34 | 2025-06-07 | 2026-01-14 21:32:01.397684
(3 rows)

postgres=# select max(sets) from fitness_tracker;
 max
-----
  45
(1 row)

postgres=# select avg(sets) from fitness_tracker;
         avg
---------------------
 26.6000000000000000
(1 row)

postgres=# select count(sets) from fitness_tracker;
 count
-------
     5
(1 row)

postgres=# alter table fitness_tracker add column reps;
ERROR:  syntax error at or near ";"
LINE 1: alter table fitness_tracker add column reps;
                                                   ^
postgres=# alter table fitness_tracker add column reps int not null;
ERROR:  column "reps" of relation "fitness_tracker" contains null values
postgres=# alter table fitness_tracker add column reps int;
ALTER TABLE
postgres=# select * from fitness_tracker;
 id |  exercise_name   | sets | date_added |         created_at         | reps
----+------------------+------+------------+----------------------------+------
  2 | chest press      |    5 | 2025-08-30 |                            |
  3 | bench press      |   45 | 2025-06-08 |                            |
  4 | dumbbell_workout |   45 | 2025-09-23 |                            |
  1 | weightlifting    |    4 | 2025-03-24 |                            |
  5 | treadmill        |   34 | 2025-06-07 | 2026-01-14 21:32:01.397684 |
(5 rows)

postgres=# insert into table fitness_tracker values(7,'barbell_press',34,'2023-09-28',current_timestamp,56);
ERROR:  syntax error at or near "table"
LINE 1: insert into table fitness_tracker values(7,'barbell_press',3...
                    ^
postgres=# insert into  fitness_tracker values(7,'barbell_press',34,'2023-09-28',current_timestamp,56);
INSERT 0 1
postgres=# select * from fitness_tracker;
 id |  exercise_name   | sets | date_added |         created_at         | reps
----+------------------+------+------------+----------------------------+------
  2 | chest press      |    5 | 2025-08-30 |                            |
  3 | bench press      |   45 | 2025-06-08 |                            |
  4 | dumbbell_workout |   45 | 2025-09-23 |                            |
  1 | weightlifting    |    4 | 2025-03-24 |                            |
  5 | treadmill        |   34 | 2025-06-07 | 2026-01-14 21:32:01.397684 |
  7 | barbell_press    |   34 | 2023-09-28 | 2026-01-14 21:53:06.717294 |   56
(6 rows)

postgres=# select count(sets) from fitness_tracker;
 count
-------
     6
(1 row)

postgres=# select count(id) from fitness_tracker;
 count
-------
     6
(1 row)

postgres=# select sets from fitness_tracker where sets>15;
 sets
------
   45
   45
   34
   34
(4 rows)

postgres=# select sets from fitness_tracker where exercise_name='chest press';
 sets
------
    5
(1 row)

postgres=# select * from fitness_tracker where exercise_name='chest press';
 id | exercise_name | sets | date_added | created_at | reps
----+---------------+------+------------+------------+------
  2 | chest press   |    5 | 2025-08-30 |            |
(1 row)

postgres=# alter table fitness_tracker change id serial int primary key;
ERROR:  syntax error at or near "change"
LINE 1: alter table fitness_tracker change id serial int primary key...
                                    ^
postgres=# alter table fitness_tracker change id serial int;
ERROR:  syntax error at or near "change"
LINE 1: alter table fitness_tracker change id serial int;
                                    ^
postgres=# alter table fitness_tracker change sets set int not null;
ERROR:  syntax error at or near "change"
LINE 1: alter table fitness_tracker change sets set int not null;
                                    ^
postgres=# alter table fitness_tracker alter column sets set int not null;
ERROR:  syntax error at or near "int"
LINE 1: alter table fitness_tracker alter column sets set int not nu...
                                                          ^
postgres=# ALTER TABLE fitness_tracker
ALTER COLUMN sets SET NOT NULL;
ALTER TABLE
postgres=# select * from fitness_tracker;
 id |  exercise_name   | sets | date_added |         created_at         | reps
----+------------------+------+------------+----------------------------+------
  2 | chest press      |    5 | 2025-08-30 |                            |
  3 | bench press      |   45 | 2025-06-08 |                            |
  4 | dumbbell_workout |   45 | 2025-09-23 |                            |
  1 | weightlifting    |    4 | 2025-03-24 |                            |
  5 | treadmill        |   34 | 2025-06-07 | 2026-01-14 21:32:01.397684 |
  7 | barbell_press    |   34 | 2023-09-28 | 2026-01-14 21:53:06.717294 |   56
(6 rows)

postgres=# alter table fitness_tracker alter column reps rep int not null;
ERROR:  syntax error at or near "rep"
LINE 1: alter table fitness_tracker alter column reps rep int not nu...
                                                      ^
postgres=# alter table fitness_tracker alter column reps rep not null;
ERROR:  syntax error at or near "rep"
LINE 1: alter table fitness_tracker alter column reps rep not null;
                                                      ^
postgres=# alter table fitness_tracker rename column reps to rep;
ALTER TABLE
postgres=# select * from fitness_tracker;
 id |  exercise_name   | sets | date_added |         created_at         | rep
----+------------------+------+------------+----------------------------+-----
  2 | chest press      |    5 | 2025-08-30 |                            |
  3 | bench press      |   45 | 2025-06-08 |                            |
  4 | dumbbell_workout |   45 | 2025-09-23 |                            |
  1 | weightlifting    |    4 | 2025-03-24 |                            |
  5 | treadmill        |   34 | 2025-06-07 | 2026-01-14 21:32:01.397684 |
  7 | barbell_press    |   34 | 2023-09-28 | 2026-01-14 21:53:06.717294 |  56
(6 rows)

postgres=# alter table fitness_tracker add column weight int not null;
ERROR:  column "weight" of relation "fitness_tracker" contains null values
postgres=# alter table fitness_tracker add column weight int;
ALTER TABLE
postgres=# select * from fitness_tracker;
 id |  exercise_name   | sets | date_added |         created_at         | rep | weight
----+------------------+------+------------+----------------------------+-----+--------
  2 | chest press      |    5 | 2025-08-30 |                            |     |
  3 | bench press      |   45 | 2025-06-08 |                            |     |
  4 | dumbbell_workout |   45 | 2025-09-23 |                            |     |
  1 | weightlifting    |    4 | 2025-03-24 |                            |     |
  5 | treadmill        |   34 | 2025-06-07 | 2026-01-14 21:32:01.397684 |     |
  7 | barbell_press    |   34 | 2023-09-28 | 2026-01-14 21:53:06.717294 |  56 |
(6 rows)

postgres=# alter table fitness_tracker add column notes varchar(200);
ALTER TABLE
postgres=# select * from fitness_tracker;
 id |  exercise_name   | sets | date_added |         created_at         | rep | weight | notes
----+------------------+------+------------+----------------------------+-----+--------+-------
  2 | chest press      |    5 | 2025-08-30 |                            |     |        |
  3 | bench press      |   45 | 2025-06-08 |                            |     |        |
  4 | dumbbell_workout |   45 | 2025-09-23 |                            |     |        |
  1 | weightlifting    |    4 | 2025-03-24 |                            |     |        |
  5 | treadmill        |   34 | 2025-06-07 | 2026-01-14 21:32:01.397684 |     |        |
  7 | barbell_press    |   34 | 2023-09-28 | 2026-01-14 21:53:06.717294 |  56 |        |
(6 rows)

postgres=# insert into fitness_tracker values(9,'pullups',34,'2025-09-30',current_timestamp,89,78,'do with full intensity');
INSERT 0 1
postgres=# select * from fitness_tracker;
 id |  exercise_name   | sets | date_added |         created_at         | rep | weight |         notes
----+------------------+------+------------+----------------------------+-----+--------+------------------------
  2 | chest press      |    5 | 2025-08-30 |                            |     |        |
  3 | bench press      |   45 | 2025-06-08 |                            |     |        |
  4 | dumbbell_workout |   45 | 2025-09-23 |                            |     |        |
  1 | weightlifting    |    4 | 2025-03-24 |                            |     |        |
  5 | treadmill        |   34 | 2025-06-07 | 2026-01-14 21:32:01.397684 |     |        |
  7 | barbell_press    |   34 | 2023-09-28 | 2026-01-14 21:53:06.717294 |  56 |        |
  9 | pullups          |   34 | 2025-09-30 | 2026-01-14 22:23:57.492257 |  89 |     78 | do with full intensity
(7 rows)

postgres=# \d fitness_tracker
                        Table "public.fitness_tracker"
    Column     |            Type             | Collation | Nullable | Default
---------------+-----------------------------+-----------+----------+---------
 id            | integer                     |           | not null |
 exercise_name | character varying(50)       |           |          |
 sets          | integer                     |           | not null |
 date_added    | date                        |           |          |
 created_at    | timestamp without time zone |           |          |
 rep           | integer                     |           |          |
 weight        | integer                     |           |          |
 notes         | character varying(200)      |           |          |
Indexes:
    "fitness_pkey" PRIMARY KEY, btree (id)

postgres=# ALTER TABLE fitness_tracker ALTER COLUMN weight TYPE numeric(5,2);
ALTER TABLE
postgres=# \d fitness_tracker
                        Table "public.fitness_tracker"
    Column     |            Type             | Collation | Nullable | Default
---------------+-----------------------------+-----------+----------+---------
 id            | integer                     |           | not null |
 exercise_name | character varying(50)       |           |          |
 sets          | integer                     |           | not null |
 date_added    | date                        |           |          |
 created_at    | timestamp without time zone |           |          |
 rep           | integer                     |           |          |
 weight        | numeric(5,2)                |           |          |
 notes         | character varying(200)      |           |          |
Indexes:
    "fitness_pkey" PRIMARY KEY, btree (id)

postgres=# \d fitness_tracker
                        Table "public.fitness_tracker"
    Column     |            Type             | Collation | Nullable | Default
---------------+-----------------------------+-----------+----------+---------
 id            | integer                     |           | not null |
 exercise_name | character varying(50)       |           |          |
 sets          | integer                     |           | not null |
 date_added    | date                        |           |          |
 created_at    | timestamp without time zone |           |          |
 rep           | integer                     |           |          |
 weight        | numeric(5,2)                |           |          |
 notes         | character varying(200)      |           |          |
Indexes:
    "fitness_pkey" PRIMARY KEY, btree (id)

postgres=# \d database
Did not find any relation named "database".
postgres=# \d fitness
Did not find any relation named "fitness".
postgres=# \dt
              List of relations
 Schema |      Name       | Type  |  Owner
--------+-----------------+-------+----------
 public | blain           | table | postgres
 public | fitness_tracker | table | postgres
 public | restaurant      | table | postgres
 public | reviews         | table | postgres
(4 rows)

postgres=# GRANT ALL PRIVILEGES ON TABLE fitness_tracker TO baqtiyaar;
GRANT
postgres=# ALTER TABLE fitness_tracker
ALTER COLUMN id
ADD GENERATED ALWAYS AS IDENTITY;
ALTER TABLE
postgres=# select * from fitness_tracker;
 id  |   exercise_name    | sets | date_added |     created_at      | rep | weight |         notes
-----+--------------------+------+------------+---------------------+-----+--------+-----------------------
  81 | Squats             |    4 | 2024-11-18 | 2024-11-18 09:15:23 |   8 |  60.00 | Felt strong today
  82 | Bench Press        |    3 | 2024-11-18 | 2024-11-18 09:35:47 |  10 |  50.00 |
  83 | Deadlifts          |    3 | 2024-11-20 | 2024-11-20 10:22:15 |   6 |  80.00 | Good form
  84 | Barbell Rows       |    4 | 2024-11-20 | 2024-11-20 10:45:33 |  10 |  45.00 |
  85 | Overhead Press     |    3 | 2024-11-22 | 2024-11-22 08:50:12 |   8 |  35.00 |
  86 | Squats             |    4 | 2024-11-25 | 2024-11-25 09:10:44 |   8 |  62.50 |
  87 | Bench Press        |    4 | 2024-11-25 | 2024-11-25 09:28:56 |   8 |  52.50 | Added extra set
  88 | Pull-ups           |    3 | 2024-11-27 | 2024-11-27 10:05:21 |   8 |   0.00 | Bodyweight only
  89 | Deadlifts          |    3 | 2024-11-27 | 2024-11-27 10:33:48 |   6 |  85.00 |
  90 | Barbell Rows       |    4 | 2024-11-29 | 2024-11-29 09:42:17 |  10 |  47.50 |
  91 | Overhead Press     |    3 | 2024-12-02 | 2024-12-02 08:55:39 |   8 |  37.50 | Struggled on last set
  92 | Squats             |    5 | 2024-12-02 | 2024-12-02 09:18:24 |   6 |  65.00 |
  93 | Bench Press        |    4 | 2024-12-04 | 2024-12-04 09:25:51 |   8 |  55.00 |
  94 | Lunges             |    3 | 2024-12-04 | 2024-12-04 09:48:03 |  12 |  20.00 | Per leg
  95 | Deadlifts          |    4 | 2024-12-06 | 2024-12-06 10:12:36 |   5 |  90.00 | New PR!
  96 | Lat Pulldowns      |    3 | 2024-12-06 | 2024-12-06 10:38:42 |  12 |  55.00 |
  97 | Barbell Rows       |    4 | 2024-12-09 | 2024-12-09 09:52:18 |   8 |  50.00 |
  98 | Overhead Press     |    4 | 2024-12-09 | 2024-12-09 10:15:27 |   6 |  40.00 |
  99 | Squats             |    4 | 2024-12-11 | 2024-12-11 09:08:55 |   8 |  67.50 | Solid session
 100 | Bench Press        |    4 | 2024-12-11 | 2024-12-11 09:32:41 |   8 |  57.50 |
 101 | Romanian Deadlifts |    3 | 2024-12-13 | 2024-12-13 10:20:13 |  10 |  60.00 |
 102 | Pull-ups           |    3 | 2024-12-13 | 2024-12-13 10:44:29 |  10 |   5.00 | Added weight belt
 103 | Deadlifts          |    3 | 2024-12-16 | 2024-12-16 09:58:37 |   6 |  92.50 |
 104 | Barbell Rows       |    4 | 2024-12-16 | 2024-12-16 10:22:54 |   8 |  52.50 |
 105 | Overhead Press     |    4 | 2024-12-18 | 2024-12-18 08:47:16 |   6 |  42.50 | Felt easier today
 106 | Squats             |    5 | 2024-12-18 | 2024-12-18 09:11:33 |   5 |  70.00 |
 107 | Bench Press        |    5 | 2024-12-20 | 2024-12-20 09:35:48 |   6 |  60.00 |
 108 | Leg Press          |    4 | 2024-12-20 | 2024-12-20 09:58:22 |  12 | 120.00 |
 109 | Deadlifts          |    4 | 2024-12-23 | 2024-12-23 10:15:07 |   5 |  95.00 | Christmas week grind
 110 | Lat Pulldowns      |    4 | 2024-12-23 | 2024-12-23 10:41:52 |  10 |  60.00 |
 111 | Squats             |    4 | 2024-12-27 | 2024-12-27 09:22:34 |   8 |  72.50 |
 112 | Overhead Press     |    4 | 2024-12-27 | 2024-12-27 09:48:19 |   6 |  45.00 | Hit all reps!
 113 | Bench Press        |    4 | 2024-12-30 | 2024-12-30 09:14:26 |   8 |  62.50 |
 114 | Barbell Rows       |    4 | 2024-12-30 | 2024-12-30 09:37:41 |   8 |  55.00 | End of year strong
 115 | Deadlifts          |    3 | 2025-01-03 | 2025-01-03 10:05:58 |   6 |  97.50 |
 116 | Squats             |    5 | 2025-01-06 | 2025-01-06 09:19:12 |   5 |  75.00 | New year gains
 117 | Bench Press        |    4 | 2025-01-08 | 2025-01-08 09:27:45 |   8 |  65.00 |
 118 | Pull-ups           |    4 | 2025-01-10 | 2025-01-10 10:12:33 |   8 |   7.50 |
 119 | Overhead Press     |    4 | 2025-01-13 | 2025-01-13 08:52:21 |   6 |  47.50 | Feeling strong
 120 | Deadlifts          |    4 | 2025-01-15 | 2025-01-15 10:28:47 |   5 | 100.00 | Triple digits!
(40 rows)