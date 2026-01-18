AI Learnings — Phase 5: Create API Endpoints

Summary

AI Used: Yes
Number of AI interactions: 24


Interaction Log
Interaction 1: Setting Up Database Seeding
What went wrong:
Needed to create a seed.js script to populate the PostgreSQL database from JSON, but wasn't sure about the correct structure and safety measures.
What AI said:
The seed script should:

Use pg Pool for database connections
Read data from seed-data.json using fs
Clear existing data first (DELETE FROM table) to prevent duplicates
Use parameterized queries ($1, $2, etc.) to prevent SQL injection
Log progress for visibility
Handle errors properly

What I learned:

Parameterized queries are critical for security - never concatenate user input into SQL
The pg Pool manages multiple connections efficiently
Always use try/catch/finally with database operations
client.release() returns the connection to the pool


Interaction 2: Database vs Table Name Confusion
What went wrong:
Got error "relation 'fitness_tracker' does not exist" even though the table existed when I checked with \dt in psql.
What AI said:
PostgreSQL has a hierarchy: Server → Database → Schema → Tables. The error occurred because:

My table existed in the postgres database
My Node app was connecting to a different database (set in DB_NAME env variable)
I had set DB_NAME=fitness_tracker (the TABLE name, not DATABASE name)

What I learned:

Database ≠ Table - this is a fundamental distinction
Always verify which database you're connected to with SELECT current_database()
The .env DB_NAME should match the database containing your tables
Connection success ≠ table access - they're separate issues


Interaction 3: PostgreSQL Permission Issues
What went wrong:
After fixing the database connection, got "permission denied for table fitness_tracker"
What AI said:
The table owner was postgres but my app user was baqtiyaar. In PostgreSQL:

Just because you can connect doesn't mean you have table permissions
Need to explicitly GRANT privileges: GRANT ALL PRIVILEGES ON TABLE fitness_tracker TO baqtiyaar
Can grant on all tables in a schema for development convenience

What I learned:

Database permissions are separate from connection permissions
Table ownership matters in PostgreSQL
GRANT ALL PRIVILEGES covers INSERT, UPDATE, DELETE, SELECT
For production, use principle of least privilege


Interaction 4: Auto-Incrementing ID Column
What went wrong:
Insert failed with "null value in column 'id' violates not-null constraint"
What AI said:
My id column was defined as integer NOT NULL but had no default value or auto-increment. PostgreSQL doesn't automatically generate IDs. Need to use:
sqlALTER TABLE fitness_tracker
ALTER COLUMN id
ADD GENERATED ALWAYS AS IDENTITY;
What I learned:

GENERATED ALWAYS AS IDENTITY is the modern PostgreSQL way (10+)
Older SERIAL type also works but IDENTITY is SQL standard
ALWAYS means user can't manually insert ID values
BY DEFAULT allows overriding if needed
This creates an internal sequence that auto-increments


Interaction 5: SQL DELETE Syntax Error
What went wrong:
Delete route failed because I wrote delete fitness_tracker where id=$1 (missing FROM keyword)
What AI said:
PostgreSQL DELETE syntax requires FROM:
sqlDELETE FROM table_name WHERE condition
While PostgreSQL is case-insensitive for keywords, the structure must be correct.
What I learned:

SQL syntax is stricter than I thought - FROM is mandatory for DELETE
Case doesn't matter (DELETE = delete) but structure does
Always use parameterized queries even for DELETE
Check rowCount to verify if deletion actually occurred


Interaction 6: Route Parameter Conflicts
What went wrong:
Request to /workouts/Squats was hitting the /workouts/:id route instead of /workouts/:exercise_name, causing error "invalid input syntax for type integer: 'Squats'"
What AI said:
Express matches routes by position, not by parameter name. Both /workouts/:id and /workouts/:exercise_name look identical to Express - just "anything after /workouts/". The first matching route wins. Solutions:

Use specific routes: /workouts/id/:id and /workouts/exercise/:exercise_name
Or use query params: /workouts?exercise_name=squats

What I learned:

Express route matching is positional, not type-aware
Route order matters when using path parameters
Can't have two routes with same pattern expecting different data types
Query parameters are often cleaner for filtering/searching


Interaction 7: Handling Spaces in URL Parameters
What went wrong:
Couldn't figure out how to pass "jumping jacks" (with space) in URL
What AI said:
URLs can't contain raw spaces. Browser auto-encodes spaces to %20. Options:

Let browser handle it: /workouts/exercise/jumping jacks → jumping%20jacks
Use encodeURIComponent() in JavaScript: encodeURIComponent("jumping jacks")
Better: use query params which handle encoding automatically
Never manually replace spaces with underscores - that changes the search term

What I learned:

URL encoding is automatic in browsers
%20 and + both represent spaces in URLs
Query params handle special characters cleanly
encodeURIComponent() is essential when building URLs programmatically


Interaction 8: ILIKE for Case-Insensitive Search
What went wrong:
Search wasn't finding records when case didn't match exactly
What AI said:
PostgreSQL has two operators:

LIKE: case-sensitive ("Squats" ≠ "squats")
ILIKE: case-insensitive ("Squats" = "squats")

For partial matching, use wildcards:

ILIKE '%bench%' matches "bench press", "barbell bench", etc.
Without %, it's exact match (just case-insensitive)

What I learned:

ILIKE is PostgreSQL-specific (not standard SQL)
% is wildcard for partial matching
Leading % searches anywhere in string, trailing % at start only
Always use parameterized queries: ILIKE $1 with ['%${term}%']


Interaction 9: Understanding result.rows vs result.rows[0]
What went wrong:
Confused about when to return the full rows array vs just the first element
What AI said:
PostgreSQL always returns rows as an array through pg. The choice depends on query intent:

Use result.rows when expecting multiple results (SELECT without unique constraint)
Use result.rows[0] when expecting single result (SELECT by PRIMARY KEY, INSERT/UPDATE RETURNING)

Why it matters:

Frontend expects consistent data shape
Single object vs array affects how data is consumed
rows[0] on multi-row query loses data

What I learned:

Always return consistent data shapes from repository
Query by unique key (id) → rows[0] (single object)
Query by non-unique field → rows (array)
INSERT/UPDATE RETURNING → rows[0]
Check rows.length before accessing rows[0] to avoid undefined


Interaction 10: Repository Pattern Basics
What went wrong:
Wasn't sure what belongs in repository vs controller
What AI said:
Separation of concerns:

Repository: Only talks to database, receives plain data, returns plain data, no req/res
Controller: Handles HTTP (req/res), calls repository, sends responses
Service: Optional middle layer for business logic

Repository example:
javascriptasync insertData(data) { // receives plain object
  const result = await client.query(...)
  return result.rows[0] // returns plain data
}
What I learned:

Repository never touches req/res objects
Repository receives data as parameters, not from req.body directly
This separation makes code testable and reusable
Controller extracts from req, repository just works with data


Interaction 11: Object vs Array Destructuring
What went wrong:
Tried using array destructuring const [exercise_name, sets] = data on req.body object
What AI said:
Two types of destructuring in JavaScript:

Object destructuring: {exercise_name, sets} = data - uses property names, order independent
Array destructuring: [first, second] = data - uses position, order dependent

APIs send JSON objects, not arrays. Object destructuring is:

Self-documenting (clear what's being extracted)
Order-independent (safer)
REST-friendly

What I learned:

req.body is always an object (from JSON)
Object destructuring is standard for API parameters
Array destructuring is fragile for API data (order matters)
Use arrays only for fixed-position data like [latitude, longitude]


Interaction 12: Module Exports Confusion
What went wrong:
Confused between module.exports = Class vs module.exports = { Class }
What AI said:
Two export patterns:

Direct export: module.exports = UserRepository

Import: const UserRepository = require('./repo')
Use when exporting single thing


Named export: module.exports = { UserRepository, helper }

Import: const { UserRepository } = require('./repo')
Use when exporting multiple things



The curly braces in export create an object wrapper.
What I learned:

Export style must match import style
Single export per file → direct export (simpler)
Multiple exports → object with named properties
Mismatch causes "UserRepository is not a constructor" errors
In TypeScript/ES6 modules this becomes import/export syntax


Interaction 13: Service Layer Implementation
What went wrong:
Service methods were calling repository incorrectly and not awaiting promises
What AI said:
Common mistakes:

Forgetting await on async repository calls → returns Promise, not data
Creating new repository instance in every method → inefficient
Not passing data correctly from service to repository

Better pattern:
javascriptclass UserServices {
  constructor() {
    this.repo = new UserRepository() // create once
  }
  
  async addData(arg) {
    const data = await this.repo.Insertdata(arg) // await!
    return data
  }
}
What I learned:

Always await async functions or you get Promise objects
Can instantiate repository once in constructor for efficiency
Service layer validates/transforms before calling repository
Service can coordinate multiple repository calls


Interaction 14: Controller Error Handling
What went wrong:
Missing return after sending error response caused "headers already sent" error
What AI said:
Express can only send ONE response per request. If you do:
javascriptif (!data) {
  res.status(404).json({...}) // sends response
}
res.status(200).json({...}) // tries to send again → ERROR
Must use return:
javascriptif (!data) {
  return res.status(404).json({...}) // sends and exits
}
What I learned:

One request = one response (fundamental HTTP rule)
return after res.json() prevents code from continuing
"Cannot set headers after they are sent" means double response
This applies to if/else branches in controllers


Interaction 15: Error Object Property (error.message)
What went wrong:
Used error.Message (capital M) which was undefined
What AI said:
JavaScript Error objects use lowercase:

✅ error.message - the error description
❌ error.Message - doesn't exist
Also available: error.stack, error.name

What I learned:

JavaScript is case-sensitive everywhere
Standard Error properties are lowercase
Always log error.message and error.stack for debugging
Console.error() preserves stack traces better than console.log()


Interaction 16: Query Params vs Path Params
What went wrong:
Using req.body for GET request filters
What AI said:
HTTP method determines where data comes from:

POST/PUT/PATCH: req.body (JSON in request body)
GET with filters: req.query (?exercise_name=squats)
GET by ID: req.params.id (/workouts/:id)

GET requests technically shouldn't have body (though some clients allow it).
What I learned:

GET → req.query for filters, req.params for IDs
POST/PUT/PATCH → req.body for data
DELETE → req.params for ID (no body needed)
Query params automatically URL-decode
This follows REST conventions


Interaction 17: Passing Multiple Arguments to Service
What went wrong:
Thought I should pass req.body if service has 3 parameters
What AI said:
What you pass depends on what the service needs, NOT how many parameters:
javascript// Service expects 3 separate values
service.updateData(id, name, sets)

// Controller extracts from appropriate sources
service.updateData(
  req.params.id,      // from URL
  req.body.name,      // from body
  req.body.sets       // from body
)
What I learned:

Controller's job is to extract and pass data correctly
Can mix req.params, req.body, req.query as needed
Service signature determines what to pass
Number of parameters doesn't dictate using req.body


Interaction 18: Understanding "data is not iterable"
What went wrong:
Error "data is not iterable" in repository
What AI said:
This error means trying to iterate over non-iterable:

Iterable: arrays, strings, Maps, Sets
Not iterable: plain objects {}, null, undefined, numbers

Common cause: spreading an object
javascriptconst data = { name: "squats" } // object
const values = [...data] // ERROR: not iterable
In my case: trying to use spread on req.body object when building query parameters.
What I learned:

Spread operator ... only works on iterables
req.body is a plain object, not iterable
Must manually extract: const {name, sets} = data then [name, sets]
Error message "not iterable" always means wrong data type for operation


Interaction 19: PostgreSQL Date Format Requirements
What went wrong:
Got "date/time field value out of range: '23-07-2025'"
What AI said:
PostgreSQL strictly requires ISO format for dates:

✅ YYYY-MM-DD (2025-07-23)
❌ DD-MM-YYYY (23-07-2025)
❌ MM/DD/YYYY (07/23/2025)

HTML <input type="date"> automatically uses correct format. If accepting other formats, must convert server-side.
What I learned:

Always use ISO 8601 format (YYYY-MM-DD) for dates
PostgreSQL won't auto-convert DD-MM-YYYY
Frontend date inputs should use type="date"
Can use JavaScript Date.toISOString() or libraries like date-fns


Interaction 20: Returning Consistent Data Shapes
What went wrong:
getAlldata returned result when no filter, but result.rows when filtered - caused inconsistent behavior
What AI said:
Repository must return consistent data types:
javascript// ❌ Inconsistent
if (!filter) return result      // object
else return result.rows          // array

// ✅ Consistent
if (!filter) return result.rows  // array
else return result.rows          // array
What I learned:

Always return same data shape from a function
Client code shouldn't handle multiple return types
result is pg metadata, result.rows is actual data
This principle applies to all functions, not just repositories


Interaction 21: Empty Array is Truthy
What went wrong:
Check if (!data4) didn't work for empty UPDATE results
What AI said:
In JavaScript:

[] == false but ![] is false (empty array is truthy!)
Must check length: if (data.length === 0)

PostgreSQL UPDATE RETURNING returns empty array [] when no rows match, not null or undefined.
What I learned:

Empty array [] is truthy in JavaScript
Always check .length for arrays
!data only catches null/undefined/false/0/""
This is why rows.length === 0 is proper check


Interaction 22: HTTP Status Codes
What went wrong:
Using 401 Unauthorized for "not found" errors
What AI said:
Proper status codes:

200 OK: Successful GET/PUT
201 Created: Successful POST
204 No Content: Successful DELETE (no body)
400 Bad Request: Invalid input
401 Unauthorized: Missing/invalid authentication
404 Not Found: Resource doesn't exist
500 Internal Server Error: Server crashed

What I learned:

401 is for authentication failures, not missing data
404 is correct for "ID not found"
Status codes communicate semantics to clients
Proper codes help with debugging and API design


Interaction 23: Using RETURNING in UPDATE/DELETE
What went wrong:
UPDATE wasn't returning the modified data
What AI said:
PostgreSQL UPDATE/DELETE don't return data by default. Use RETURNING:
sqlUPDATE table SET col=$1 WHERE id=$2 RETURNING *
DELETE FROM table WHERE id=$1 RETURNING *
Without RETURNING:

result.rows = [] (empty)
result.rowCount tells how many affected
Can't see what was changed/deleted

What I learned:

RETURNING * gives back modified rows (PostgreSQL feature)
Useful for APIs to show what changed
Can return specific columns: RETURNING id, name
rowCount is alternative when you don't need data back


Interaction 24: Controller Constructor Pattern
What went wrong:
Creating new service instance in every controller method
What AI said:
Can instantiate once in constructor:
javascriptclass UserController {
  constructor() {
    this.service = new UserServices()
  }
  
  async addData(req, res) {
    const data = await this.service.addData(req.body)
  }
}
What I learned:

Reduces repetition (don't new up every method)
More efficient (single instance)
Standard OOP pattern
Still stateless if service/repo don't store request data


Key Takeaways
Database & PostgreSQL

Database ≠ Table - know the hierarchy (Server → Database → Schema → Table)
Always use parameterized queries ($1, $2) to prevent SQL injection
GENERATED ALWAYS AS IDENTITY is modern way for auto-increment IDs
PostgreSQL requires ISO date format (YYYY-MM-DD)
GRANT permissions separately from connection access
Use RETURNING * with UPDATE/DELETE to get modified data back
ILIKE for case-insensitive search, add % for partial matching

Node.js & Express Patterns

Controller: handles req/res, extracts data, calls service
Service: business logic, coordinates repositories
Repository: only database access, no req/res knowledge
One HTTP request = one response only (use return after res.json)
req.body (POST/PUT), req.params (IDs), req.query (filters)

JavaScript Fundamentals

Always await async functions or get Promise objects
Object destructuring {x, y} vs array destructuring [x, y]
Empty array [] is truthy - check .length instead
error.message (lowercase) not error.Message
Spread operator ... only works on iterables (not plain objects)
Module exports: direct vs object wrapper affects import syntax

Common Errors & Solutions

"relation does not exist" → wrong database or missing table
"permission denied" → need GRANT privileges
"not iterable" → spreading/looping on non-array
"headers already sent" → missing return after res.json()
"date out of range" → use YYYY-MM-DD format
Empty result but expected data → check result.rows vs result

Express Routing

Route order matters - specific before generic
Path params conflict if patterns identical
Query params handle special characters automatically
Use /resource/id/:id and /resource/name/:name to avoid conflicts

Best Practices

Return consistent data shapes from functions
Check array.length, not truthiness
Use proper HTTP status codes (404 for not found, not 401)
Create repository/service instances once, not per method
Log errors with error.message and error.stack
Clear separation: controller → service → repository → database


All sensitive information (passwords, usernames, connection strings) has been REDACTED from this document.Claude is AI and can make mistakes. Please double-check responses. Sonnet 4.5Claude is AI and can make mistakes. Please double-check responses.