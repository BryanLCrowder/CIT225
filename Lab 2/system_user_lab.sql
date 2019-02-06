-- ------------------------------------------------------------------
--  Program Name:   system_user_lab.sql
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
-- This creates the system_user table and system_user_s1 sequences.
-- ------------------------------------------------------------------

-- Open log file.
SPOOL system_user_lab.txt

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
  :table_name := UPPER('system_user_lab');
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
CREATE TABLE system_user_lab
( system_user_lab_id              NUMBER
, system_user_name            VARCHAR2(20) CONSTRAINT nn_system_user_lab_1 NOT NULL
, system_user_group_id        NUMBER       CONSTRAINT nn_system_user_lab_2 NOT NULL
, system_user_type            NUMBER       CONSTRAINT nn_system_user_lab_3 NOT NULL
, first_name                  VARCHAR2(20)
, middle_name                 VARCHAR2(20)
, last_name                   VARCHAR2(20)
, created_by                  NUMBER       CONSTRAINT nn_system_user_lab_4 NOT NULL
, creation_date               DATE         CONSTRAINT nn_system_user_lab_5 NOT NULL
, last_updated_by             NUMBER       CONSTRAINT nn_system_user_lab_6 NOT NULL
, last_update_date            DATE         CONSTRAINT nn_system_user_lab_7 NOT NULL
, CONSTRAINT pk_system_user_lab_1 PRIMARY KEY(system_user_lab_id)
, CONSTRAINT fk_system_user_lab_1 FOREIGN KEY(created_by) REFERENCES system_user_lab(system_user_lab_id)
, CONSTRAINT fk_system_user_lab_2 FOREIGN KEY(last_updated_by) REFERENCES system_user_lab(system_user_lab_id));

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
AND      uc.constraint_type = UPPER('c')
ORDER BY uc.constraint_name;

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

-- Create unique index.
CREATE UNIQUE INDEX uq_system_user_lab_1
  ON system_user_lab (system_user_name);

-- Display unique indexes.
COLUMN index_name FORMAT A20 HEADING "Index Name"
SELECT   index_name
FROM     user_indexes
WHERE    table_name = :table_name;

-- Create sequence.
CREATE SEQUENCE system_user_lab_s1 START WITH 1001 NOCACHE;

-- Display sequence.
COLUMN sequence_name FORMAT A20 HEADING "Sequence Name"
SELECT   sequence_name
FROM     user_sequences
WHERE    sequence_name = :table_name||'_S1';

-- Close the log file.
SPOOL OFF

