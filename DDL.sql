-- DDL COMMANDS:
-- 1.CREATE
CREATE TABLE LP(
Aadhar_no int NOT NULL,
Full_name VARCHAR(30),
DOB Date,
Salary int NOT NULL,
PRIMARY KEY (Aadhar_no)
);

-- Describe LP
desc lp;

-- 2. ALTER: ADD,MODIFY , DROP COLUMN, RENAME COLUMN ,CHANGE
ALTER TABLE LP ADD COLUMN Phone_no int; -- ADD
ALTER TABLE LP ADD COLUMN Age int;
ALTER TABLE LP MODIFY salary float; -- MODIFY is used to change the datatype of attribute
ALTER TABLE LP DROP COLUMN Age; -- DROP COLUMN in ALTER is used to drop the column
ALTER TABLE LP RENAME COLUMN Phone_no to Contact_no; -- RENAME COLUMN in ALTER is used to rename the column
ALTER TABLE LP CHANGE Salary Payscale int; -- change is used to change the name along with datatype of the attribute

-- 3. RENAME:
RENAME TABLE LP TO MEMBERS; -- Can rename a whole table

-- 4.DROP:
DROP TABLE MEMBERS; -- DROPS THE ENTIRE TABLE

-- 5.TRUNCATE:
TRUNCATE TABLE MEMBERS; -- DROPS ONLY THE VALUES IN THE ENTIRE TABLE