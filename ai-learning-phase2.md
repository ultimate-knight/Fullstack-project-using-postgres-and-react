AI Learnings — Phase 2: Define Schema

Summary

AI Used: Yes
Number of AI interactions: 11


Interaction Log
Interaction 1
What went wrong:
Didn't understand what id INT PRIMARY KEY meant in SQL and why we use it.
What AI said:

id is the column name for unique identification
INT is the data type (stores integer numbers)
PRIMARY KEY is a constraint that enforces uniqueness, prevents NULL values, and ensures each table has only one primary key
It's like an Aadhaar number - everyone has one, no duplicates, uniquely identifies you

What I learned:
Primary keys are essential for database design because they provide a stable identifier for each row and enable relationships between tables through foreign keys.

Interaction 2
What went wrong:
Confused about when to use UNIQUE vs PRIMARY KEY.
What AI said:

UNIQUE allows NULL values (usually one NULL), but PRIMARY KEY does not
A table can have multiple UNIQUE constraints but only ONE PRIMARY KEY
PRIMARY KEY = identity of the row; UNIQUE = business rule constraint
Foreign keys should reference primary keys, not unique constraints

What I learned:
Use PRIMARY KEY for the main identifier (like user ID), and UNIQUE for fields that shouldn't repeat but aren't the main identity (like email or phone number).

Interaction 3
What went wrong:
Didn't know how to define date and timestamp data types properly.
What AI said:

DATE stores only the date (YYYY-MM-DD format)
TIME stores only time
TIMESTAMP stores date + time but without timezone
TIMESTAMPTZ stores date + time + timezone (PostgreSQL best practice)
Can auto-set with DEFAULT CURRENT_DATE or DEFAULT NOW()

What I learned:
For timestamps like "created_at" or "updated_at", always use TIMESTAMPTZ DEFAULT NOW() in PostgreSQL to capture exact moment with timezone info.

Interaction 4
What went wrong:
Created my first table schema but it wasn't following best practices.
What AI said:
My original schema was syntactically correct but had design gaps:

id INT PRIMARY KEY doesn't auto-increment (need SERIAL or IDENTITY)
exercise_name should have NOT NULL constraint
created_at should have DEFAULT CURRENT_TIMESTAMP

What I learned:
"Correct SQL" doesn't mean "production-ready SQL". Best practices include auto-incrementing IDs, enforcing NOT NULL on required fields, and setting sensible defaults.

Interaction 5
What went wrong:
Table creation command seemed to work but \d fitness showed "Did not find any relation".
What AI said:
The postgres(# prompt means psql is waiting for the command to finish - the CREATE TABLE never actually executed. The =# prompt means ready to execute, while (# means incomplete command (missing semicolon or unclosed parenthesis).
What I learned:
Always check the psql prompt - =# means ready, (# means waiting. Press Ctrl+C to cancel incomplete commands or type ; to finish them.

Interaction 6
What went wrong:
INSERT statement failed: INSERT INTO fitness VALUES(1,jumping_jacks,2,4,24-03-2025);
What AI said:
Three mistakes:

Text strings MUST be in single quotes: 'jumping_jacks' not jumping_jacks
Dates must be in YYYY-MM-DD format and quoted: '2025-03-24'
Missing the created_at value (6th column)

What I learned:
PostgreSQL is strict: always use single quotes for strings and dates, use YYYY-MM-DD date format, and provide values for all columns (or specify column names in INSERT).

Interaction 7
What went wrong:
Tried to use double quotes for strings: "chest press" and "2025-08-30".
What AI said:
In PostgreSQL:

Single quotes '...' = string/text values
Double quotes "..." = identifiers (column/table names)
PostgreSQL thought "chest press" was a column name, not a string value.

What I learned:
Golden rule: Strings → single quotes, identifiers → double quotes. This is a PostgreSQL standard that differs from some other databases.

Interaction 8
What went wrong:
Tried MySQL syntax in PostgreSQL: ALTER TABLE fitness_tracker CHANGE id serial int;
What AI said:

CHANGE is MySQL-only syntax - PostgreSQL doesn't support it
SERIAL isn't a real data type, just a CREATE TABLE shortcut
To make existing column auto-increment, need to create a sequence or use GENERATED ALWAYS AS IDENTITY

What I learned:
PostgreSQL and MySQL have different ALTER TABLE syntax. PostgreSQL uses ALTER COLUMN for modifications and doesn't support CHANGE or MODIFY.

Interaction 9
What went wrong:
Tried to rename column and change type in one command: ALTER COLUMN reps rep INT NOT NULL;
What AI said:
PostgreSQL requires separate commands:

RENAME COLUMN reps TO rep (for renaming)
ALTER COLUMN rep TYPE INT (for changing type)
ALTER COLUMN rep SET NOT NULL (for adding constraint)

What I learned:
Unlike MySQL, PostgreSQL does each modification as a separate ALTER TABLE statement. Cannot combine renaming, type changes, and constraint changes in one line.

Interaction 10
What went wrong:
Confused about when to use ALTER vs RENAME.
What AI said:

ALTER TABLE is the general command for changing table structure
RENAME is a specific type of alteration for renaming tables/columns only
ALTER COLUMN is used for changing type, defaults, or constraints
They're not alternatives - RENAME is used inside ALTER TABLE

What I learned:
Mental model: ALTER TABLE is the umbrella command. Use RENAME COLUMN for name changes, ALTER COLUMN for type/constraint changes. Each serves a specific purpose.

Interaction 11
What went wrong:
Created and populated tables in iTerm/psql but didn't know how to save work to a file for version control.
What AI said:
Need to:

Create a .sql file in VS Code (in a db/ directory)
Copy CREATE TABLE and INSERT statements from iTerm
Paste into the file with comments for clarity
Commit the file to Git
Can later re-run with: psql -U postgres -d dbname -f file.sql

What I learned:
Database work in terminal is temporary. Always save schemas to .sql files in a db/ directory for version control, team collaboration, and easy re-execution.

Key Takeaways

Primary Key vs Unique: PRIMARY KEY is for row identity (no NULLs, one per table), UNIQUE is for business constraints (can have NULL, multiple allowed)
PostgreSQL Quote Rules: Single quotes '...' for strings/dates, double quotes "..." for column/table names - this is non-negotiable
Date Formats: Always use 'YYYY-MM-DD' format for dates in PostgreSQL, and prefer TIMESTAMPTZ over TIMESTAMP for timezone support
Auto-incrementing IDs: Use SERIAL PRIMARY KEY (or modern GENERATED ALWAYS AS IDENTITY) in CREATE TABLE - plain INT PRIMARY KEY requires manual ID management
PostgreSQL vs MySQL Syntax: PostgreSQL uses ALTER COLUMN for modifications, doesn't support MySQL's CHANGE or MODIFY commands
Best Practices Matter: Syntactically correct SQL ≠ production-ready SQL. Always add NOT NULL constraints, defaults, and auto-increment where appropriate
psql Prompts: =# means ready for command, (# means waiting (incomplete command) - press Ctrl+C to cancel or ; to complete
Version Control: Save all schema work to .sql files in a db/ directory, never rely on terminal history alone
Separate ALTER Operations: In PostgreSQL, rename, type changes, and constraint modifications must be separate ALTER TABLE statements
Verify Before Constraints: Before adding NOT NULL constraints, check for existing NULL values with WHERE column IS NULL and clean them up first