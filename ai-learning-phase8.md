Fitness Tracker UI Design Specification
Overview
A minimal, mobile-friendly web application to track workouts. The design focuses on ease of data entry and quick access to workout history.

1. Screen Descriptions
A. Dashboard (Home Screen)
The main landing page. It provides a snapshot of recent activity and quick actions to manage workouts.

Primary Goal: View history and initiate new entries.
Layout: Vertical scrollable list of workout cards with a sticky header and a floating action button (FAB) or prominent "Add" button for easy thumb access on mobile.
B. Add/Edit Workout Screen
A dedicated form screen to input or modify workout details.

Primary Goal: Data entry.
Layout: Clean, stacked form fields with large touch targets. Uses the same layout for both "Add" and "Edit" states, with the title changing accordingly.
C. Delete Confirmation (Modal/Dialog)
A safety check before permanent deletion.

Primary Goal: Prevent accidental data loss.
Layout: clearly visible warning message with "Cancel" and "Destructive Delete" buttons.
2. UI Components & Data Mapping
Dashboard Components
App Header
App Title (e.g., "FitTrack")
Theme Toggle (Optional for later)
Filter Bar
Input: "Search exercises..."
Function: Real-time filtering of the list based on exercise_name.
Workout List Card (Repeater)
Header: exercise_name (Bold, Large)
Subtitle: date_added (Formatted, e.g., "Jan 26, 2025")
Stats Grid:
sets x rep @ weight kg/lbs
Example: "3 sets x 10 reps @ 135 lbs"
Notes Section: (Collapsible or truncated 1-liner) displaying notes.
Actions:
Edit Icon (Pencil)
Delete Icon (Trash Can)
Add Button (FAB)
Position: Bottom Right (Fixed)
Icon: "+"
Add/Edit Form Components
Screen Header
"Back" button (Chevron Left)
Title: "New Workout" or "Edit Workout"
Form Fields
Exercise Name: Text Input (Placeholder: "Bench Press"). Future upgrade: Autocomplete.
Date: Date Picker (Default: Today). Maps to date_added.
Stats Row:
Sets: Number Input (Stepper preferred).
Reps: Number Input.
Weight: Number Input.
Notes: Text Area (multiline) for notes.
Action Footer
Primary Button: "Save Workout" (Full width).
Secondary Button: "Cancel" (Text link).
3. User Flow
Scenario A: Adding a Workout
User lands on Dashboard.
Taps "+" FAB.
Navigates to Add Workout Screen.
Fills in details (exercise_name, weight, etc.).
Taps "Save Workout".
System validates inputs.
Success: Redirects to Dashboard with a brief "Workout Added" toast notification. New item appears at top of list.
Scenario B: Editing a Workout
User scrolls through Dashboard.
Taps Edit (Pencil) Icon on a specific card.
Navigates to Edit Workout Screen (Form pre-filled with existing id data).
Modifies weight or notes.
Taps "Save Changes".
Success: Redirects to Dashboard with "Workout Updated" toast. List reflects changes.
Scenario C: Deleting a Workout
User taps Delete (Trash) Icon on a card.
Confirmation Modal appears: "Delete this workout? This cannot be undone."
User taps "Delete".
Success: Modal closes. Item is removed from list. "Workout Deleted" toast appears.
Scenario D: Filtering
User types "Squat" in Filter Bar on Dashboard.
List immediately updates to show only cards where exercise_name contains "Squat".
User clears input -> List returns to full view.
4. Success & Error Handling
Success States
Visual Feedback: Use non-intrusive Toast Notifications (snackbars) at the bottom of the screen.
"Entry saved successfully."
"Entry deleted."
Navigation: Auto-redirect to Dashboard after successful Add/Edit.
List Update: Immediate UI update (optimistic UI or re-fetch) so the user sees the result instantly.
Error States
Form Validation (Inline):
If exercise_name is empty: Highlight input border in red, show text "Exercise name is required."
If sets/reps < 0: Show "Must be positive."
System Errors (Network/Server):
If save fails: Show Toast "Failed to save. Please try again."
Keep user on the Form screen so they don't lose their data.
5. Technical Considerations for "Junior Dev"
State Management: Keep it simple. Use React useState and useEffect (if using React) or vanilla JS equivalents.
Storage: Start with localStorage or a simple JSON file (via JSON Server) to mock a backend before connecting to a real database.
CSS: Use CSS Flexbox/Grid for layout. A CSS-in-JS approach or Utility classes (like Tailwind) can speed up styling but writing raw CSS modules is great for learning.