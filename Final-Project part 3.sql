USE ibalance;
-- Create table
CREATE TABLE Person(
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

-- Retreive Data
-- A query to know what task each person has.
SELECT first_name, td.name AS todolist , ca.title AS category, ta.Title AS task
FROM user u
JOIN user_has_todolist utd
ON u.user_id = utd.user_id 
JOIN todolist td 
ON utd.todolist_id = td.todolist_id
JOIN category_has_todolist ctd
ON ctd.todolist_id =td.todolist_id
JOIN category ca
ON ca.category_id = ctd.category_id
JOIN task ta
ON ta.category_id = ca.category_id
ORDER BY first_name;

-- update User last Name
UPDATE user
SET last_name = 'Ceron', email= 'new@gmail.com'
WHERE user_id = 1;

SELECT *
FROM user
WHERE user_id = 1;

-- DELETE

INSERT INTO user (user_id, username, email, first_name, last_name )
VALUES(4, 'Newuser','new@email.com', 'New', 'Name' );

DELETE FROM user WHERE first_name='New';
