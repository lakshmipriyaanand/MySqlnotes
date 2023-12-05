set autocommit=0;
create database transaction_processing;
use transaction_processing;

create table sample(
id int,
name varchar(20));

select * from sample;

-- Transaction processing:
START TRANSACTION;
Insert into sample values(1,'Abi');
Insert into sample values(2,'Bala');
select * from sample;
-- rollback deletes all the previous functions
rollback;
select * from sample;

Insert into sample values(1,'Abi');
Insert into sample values(2,'Bala');
commit; -- permanently saves the functions performed

-- savepoint
savepoint s1;
Insert into sample values(3,'Cala');
savepoint s2;
Insert into sample values(4,'Dili');
savepoint s3;
Insert into sample values(5,'Elei');

-- rollback to savepoint
rollback to s2;

-- release savepoint
release savepoint s1;
commit;