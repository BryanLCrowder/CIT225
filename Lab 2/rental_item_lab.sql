-- ------------------------------------------------------------------
--  Program Name:   rental_item.sql
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
-- This creates the rental_item table and rental_item_s1 sequences.
-- ------------------------------------------------------------------

-- Open log file.
SPOOL rental_item_lab.txt

-- Set SQL*Plus environmnet variables.
SET ECHO ON
SET FEEDBACK ON
SET NULL '<Null>'
SET PAGESIZE 999
SET SERVEROUTPUT ON SIZE UNLIMITED

-- ------------------------------------------------------------------
--  Create and assign bind variable for table name.
-- ------------------------------------------------------------------
VARIABLE table_name     VARCHAR2(30)

BEGIN
  :table_name := UPPER('rental_item_lab');
END;
/

--  Verify table name.
SELECT :table_name FROM dual;

-- ------------------------------------------------------------------
--  Conditionally drop table.
-- ------------------------------------------------------------------
DECLARE
  /* Dynamic cursor. */
  CURSOR c (cv_object_name VARCHAR2) IS
    SELECT o.object_type
    ,      o.object_name
    FROM   user_objects o
    WHERE  o.object_name LIKE UPPER(cv_object_name||'%');
BEGIN
  FOR i IN c(:table_name) LOOP
    IF i.object_type = 'SEQUENCE' THEN
      EXECUTE IMMEDIATE 'DROP '||i.object_type||' '||i.object_name;
    ELSIF i.object_type = 'TABLE' THEN
      EXECUTE IMMEDIATE 'DROP '||i.object_type||' '||i.object_name||' CASCADE CONSTRAINTS';
    END IF;
  END LOOP;
END;
/

-- Create table.
CREATE TABLE rental_item_lab
( rental_item_lab_id          NUMBER
, rental_lab_id                   NUMBER CONSTRAINT nn_rental_item_lab_1 NOT NULL
, item_lab_id                     NUMBER CONSTRAINT nn_rental_item_lab_2 NOT NULL
, created_by                  NUMBER CONSTRAINT nn_rental_item_lab_3 NOT NULL
, creation_date               DATE   CONSTRAINT nn_rental_item_lab_4 NOT NULL
, last_updated_by             NUMBER CONSTRAINT nn_rental_item_lab_5 NOT NULL
, last_update_date            DATE   CONSTRAINT nn_rental_item_lab_6 NOT NULL
, CONSTRAINT pk_rental_item_lab_1 PRIMARY KEY(rental_item_lab_id)
, CONSTRAINT fk_rental_item_lab_1 FOREIGN KEY(rental_lab_id) REFERENCES rental_lab(rental_lab_id)
, CONSTRAINT fk_rental_item_lab_2 FOREIGN KEY(item_lab_id) REFERENCES item_lab(item_lab_id)
, CONSTRAINT fk_rental_item_lab_3 FOREIGN KEY(created_by) REFERENCES system_user_lab(system_user_lab_id)
, CONSTRAINT fk_rental_item_lab_4 FOREIGN KEY(last_updated_by) REFERENCES system_user_lab(system_user_lab_id));

-- Display the table organization.
SET NULL ''
COLUMN table_name   FORMAT A16
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = :table_name
ORDER BY 2;

-- Display non-unique constraints.
COLUMN constraint_name   FORMAT A22
COLUMN search_condition  FORMAT A36
COLUMN constraint_type   FORMAT A1
SELECT   uc.constraint_name
,        uc.search_condition
,        uc.constraint_type
FROM     user_constraints uc INNER JOIN user_cons_columns ucc
ON       uc.table_name = ucc.table_name
AND      uc.constraint_name = ucc.constraint_name
WHERE    uc.table_name = :table_name
AND      uc.constraint_type IN (UPPER('c'),UPPER('p'))
ORDER BY uc.constraint_type DESC
,        uc.constraint_name;

-- Display foreign key constraints.
COL constraint_source FORMAT A38 HEADING "Constraint Name:| Table.Column"
COL references_column FORMAT A40 HEADING "References:| Table.Column"
SELECT   uc.constraint_name||CHR(10)
||      '('||ucc1.table_name||'.'||ucc1.column_name||')' constraint_source
,       'REFERENCES'||CHR(10)
||      '('||ucc2.table_name||'.'||ucc2.column_name||')' references_column
FROM     user_constraints uc
,        user_cons_columns ucc1
,        user_cons_columns ucc2
WHERE    uc.constraint_name = ucc1.constraint_name
AND      uc.r_constraint_name = ucc2.constraint_name
AND      ucc1.position = ucc2.position -- Correction for multiple column primary keys.
AND      uc.constraint_type = 'R'
AND      ucc1.table_name = :table_name
ORDER BY ucc1.table_name
,        uc.constraint_name;

-- Create a sequence.
CREATE SEQUENCE rental_item_lab_s1 START WITH 1001 NOCACHE;

-- Display sequence value.
COLUMN sequence_name FORMAT A20 HEADING "Sequence Name"
SELECT   sequence_name
FROM     user_sequences
WHERE    sequence_name = :table_name||'_S1';

-- Close the log file.
SPOOL OFF
