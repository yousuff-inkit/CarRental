Added missing table.

```
CREATE TABLE an_taskcreation (
    docno INT PRIMARY KEY AUTO_INCREMENT,  -- or use SEQUENCE for Oracle
    reftype VARCHAR(50),
    refno VARCHAR(50),
    sdate DATE,
    stime VARCHAR(10),
    hiduser VARCHAR(50),
    description TEXT,
    userid VARCHAR(50),        -- user who created the task
    placeholder_field VARCHAR(50), -- 8th parameter (unused or optional)
    edc_date DATE,

    -- Fields required for your SELECT query:
    close_status TINYINT DEFAULT 0,        -- 0 = open, 1 = closed
    utype VARCHAR(20),                     -- user type (e.g., 'app', others)
    act_status VARCHAR(50),                -- task status (e.g., 'Open', 'In Progress', etc.)
    ass_user VARCHAR(50)                   -- assigned user ID
);
```


Alter table to add new colum.
```
ALTER TABLE my_powr
ADD COLUMN `view` SMALLINT(1) UNSIGNED DEFAULT 0;

```