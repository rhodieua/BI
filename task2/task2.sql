
-- Database PostgreSQL 9.6, script should be working for Impala as well


CREATE TABLE task2 (
 id_item INT,
 item_name VARCHAR,
 item_price INT,
 timestamp TIMESTAMP,
 deleted BOOL
)

INSERT INTO task2
--VALUES (1, 'sword', 10, current_timestamp, false)
--VALUES (2, 'shield', 20, current_timestamp, false)
--VALUES (3, 'helmet', 15, current_timestamp, false)
--VALUES (2, 'strong shield', 20, current_timestamp, false)
--VALUES (2, 'strong shield', 30, current_timestamp, false)
--VALUES (1, 'sword', 20, current_timestamp, true)
VALUES (3, 'helmet', 10, current_timestamp, false)

-- OR

CREATE TABLE task2_1 (
 id_item INT,
 item_name VARCHAR,
 item_price INT,
 timestamp TIMESTAMP DEFAULT now(),
 deleted BOOL
)

INSERT INTO task2_1 (id_item, item_name, item_price, deleted)
VALUES (1, 'sword', 10, false)




SELECT * FROM task2


--========

CREATE VIEW v_task2 AS
SELECT id_item, item_name, item_price
FROM (
    SELECT 
     id_item, item_name, item_price, deleted,
     rank() OVER (PARTITION BY id_item ORDER BY timestamp DESC)
    FROM task2
) AS t
WHERE rank=1
AND deleted=false


SELECT * FROM v_task2