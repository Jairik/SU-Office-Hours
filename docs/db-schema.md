# Database Schema

## Table: `staff`

Stores core information about instructional staff members

| Column Name         | Type    | Constraints / Notes                                          |
| ------------------- | ------- | ------------------------------------------------------------ |
| `staff_uuid`        | UUID    | **Primary Key**                                              |
| `role`              | ENUM    | Values: `lab_assistant`, `tutor`, `professor`, `admin`       |
| `name`              | VARCHAR | Full name                                                    |
| `email`             | VARCHAR | Optional (SU email address)                                  |
| `current_courses`   | TEXT[]  | Array of course identifiers currently assigned               |
| `course_experience` | TEXT[]  | Array of courses previously taught or assisted               |
| `latest_update_id`  | UUID    | **Foreign Key** → `updates.update_uuid` (most recent update) |

### Notes
- `current_courses` includes any classes currently assisting or teaching. `course_experience` stores any previously taken classes for future class-specific lookup features.
- `latest_update_id` provides fast access to the most recent status updates without having to scan the entire updates table.

## Table: `updates`

Stores historical updates related to staff availability or office hours

| Column Name         | Type | Constraints / Notes                  |
| ------------------- | ---- | ------------------------------------ |
| `update_uuid`       | UUID | **Primary Key**                      |
| `staff_uuid`        | UUID | **Foreign Key** → `staff.staff_uuid` |
| `message`           | TEXT | Long-form update message             |
| `office_hours_date` | DATE | Date affected by the update          |
| `timestamp`         | DATE | Date that the update was published   |

### Notes
- Each update belongs to exactly one staff member
- A staff member may have many updates, however, `staff.latest_update_id` only holds the most recent one
- `office_hours_date` represents the date in which office hours are impacted. Can be null. Will be indexed.
- `staff_uuid` will be indexed

## Table: `office_hours`

Represents a single recurring office horus block for a staff member.

| Column Name        | Type     | Constraints / Notes                  |
| ------------------ | -------- | ------------------------------------ |
| `office_hour_uuid` | UUID     | **Primary Key**                      |
| `staff_uuid`       | UUID     | **Foreign Key** → `staff.staff_uuid` |
| `day_of_week`      | SMALLINT | 0–6 (Sunday–Saturday)                |
| `start_time`       | TIME     | Start of office hour                 |
| `end_time`         | TIME     | End of office hour                   |
| `location`         | VARCHAR  | Optional (room, Zoom link, etc.)     |
| `is_active`        | BOOLEAN  | Defaults to `true`                   |

### Notes
- `location` defaults to TETC111
- `start_time` and `end_time` follow military time format