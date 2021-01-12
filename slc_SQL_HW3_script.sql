/*

HW 3 - Relational Database Management System

*/

-- create groups table

CREATE TABLE company_groups
(
g_id INT NOT NULL,
group_name TEXT NOT NULL,
PRIMARY KEY(g_id)
);

-- populate groups table, create temporary group for 'Unassigned' users

INSERT INTO company_groups(g_id, group_name) VALUES (1, 'IT');
INSERT INTO company_groups(g_id, group_name) VALUES (2, 'Sales');
INSERT INTO company_groups(g_id, group_name) VALUES (3, 'Administration');
INSERT INTO company_groups (g_id, group_name) VALUES (4, 'Operations');
INSERT INTO company_groups (g_id, group_name) VALUES (5, 'Unassigned');

-- create users table

CREATE TABLE users
(
u_id INT NOT NULL,
group_id INT NOT NULL, 
first_name TEXT,
PRIMARY KEY(u_id),
FOREIGN KEY(group_id) REFERENCES company_groups(g_id)
);

-- populate users table

INSERT INTO users (u_id, group_id, first_name) VALUES (1, 1, 'Modesto');
INSERT INTO users (u_id, group_id, first_name) VALUES (2, 1, 'Ayine');
INSERT INTO users (u_id, group_id, first_name) VALUES (3, 2, 'Christopher');
INSERT INTO users (u_id, group_id, first_name) VALUES (4, 2, 'Cheong Woo');
INSERT INTO users (u_id, group_id, first_name) VALUES (5, 3, 'Saulet');
INSERT INTO users (u_id, group_id, first_name) VALUES (6, 5, 'Heidy');

-- create rooms table

CREATE TABLE rooms
(
r_id INT UNIQUE NOT NULL,
room_name TEXT,
PRIMARY KEY(r_id)
);

-- populate rooms table, create 'None' category for administrators; create
-- 'Undetermined' for operations group.

INSERT INTO rooms (r_id, room_name) VALUES (1, '101');
INSERT INTO rooms (r_id, room_name) VALUES (2, '102');
INSERT INTO rooms (r_id, room_name) VALUES (3, 'Auditorium A');
INSERT INTO rooms (r_id, room_name) VALUES (4, 'Auditorium B');
INSERT INTO rooms (r_id, room_name) VALUES (5, 'Undetermined');
INSERT INTO rooms (r_id, room_name) VALUES (6, 'None');


-- create junction table

CREATE TABLE group_rooms_users
(
id INT NOT NULL,
groups_id INT,
rooms_id INT,
users_id INT,
PRIMARY KEY (id),
FOREIGN KEY(groups_id) REFERENCES company_groups(g_id),
FOREIGN KEY(rooms_id) REFERENCES rooms(r_id),
FOREIGN KEY(users_id) REFERENCES users(u_id)
);

-- populate junction table

INSERT INTO group_rooms_users (id, groups_id, rooms_id, users_id) VALUES (1, 1, 1, 1);
INSERT INTO group_rooms_users (id, groups_id, rooms_id, users_id) VALUES (2, 1, 2, 1);
INSERT INTO group_rooms_users (id, groups_id, rooms_id, users_id) VALUES (3, 1, 1, 2);
INSERT INTO group_rooms_users (id, groups_id, rooms_id, users_id) VALUES (4, 1, 2, 2);
INSERT INTO group_rooms_users (id, groups_id, rooms_id, users_id) VALUES (5, 2, 2, 3);
INSERT INTO group_rooms_users (id, groups_id, rooms_id, users_id) VALUES (6, 2, 3, 3);
INSERT INTO group_rooms_users (id, groups_id, rooms_id, users_id) VALUES (7, 2, 2, 4);
INSERT INTO group_rooms_users (id, groups_id, rooms_id, users_id) VALUES (8, 2, 3, 4);
INSERT INTO group_rooms_users (id, groups_id, rooms_id, users_id) VALUES (9, 3, 6, 5);
INSERT INTO group_rooms_users (id, groups_id, rooms_id, users_id) VALUES (10, 5, 5, 6);


/*
write SELECT statements that provide the following information: 
• All groups, and the users in each group. A group should appear even if 
there are no users assigned to the group. 
• All rooms, and the groups assigned to each room. The rooms should 
appear even if no groups have been assigned to them. 
• A list of users, the groups that they belong to, and the rooms to 
which they are assigned. This should be sorted alphabetically by user, 
then by group, then by room. 

*/

-- 1. All groups, and the users in each group.

Select group_name, first_name, u_id, group_id
FROM company_groups g
LEFT JOIN users u
ON g.g_id = u.group_id
;

-- 2. All rooms, and the groups assigned to each room

SELECT DISTINCT room_name, group_name 
FROM rooms r 
LEFT JOIN group_rooms_users gru
ON r.r_id = gru.rooms_id
JOIN company_groups cg
ON gru.groups_id = cg.g_id
;


-- 3. A list of users, the groups that they belong to, and the rooms to 
-- which they are assigned.

SELECT DISTINCT first_name, group_name, room_name
FROM users u
INNER JOIN company_groups cg
ON u.group_id = cg.g_id
INNER JOIN group_rooms_users gru
ON gru.groups_id = cg.g_id
INNER JOIN rooms r
ON r.r_id = gru.rooms_id
ORDER BY first_name, group_name, room_name
;


