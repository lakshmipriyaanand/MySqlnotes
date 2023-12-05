-- Locking
set autocommit=0;

use transaction_processing;
select * from sample;

-- With no locks:
START TRANSACTION;
INSERT INTO sample value (2,'Jini');
COMMIT;

-- Lock in Shared Mode:
START TRANSACTION;
select * from sample LOCK IN SHARE MODE;
INSERT INTO sample value (5,'Sabu');
COMMIT;

-- Lock for update
START TRANSACTION;
select * from sample for UPDATE;
Commit;

-- Lock in shared mode again to test after update lock:
START TRANSACTION;
select * from sample LOCK IN SHARE MODE;

