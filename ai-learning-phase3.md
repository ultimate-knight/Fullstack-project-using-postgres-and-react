AI Learnings — Phase 3: Generate Seed Data

Summary

AI Used: Yes

Number of AI interactions: 1

Interaction Log
Interaction 1

What went wrong:
I generated seed workout data using AI, but the data did not fully match my PostgreSQL table schema. Specifically, the weight column in my database was defined as integer, while the generated data contained decimal values like 62.5, 52.5, and 7.5.

What AI said:
The AI explained that PostgreSQL does not allow decimal values in an integer column and would reject those rows during insertion. It pointed out that this was the only schema mismatch, while all other columns (id, exercise_name, sets, rep, date_added, created_at, notes) were valid and correctly formatted.

What I learned:
I learned that even if data looks logically correct, it must strictly match the database schema. Decimal weights are realistic for gym data, but the schema must support them. I also learned to validate seed data column-by-column against the schema before inserting it into the database.

Key Takeaways

AI-generated seed data must be validated against the exact PostgreSQL data types.

PostgreSQL will reject decimal values for integer columns.

Gym weights often require decimals, so numeric or decimal is a better choice than integer.

Always review schema constraints (NOT NULL, data types) before seeding data.

Catching schema mismatches early prevents runtime errors during inserts.