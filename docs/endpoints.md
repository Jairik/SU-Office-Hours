# Tentative endpoints

### GET /api/staff

**Returns the results of all staff with office hours (not admins).**

- Due to the very small size of the database, this will be loaded into client-side memory for quick searching of name and course. This would be an awful idea at scale, but easier for this to minimize costs.

### GET /api/office_hours

Returns all weekly scheduled office hours.