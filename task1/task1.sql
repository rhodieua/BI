
-- Database SQLite

CREATE TABLE t1 (
 Field1 INT,
 Field2 INT,
 Field3 INT,
 Field4 INT,
 Field5 INT,
 Field6 INT,
 Field7 INT
)

DELETE FROM t1 

INSERT INTO t1
--VALUES (2, 43, -11, 76, 21, 243, 55)   -- 1 1 1 0 0 0 1
--VALUES (27, 3, 411, 32, -121, 32, 97) -- 1 0 0 1 1 1 1
--VALUES (13, 87, 6, 24, 119, 38, 41)    -- 1 1 1 0 0 1 0
--VALUES (91, 54, 4, 65, 9, 10, 122)      -- 1 1 1 0 1 1 1
--VALUES (1, 2, 3, 4, 5, 6, 7)                -- 1 0 1 0 0 1 1
--VALUES (7, 6, 5, 4, 3, 2, 1)                -- 1 1 0 0 0 0 0
--VALUES (-1, 0, 1, 2, 3, 4, 5)               -- 0 0 1 0 0 1 1
VALUES (-1, -2, -3, -4, -5, 92, 91)         -- 0 1 0 0 1 0 1

SELECT * FROM t1

SELECT *
FROM t1 
WHERE (
 (Field1>=0) +
 (Field2>=Field3) +
 (Field3<Field5) +
 (Field4=Field6) +
 (Field7>80) +
 (Field6<Field7) +
 (Field7>Field2)
 ) % 2 = 0
