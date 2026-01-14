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