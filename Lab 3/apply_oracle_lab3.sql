-- ------------------------------------------------------------------
--  Program Name:   preseed_oracle_store.sql
--  Lab Assignment: N/A
--  Program Author: Michael McLaughlin
--  Creation Date:  17-Jan-2018
-- ------------------------------------------------------------------
--  Change Log:
-- ------------------------------------------------------------------
--  Change Date    Change Reason
-- -------------  ---------------------------------------------------
--  
-- ------------------------------------------------------------------
-- This creates tables, sequences, indexes, and constraints necessary
-- to begin lesson #3. Demonstrates proper process and syntax.
-- ------------------------------------------------------------------
@@/home/student/Data/cit225/oracle/lab2/apply_oracle_lab2.sql
@@/home/student/Data/cit225/oracle/lib1/preseed/preseed_oracle_store.sql
SPOOL apply_oracle_lab3.txt
-- --------------------------------------------------------
--  Step #1
--  -------
--  Disable foreign key constraints dependencies.
-- --------------------------------------------------------
ALTER TABLE system_user_lab
  DISABLE CONSTRAINT fk_system_user_lab_3;

ALTER TABLE system_user_lab
  DISABLE CONSTRAINT fk_system_user_lab_4;

COL table_name       FORMAT A14  HEADING "Table Name"
COL constraint_name  FORMAT A24  HEADING "Constraint Name"
COL constraint_type  FORMAT A12  HEADING "Constraint Type"
COL status           FORMAT A8   HEADING "Status"
SELECT   table_name
,        constraint_name
,        CASE
           WHEN constraint_type = 'R'        THEN 'FOREIGN KEY'
           WHEN constraint_type = 'P'        THEN 'PRIMARY KEY'
           WHEN constraint_type = 'U'        THEN 'UNIQUE'
           WHEN constraint_type = 'C' AND  REGEXP_LIKE(constraint_name,'^.*nn.*$','i')
           THEN 'NOT NULL'
           ELSE 'CHECK'
         END constraint_type
,        status
FROM     user_constraints
WHERE    table_name = 'SYSTEM_USER_LAB'
ORDER BY CASE
           WHEN constraint_type = 'PRIMARY KEY' THEN 1
           WHEN constraint_type = 'NOT NULL'    THEN 2
           WHEN constraint_type = 'CHECK'       THEN 3
           WHEN constraint_type = 'UNIQUE'      THEN 4
           WHEN constraint_type = 'FOREIGN KEY' THEN 5
         END
,        constraint_name;

-- --------------------------------------------------------
--  Step #2
--  -------
--  Alter the table to remove not null constraints.
-- --------------------------------------------------------
ALTER TABLE system_user_lab
  MODIFY (system_user_group_id  NUMBER  NULL);

ALTER TABLE system_user_lab
  MODIFY (system_user_type  NUMBER  NULL);

COL table_name       FORMAT A14  HEADING "Table Name"
COL constraint_name  FORMAT A24  HEADING "Constraint Name"
COL constraint_type  FORMAT A12  HEADING "Constraint Type"
COL status           FORMAT A8   HEADING "Status"
SELECT   table_name
,        constraint_name
,        CASE
           WHEN constraint_type = 'R'        THEN 'FOREIGN KEY'
           WHEN constraint_type = 'P'        THEN 'PRIMARY KEY'
           WHEN constraint_type = 'U'        THEN 'UNIQUE'
           WHEN constraint_type = 'C' AND  REGEXP_LIKE(constraint_name,'^.*nn.*$','i')
           THEN 'NOT NULL'
           ELSE 'CHECK'
         END constraint_type
,        status
FROM     user_constraints
WHERE    table_name = 'SYSTEM_USER_LAB'
ORDER BY CASE
           WHEN constraint_type = 'PRIMARY KEY' THEN 1
           WHEN constraint_type = 'NOT NULL'    THEN 2
           WHEN constraint_type = 'CHECK'       THEN 3
           WHEN constraint_type = 'UNIQUE'      THEN 4
           WHEN constraint_type = 'FOREIGN KEY' THEN 5
         END
,        constraint_name;

-- --------------------------------------------------------
--  Step #3
--  -------
--  Insert partial data set for preseeded system_user.
-- --------------------------------------------------------
INSERT INTO system_user_lab
( system_user_lab_id
, system_user_name
, system_user_group_id
, system_user_type
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( 1            -- system_user_id
,'SYSADMIN'    -- system_user_name
, null         -- system_user_group_id            
, null         -- system_user_type
, 1            -- created_by
, SYSDATE      -- creation_date
, 1            -- last_updated_by
, SYSDATE      -- last_update_date
);

-- --------------------------------------------------------
--  Step #4
--  -------
--  Disable foreign key constraints dependencies.
-- --------------------------------------------------------
ALTER TABLE common_lookup_lab
  DISABLE CONSTRAINT fk_clookup_lab_1;

ALTER TABLE common_lookup_lab
  DISABLE CONSTRAINT fk_clookup_lab_2;

COL table_name       FORMAT A14  HEADING "Table Name"
COL constraint_name  FORMAT A24  HEADING "Constraint Name"
COL constraint_type  FORMAT A12  HEADING "Constraint Type"
COL status           FORMAT A8   HEADING "Status"
SELECT   table_name
,        constraint_name
,        CASE
           WHEN constraint_type = 'R'        THEN 'FOREIGN KEY'
           WHEN constraint_type = 'P'        THEN 'PRIMARY KEY'
           WHEN constraint_type = 'U'        THEN 'UNIQUE'
           WHEN constraint_type = 'C' AND  REGEXP_LIKE(constraint_name,'^.*nn.*$','i')
           THEN 'NOT NULL'
           ELSE 'CHECK'
         END constraint_type
,        status
FROM     user_constraints
WHERE    table_name = 'COMMON_LOOKUP_LAB'
ORDER BY CASE
           WHEN constraint_type = 'PRIMARY KEY' THEN 1
           WHEN constraint_type = 'NOT NULL'    THEN 2
           WHEN constraint_type = 'CHECK'       THEN 3
           WHEN constraint_type = 'UNIQUE'      THEN 4
           WHEN constraint_type = 'FOREIGN KEY' THEN 5
         END
,        constraint_name;

-- --------------------------------------------------------
--  Step #5
--  -------
--  Insert data set for preseeded common_lookup table.
-- --------------------------------------------------------
INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
 VALUES
( 1                           -- common_lookup_id
,'SYSTEM_USER_LAB'                -- common_lookup_context
,'SYSTEM_ADMIN'               -- common_lookup_type
,'System Administrator'       -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( 2                           -- common_lookup_id
,'SYSTEM_USER_LAB'                -- common_lookup_context
,'DBA'                        -- common_lookup_type
,'Database Administrator'     -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
 VALUES
( 3                           -- common_lookup_id
,'SYSTEM_USER_LAB'                -- common_lookup_context
,'SYSTEM_GROUP'               -- common_lookup_type
,'System Group'              -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
 VALUES
( 4                           -- common_lookup_id
,'SYSTEM_USER_LAB'                -- common_lookup_context
,'COST_CENTER'                -- common_lookup_type
,'Cost Center'                -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
 VALUES
( 5                           -- common_lookup_id
,'SYSTEM_USER_LAB'                -- common_lookup_context
,'INDIVIDUAL'                 -- common_lookup_type
,'Individual'                 -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1001)
,'CONTACT_LAB'                    -- common_lookup_context
,'EMPLOYEE'                   -- common_lookup_type
,'Employee'                   -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1002)
,'CONTACT_LAB'                    -- common_lookup_context
,'CUSTOMER'                   -- common_lookup_type
,'Customer'                   -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1003)
,'MEMBER_LAB'                     -- common_lookup_context
,'INDIVIDUAL'                 -- common_lookup_type
,'Individual Membership'      -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1004)
,'MEMBER_LAB'                     -- common_lookup_context
,'GROUP'                      -- common_lookup_type
,'Group Membership'           -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1005)
,'MEMBER_LAB'                     -- common_lookup_context
,'DISCOVER_CARD'              -- common_lookup_type
,'Discover Card'              -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1006)
,'MEMBER_LAB'                     -- common_lookup_context
,'MASTER_CARD'                -- common_lookup_type
,'Master Card'                -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1007)
,'MEMBER_LAB'                     -- common_lookup_context
,'VISA_CARD'                  -- common_lookup_type
,'Visa Card'                  -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1008)
,'MULTIPLE'                   -- common_lookup_context
,'HOME'                       -- common_lookup_type
,'Home'                       -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1009)
,'MULTIPLE'                   -- common_lookup_context
,'WORK'                       -- common_lookup_type
,'Work'                       -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1010)
,'ITEM_LAB'                       -- common_lookup_context
,'DVD_FULL_SCREEN'            -- common_lookup_type
,'DVD: Full Screen'           -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1011)
,'ITEM_LAB'                       -- common_lookup_context
,'DVD_WIDE_SCREEN'            -- common_lookup_type
,'DVD: Wide Screen'           -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1012)
,'ITEM_LAB'                       -- common_lookup_context
,'NINTENDO_GAMECUBE'          -- common_lookup_type
,'Nintendo Gamecube'          -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1013)
,'ITEM_LAB'                       -- common_lookup_context
,'PLAYSTATION2'               -- common_lookup_type
,'Playstation2'               -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1014)
,'ITEM_LAB'                       -- common_lookup_context
,'XBOX'                       -- common_lookup_type
,'XBOX'                       -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

INSERT INTO common_lookup_lab
( common_lookup_lab_id
, common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( common_lookup_lab_s1.nextval    -- common_lookup_id (1011)
,'ITEM_LAB'                       -- common_lookup_context
,'BLU-RAY'                    -- common_lookup_type
,'Blu-ray'                    -- common_lookup_meaning
, 1                           -- created_by
, SYSDATE                     -- creation_date
, 1                           -- last_updated_by
, SYSDATE                     -- last_update_date
);

-- --------------------------------------------------------
--  Step #6
--  -------
--  Display the preseeded values in the common_lookup table.
-- --------------------------------------------------------
COL common_lookup_id       FORMAT  9999
COL common_lookup_context  FORMAT A22
COL common_lookup_type     FORMAT A16
SELECT   common_lookup_lab_id
,        common_lookup_context
,        common_lookup_type
FROM     common_lookup_lab;

-- --------------------------------------------------------
--  Step #7
--  -------
--  Write two queries using the COMMON_LOOKUP table:
--  --------------------------------------------------
--   One finds the primary key values for the
--   SYSTEM_USER_GROUP_ID in the COMMON_LOOKUP table.
--   Another finds the primary key values for the 
--   SYSTEM_USER_TYPE in the COMMON_LOOKUP table.
--  --------------------------------------------------
--  Both queries use the COMMON_LOOKUP_CONTEXT and
--  COMMON_LOOKUP_TYPE columns.
-- --------------------------------------------------------
SELECT   common_lookup_lab_id
FROM     common_lookup_lab
WHERE    common_lookup_context = 'SYSTEM_USER_LAB'
AND      common_lookup_type = 'SYSTEM_GROUP';

SELECT   common_lookup_lab_id
FROM     common_lookup_lab
WHERE    common_lookup_context = 'SYSTEM_USER_LAB'
AND      common_lookup_type = 'SYSTEM_ADMIN';

-- --------------------------------------------------------
--  Step #8
--  -------
--  Update the SYSTEM_USER_GROUP_ID and SYSTEM_USER_TYPE
--  columns in the SYSTEM_USER table.
-- --------------------------------------------------------
UPDATE system_user_lab
SET    system_user_group_id = 
         (SELECT   common_lookup_lab_id
          FROM     common_lookup_lab
          WHERE    common_lookup_context = 'SYSTEM_USER_LAB'
          AND      common_lookup_type = 'SYSTEM_ADMIN')
WHERE  system_user_lab_id = 1;

-- Display results.
SET NULL '<Null>'
COL system_user_lab_id        FORMAT 999999  HEADING "System|User|ID #"
COL system_user_name      FORMAT A10     HEADING "System|User|Name"
COL system_user_group_id  FORMAT 999999  HEADING "System|User|Group|ID #"
COL system_user_type      FORMAT 999999  HEADING "System|User|Type"
SELECT   system_user_lab_id
,        system_user_name
,        system_user_group_id
,        system_user_type
FROM     system_user_lab
WHERE    system_user_lab_id = 1;

UPDATE system_user_lab
SET    system_user_type = 
         (SELECT   common_lookup_lab_id
          FROM     common_lookup_lab
          WHERE    common_lookup_context = 'SYSTEM_USER_LAB'
          AND      common_lookup_type = 'SYSTEM_GROUP')
WHERE  system_user_lab_id = 1;

-- Display results.
SET NULL '<Null>'
COL system_user_lab_id        FORMAT 999999  HEADING "System|User|ID #"
COL system_user_name      FORMAT A10     HEADING "System|User|Name"
COL system_user_group_id  FORMAT 999999  HEADING "System|User|Group|ID #"
COL system_user_type      FORMAT 999999  HEADING "System|User|Type"
SELECT   system_user_lab_id
,        system_user_name
,        system_user_group_id
,        system_user_type
FROM     system_user_lab
WHERE    system_user_lab_id = 1;

-- --------------------------------------------------------
--  Step #9
--  --------
--  Enable foreign key constraints dependencies.
-- --------------------------------------------------------
-- Enable fk_system_user_3 constraint.
ALTER TABLE system_user_lab
  ENABLE CONSTRAINT fk_system_user_lab_3;

-- Enable fk_system_user_4 constraint.
ALTER TABLE system_user_lab
  ENABLE CONSTRAINT fk_system_user_lab_4;

-- Display system_user table constraints.
COL table_name       FORMAT A14  HEADING "Table Name"
COL constraint_name  FORMAT A24  HEADING "Constraint Name"
COL constraint_type  FORMAT A12  HEADING "Constraint Type"
COL status           FORMAT A8   HEADING "Status"
SELECT   table_name
,        constraint_name
,        CASE
           WHEN constraint_type = 'R'        THEN 'FOREIGN KEY'
           WHEN constraint_type = 'P'        THEN 'PRIMARY KEY'
           WHEN constraint_type = 'U'        THEN 'UNIQUE'
           WHEN constraint_type = 'C' AND  REGEXP_LIKE(constraint_name,'^.*nn.*$','i')
           THEN 'NOT NULL'
           ELSE 'CHECK'
         END constraint_type
,        status
FROM     user_constraints
WHERE    table_name = 'SYSTEM_USER_LAB'
ORDER BY CASE
           WHEN constraint_type = 'PRIMARY KEY' THEN 1
           WHEN constraint_type = 'NOT NULL'    THEN 2
           WHEN constraint_type = 'CHECK'       THEN 3
           WHEN constraint_type = 'UNIQUE'      THEN 4
           WHEN constraint_type = 'FOREIGN KEY' THEN 5
         END
,        constraint_name;

-- Enable fk_clookup_1 constraint.
ALTER TABLE common_lookup_lab
  ENABLE CONSTRAINT fk_clookup_lab_1;

-- Enable fk_clookup_2 constraint.
ALTER TABLE common_lookup_lab
  ENABLE CONSTRAINT fk_clookup_lab_2;

-- Display system_user table constraints.
COL table_name       FORMAT A14  HEADING "Table Name"
COL constraint_name  FORMAT A24  HEADING "Constraint Name"
COL constraint_type  FORMAT A12  HEADING "Constraint Type"
COL status           FORMAT A8   HEADING "Status"
SELECT   table_name
,        constraint_name
,        CASE
           WHEN constraint_type = 'R'        THEN 'FOREIGN KEY'
           WHEN constraint_type = 'P'        THEN 'PRIMARY KEY'
           WHEN constraint_type = 'U'        THEN 'UNIQUE'
           WHEN constraint_type = 'C' AND  REGEXP_LIKE(constraint_name,'^.*nn.*$','i')
           THEN 'NOT NULL'
           ELSE 'CHECK'
         END constraint_type
,        status
FROM     user_constraints
WHERE    table_name = 'COMMON_LOOKUP_LAB'
ORDER BY CASE
           WHEN constraint_type = 'PRIMARY KEY' THEN 1
           WHEN constraint_type = 'NOT NULL'    THEN 2
           WHEN constraint_type = 'CHECK'       THEN 3
           WHEN constraint_type = 'UNIQUE'      THEN 4
           WHEN constraint_type = 'FOREIGN KEY' THEN 5
         END
,        constraint_name;

-- --------------------------------------------------------
--  Step #10
--  --------
--  Alter the table to add not null constraints.
-- --------------------------------------------------------
ALTER TABLE system_user_lab
  MODIFY (system_user_group_id  NUMBER  CONSTRAINT nn_system_user_lab_2 NOT NULL);

ALTER TABLE system_user_lab
  MODIFY (system_user_type      NUMBER  CONSTRAINT nn_system_user_lab_3 NOT NULL);

-- Display system_user table constraints.
COL table_name       FORMAT A14  HEADING "Table Name"
COL constraint_name  FORMAT A24  HEADING "Constraint Name"
COL constraint_type  FORMAT A12  HEADING "Constraint Type"
COL status           FORMAT A8   HEADING "Status"
SELECT   table_name
,        constraint_name
,        CASE
           WHEN constraint_type = 'R'        THEN 'FOREIGN KEY'
           WHEN constraint_type = 'P'        THEN 'PRIMARY KEY'
           WHEN constraint_type = 'U'        THEN 'UNIQUE'
           WHEN constraint_type = 'C' AND  REGEXP_LIKE(constraint_name,'^.*nn.*$','i')
           THEN 'NOT NULL'
           ELSE 'CHECK'
         END constraint_type
,        status
FROM     user_constraints
WHERE    table_name = 'SYSTEM_USER_LAB'
ORDER BY CASE
           WHEN constraint_type = 'PRIMARY KEY' THEN 1
           WHEN constraint_type = 'NOT NULL'    THEN 2
           WHEN constraint_type = 'CHECK'       THEN 3
           WHEN constraint_type = 'UNIQUE'      THEN 4
           WHEN constraint_type = 'FOREIGN KEY' THEN 5
         END
,        constraint_name;

-- --------------------------------------------------------
--  Step #11
--  --------
--  Insert row in the system_user table with subqueries.
-- --------------------------------------------------------
INSERT INTO system_user_lab
( system_user_lab_id
, system_user_name
, system_user_group_id
, system_user_type
, first_name
, middle_name
, last_name
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( system_user_lab_s1.NEXTVAL                          -- system_user_id
,'DBA1'                                           -- system_user_name
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'SYSTEM_USER_LAB'
  AND      common_lookup_type = 'DBA')            -- system_user_group_id            
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'SYSTEM_USER_LAB'
  AND      common_lookup_type = 'SYSTEM_GROUP')   -- system_user_type
,'Phineas'
,'Taylor'
,'Barnum'
,(SELECT   system_user_lab_id
  FROM     system_user_lab
  WHERE    system_user_name = 'SYSADMIN')         -- created_by
, SYSDATE                                         -- creation_date
,(SELECT   system_user_lab_id
  FROM     system_user_lab
  WHERE    system_user_name = 'SYSADMIN')         -- last_updated_by
, SYSDATE                                         -- last_update_date
);

INSERT INTO system_user_lab
( system_user_lab_id
, system_user_name
, system_user_group_id
, system_user_type
, first_name
, last_name
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( system_user_lab_s1.NEXTVAL                          -- system_user_id
,'DBA2'                                           -- system_user_name
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'SYSTEM_USER_LAB'
  AND      common_lookup_type = 'DBA')            -- system_user_group_id            
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'SYSTEM_USER_LAB'
  AND      common_lookup_type = 'SYSTEM_GROUP')   -- system_user_type
,'Phileas'
,'Fogg'
,(SELECT   system_user_lab_id
  FROM     system_user_lab
  WHERE    system_user_name = 'SYSADMIN')         -- created_by
, SYSDATE                                         -- creation_date
,(SELECT   system_user_lab_id
  FROM     system_user_lab
  WHERE    system_user_name = 'SYSADMIN')         -- last_updated_by
, SYSDATE                                         -- last_update_date
);

-- --------------------------------------------------------
--  Step #12
--  --------
--  Display inserted rows from the system_user table.
-- --------------------------------------------------------
SET NULL '<Null>'
COL system_user_lab_id        FORMAT  9999
COL system_user_group_id  FORMAT  9999
COL system_user_type      FORMAT  9999
COL system_user_name      FORMAT  A10
COL full_user_name        FORMAT  A30
SELECT   system_user_lab_id
,        system_user_group_id
,        system_user_type
,        system_user_name
,        CASE
           WHEN last_name IS NOT NULL THEN
             last_name || ', ' || first_name || ' ' || middle_name
         END AS full_user_name
FROM     system_user_lab;

-- Commit changes.
COMMIT;

SPOOL OFF
