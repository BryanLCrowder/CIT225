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

-- Set SQL*Plus environmnet variables.
SET ECHO ON
SET FEEDBACK ON
SET NULL '<Null>'
SET PAGESIZE 999
SET SERVEROUTPUT ON

-- ------------------------------------------------------------------
--  Call scripts to create tables.
-- ------------------------------------------------------------------
@@system_user.sql
@@common_lookup.sql
@@member.sql
@@contact.sql
@@address.sql
@@street_address.sql
@@telephone.sql
@@rental.sql
@@item.sql
@@rental_item.sql

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

-- Close log file.
SPOOL OFF
