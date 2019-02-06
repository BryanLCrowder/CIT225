-- ------------------------------------------------------------------
--  Program Name:   create_oracle_store.sql
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
@@/home/student/Data/cit225/oracle/lab1/apply_oracle_lab1.sql
-- Set SQL*Plus environmnet variables.
SET ECHO ON
SET FEEDBACK ON
SET NULL '<Null>'
SET PAGESIZE 999
SET SERVEROUTPUT ON

-- ------------------------------------------------------------------
--  Call scripts to create tables.
-- ------------------------------------------------------------------
@@system_user_lab.sql
@@common_lookup_lab.sql
@@member_lab.sql
@@contact_lab.sql
@@address_lab.sql
@@street_address_lab.sql
@@telephone_lab.sql
@@rental_lab.sql
@@item_lab.sql
@@rental_item_lab.sql

-- Open log file.
SPOOL create_oracle_store2.txt

COLUMN table_name_base     FORMAT A30 HEADING "Base Tables"
COLUMN sequence_name_base  FORMAT A30 HEADING "Base Sequences"
SELECT   a.table_name_base
,        b.sequence_name_base
FROM    (SELECT   table_name AS table_name_base
         FROM     user_tables
         WHERE    table_name IN ('SYSTEM_USER'
                                ,'COMMON_LOOKUP'
                                ,'MEMBER'
                                ,'CONTACT'
                                ,'ADDRESS'
                                ,'STREET_ADDRESS'
                                ,'TELEPHONE'
                                ,'ITEM'
                                ,'RENTAL'
                                ,'RENTAL_ITEM')) a  INNER JOIN
        (SELECT   sequence_name AS sequence_name_base
         FROM     user_sequences
         WHERE    sequence_name IN ('SYSTEM_USER_S1'
                                   ,'COMMON_LOOKUP_S1'
                                   ,'MEMBER_S1'
                                   ,'CONTACT_S1'
                                   ,'ADDRESS_S1'
                                   ,'STREET_ADDRESS_S1'
                                   ,'TELEPHONE_S1'
                                   ,'ITEM_S1'
                                   ,'RENTAL_S1'
                                   ,'RENTAL_ITEM_S1')) b
ON       a.table_name_base =
           SUBSTR( b.sequence_name_base, 1, REGEXP_INSTR(b.sequence_name_base,'_S1') - 1)
ORDER BY CASE
           WHEN table_name_base LIKE 'SYSTEM_USER%' THEN 0
           WHEN table_name_base LIKE 'COMMON_LOOKUP%' THEN 1
           WHEN table_name_base LIKE 'MEMBER%' THEN 2
           WHEN table_name_base LIKE 'CONTACT%' THEN 3
           WHEN table_name_base LIKE 'ADDRESS%' THEN 4
           WHEN table_name_base LIKE 'STREET_ADDRESS%' THEN 5
           WHEN table_name_base LIKE 'TELEPHONE%' THEN 6
           WHEN table_name_base LIKE 'ITEM%' THEN 7
           WHEN table_name_base LIKE 'RENTAL%' AND NOT table_name_base LIKE 'RENTAL_ITEM%' THEN 8
           WHEN table_name_base LIKE 'RENTAL_ITEM%' THEN 9
         END;
         
         
         
         COLUMN table_name_base FORMAT A30 HEADING "Base Tables"
COLUMN table_name_lab  FORMAT A30 HEADING "Lab Tables"
SELECT   a.table_name_base
,        b.table_name_lab
FROM    (SELECT   table_name AS table_name_base
         FROM     user_tables
         WHERE    table_name IN ('SYSTEM_USER'
                                ,'COMMON_LOOKUP'
                                ,'MEMBER'
                                ,'CONTACT'
                                ,'ADDRESS'
                                ,'STREET_ADDRESS'
                                ,'TELEPHONE'
                                ,'ITEM'
                                ,'RENTAL'
                                ,'RENTAL_ITEM')) a INNER JOIN
        (SELECT   table_name AS table_name_lab
         FROM     user_tables
         WHERE    table_name IN ('SYSTEM_USER_LAB'
                                ,'COMMON_LOOKUP_LAB'
                                ,'MEMBER_LAB'
                                ,'CONTACT_LAB'
                                ,'ADDRESS_LAB'
                                ,'STREET_ADDRESS_LAB'
                                ,'TELEPHONE_LAB'
                                ,'ITEM_LAB'
                                ,'RENTAL_LAB'
                                ,'RENTAL_ITEM_LAB')) b
ON       a.table_name_base = SUBSTR( b.table_name_lab, 1, REGEXP_INSTR(table_name_lab,'_LAB') - 1)
ORDER BY CASE
           WHEN table_name_base LIKE 'SYSTEM_USER%' THEN 0
           WHEN table_name_base LIKE 'COMMON_LOOKUP%' THEN 1
           WHEN table_name_base LIKE 'MEMBER%' THEN 2
           WHEN table_name_base LIKE 'CONTACT%' THEN 3
           WHEN table_name_base LIKE 'ADDRESS%' THEN 4
           WHEN table_name_base LIKE 'STREET_ADDRESS%' THEN 5
           WHEN table_name_base LIKE 'TELEPHONE%' THEN 6
           WHEN table_name_base LIKE 'ITEM%' THEN 7
           WHEN table_name_base LIKE 'RENTAL%' AND NOT table_name_base LIKE 'RENTAL_ITEM%' THEN 8
           WHEN table_name_base LIKE 'RENTAL_ITEM%' THEN 9
         END;

         COLUMN sequence_name_base FORMAT A30 HEADING "Base Sequences"
COLUMN sequence_name_lab  FORMAT A30 HEADING "Lab Sequences"
SELECT   a.sequence_name_base
,        b.sequence_name_lab
FROM    (SELECT   sequence_name AS sequence_name_base
         FROM     user_sequences
         WHERE    sequence_name IN ('SYSTEM_USER_S1'
                                   ,'COMMON_LOOKUP_S1'
                                   ,'MEMBER_S1'
                                   ,'CONTACT_S1'
                                   ,'ADDRESS_S1'
                                   ,'STREET_ADDRESS_S1'
                                   ,'TELEPHONE_S1'
                                   ,'ITEM_S1'
                                   ,'RENTAL_S1'
                                   ,'RENTAL_ITEM_S1')) a INNER JOIN
        (SELECT   sequence_name AS sequence_name_lab
         FROM     user_sequences
         WHERE    sequence_name IN ('SYSTEM_USER_LAB_S1'
                                   ,'COMMON_LOOKUP_LAB_S1'
                                   ,'MEMBER_LAB_S1'
                                   ,'CONTACT_LAB_S1'
                                   ,'ADDRESS_LAB_S1'
                                   ,'STREET_ADDRESS_LAB_S1'
                                   ,'TELEPHONE_LAB_S1'
                                   ,'ITEM_LAB_S1'
                                   ,'RENTAL_LAB_S1'
                                   ,'RENTAL_ITEM_LAB_S1')) b
ON       SUBSTR(a.sequence_name_base, 1, REGEXP_INSTR(a.sequence_name_base,'_S1') - 1) =
           SUBSTR( b.sequence_name_lab, 1, REGEXP_INSTR(b.sequence_name_lab,'_LAB_S1') - 1)
ORDER BY CASE
           WHEN sequence_name_base LIKE 'SYSTEM_USER%' THEN 0
           WHEN sequence_name_base LIKE 'COMMON_LOOKUP%' THEN 1
           WHEN sequence_name_base LIKE 'MEMBER%' THEN 2
           WHEN sequence_name_base LIKE 'CONTACT%' THEN 3
           WHEN sequence_name_base LIKE 'ADDRESS%' THEN 4
           WHEN sequence_name_base LIKE 'STREET_ADDRESS%' THEN 5
           WHEN sequence_name_base LIKE 'TELEPHONE%' THEN 6
           WHEN sequence_name_base LIKE 'ITEM%' THEN 7
           WHEN sequence_name_base LIKE 'RENTAL%' AND NOT sequence_name_base LIKE 'RENTAL_ITEM%' THEN 8
           WHEN sequence_name_base LIKE 'RENTAL_ITEM%' THEN 9
         END;
         
         
         
-- Close log file.
SPOOL OFF
