AI Learnings — Phase 6: Test Delete Operation

Summary

AI Used: No

Number of AI interactions: 0

Interaction Log
Interaction 1

What went wrong:
No issues occurred. The task involved verifying delete operations manually.

What AI said:
Not applicable — AI was not used for this task.

What I learned:
I learned how to manually verify DELETE operations by cross-checking API deletions in Postman with direct SQL queries in the database. This helped me confirm that backend operations are actually affecting the database as expected.

Key Takeaways

Successfully deleted workouts using Postman for the following IDs: 533, 534, 536, 537, 538

Verified each deletion using the SQL query:
SELECT * FROM fitness_tracker WHERE id = specific-id

Confirmed that deleted records no longer exist in the database

Documented proof by pasting database query outputs into fitness_tracker-schema.sql in VS Code

Reinforced the importance of validating API actions directly at the database level

Completed the task without using AI