# Road Care Database Schema

This document describes the database structure for the Road-Care application. The database is designed to manage information related to status road infrastructure, government workers, and citizens interacting with the system.

## Database Structure

The database comprises the following tables:

### `departments` Table

- **id**: Unique identifier for the department (PRIMARY KEY).
- **name**: Name of the department (VARCHAR 50).

### `districts` Table

- **id**: Unique identifier for the district (PRIMARY KEY).
- **departments_id**: Identifier of the associated department (FOREIGN KEY).
- **name**: Name of the district (VARCHAR 50).

### `governments_entities` Table

- **id**: Unique identifier for the government entity (PRIMARY KEY).
- **districts_id**: Identifier of the associated district (FOREIGN KEY).
- **ruc**: RUC code of the entity (VARCHAR 100).
- **name**: Name of the government entity (VARCHAR 50).
- **phone**: Contact phone number (INT).
- **email**: Email address of the entity (VARCHAR 100).
- **address**: Address of the entity (VARCHAR 100).

### `workers_areas` Table

- **id**: Unique identifier for the worker area (PRIMARY KEY).
- **governments_entities_id**: Identifier of the associated government entity (FOREIGN KEY).
- **name**: Name of the worker area (VARCHAR 50).
- **state**: State of the worker area ('DELETED', 'ACTIVE') (CHECK).

### `workers_roles` Table

- **id**: Unique identifier for the worker role (PRIMARY KEY).
- **workers_areas_id**: Identifier of the associated worker area (FOREIGN KEY).
- **name**: Name of the worker role (VARCHAR 20).
- **state**: State of the worker role ('DELETED', 'ACTIVE') (CHECK).

### `workers` Table

- **id**: Unique identifier for the worker (PRIMARY KEY).
- **districts_id**: Identifier of the associated district (FOREIGN KEY).
- **governments_entities_id**: Identifier of the associated government entity (FOREIGN KEY).
- **firstname**: First name of the worker (VARCHAR 50).
- **lastname**: Last name of the worker (VARCHAR 50).
- **age**: Age of the worker (INT).
- **genre**: Gender of the worker (VARCHAR 20).
- **phone**: Phone number of the worker (INT).
- **email**: Email address of the worker (VARCHAR 100).
- **address**: Address of the worker (VARCHAR 100).
- **state**: State of the worker ('SUSPENDED', 'INACTIVE', 'ACTIVE') (CHECK).

### `workers_credentials` Table

- **workers_id**: Unique identifier for the worker (PRIMARY KEY, FOREIGN KEY).
- **code**: Code access for the worker (VARCHAR 50).

### `assignments_workers` Table

- **id**: Unique identifier for the assignment (PRIMARY KEY).
- **workers_roles_id**: Identifier of the associated worker role (FOREIGN KEY).
- **workers_id**: Identifier of the associated worker (FOREIGN KEY).
- **start_date**: Start date of the assignment (DATE).
- **final_date**: End date of the assignment (DATE).
- **state**: State of the assignment ('DELETED', 'SUSPENDED', 'EXPIRED', 'ACTIVE') (CHECK).

### `damaged_infrastructures` Table

- **id**: Unique identifier for the damaged infrastructure (PRIMARY KEY).
- **districts_id**: Identifier of the associated district (FOREIGN KEY).
- **registration_date**: Registration date of the damaged infrastructure (DATETIME).
- **description**: Description of the damaged infrastructure (VARCHAR 200).
- **address**: Address of the damaged infrastructure (VARCHAR 100).
- **work_date**: Work date on the infrastructure (DATETIME, can be NULL).
- **state**: State of the infrastructure ('DENIED', 'IN PROCESS', 'PENDING', 'COMPLETED') (CHECK).

### `staff` Table

- **id**: Unique identifier for the staff member (PRIMARY KEY).
- **damaged_infrastructures_id**: Identifier of the associated damaged infrastructure (FOREIGN KEY).
- **workers_id**: Identifier of the associated worker (FOREIGN KEY).
- **state**: State of the staff member ('DELETED', 'SUSPENDED', 'INACTIVE', 'ACTIVE') (CHECK).

### `citizens` Table

- **id**: Unique identifier for the citizen (PRIMARY KEY).
- **profile_url**: Profile URL of the citizen (VARCHAR MAX, can be NULL).
- **firstname**: First name of the citizen (VARCHAR 50).
- **lastname**: Last name of the citizen (VARCHAR 50).
- **age**: Age of the citizen (INT).
- **genre**: Gender of the citizen (VARCHAR 20).
- **phone**: Phone number of the citizen (INT).
- **email**: Email address of the citizen (VARCHAR 100).
- **state**: State of the citizen ('REPORTED', 'INACTIVE', 'ACTIVE') (CHECK).

### `citizens_credentials` Table

- **citizens_id**: Unique identifier for the citizen (PRIMARY KEY, FOREIGN KEY).
- **code**: Code access for the citizen (VARCHAR 50).

### `publications` Table

- **id**: Unique identifier for the publication (PRIMARY KEY).
- **citizens_id**: Identifier of the associated citizen (FOREIGN KEY).
- **publication_date**: Date of the publication (DATETIME).
- **districts_id**: Identifier of the associated district (FOREIGN KEY).
- **ubication**: Location of the infrastructure damaged (VARCHAR 100).
- **description**: Description of the publication (VARCHAR 200).
- **state**: State of the publication ('REPORTED', 'DELETED', 'PUBLISHED') (CHECK).

### `evidences` Table

- **id**: Unique identifier for the evidence (PRIMARY KEY).
- **publications_id**: Identifier of the associated publication (FOREIGN KEY).
- **file_url**: URL of the evidence file (VARCHAR MAX).

### `comments` Table

- **id**: Unique identifier for the comment (PRIMARY KEY).
- **publications_id**: Identifier of the associated publication (FOREIGN KEY).
- **citizens_id**: Identifier of the associated citizen (FOREIGN KEY).
- **shipping_date**: Date of the comment (DATETIME).
- **opinion**: Opinion content of the citizen (VARCHAR 100).
- **state**: State of the comment ('REPORTED', 'DELETED', 'SENT') (CHECK).
