-- ------------------------------------------------------------------
--  Program Name:   apply_oracle_lab4.sql
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
-- to begin lesson #4. Demonstrates proper process and syntax.
-- ------------------------------------------------------------------
-- Instructions:
-- ------------------------------------------------------------------
-- The two scripts contain spooling commands, which is why there
-- isn't a spooling command in this script. When you run this file
-- you first connect to the Oracle database with this syntax:
--
--   sqlplus student/student@xe
--
-- Then, you call this script with the following syntax:
--
--   sql> @apply_oracle_lab4.sql
--
-- ------------------------------------------------------------------

-- Run the prior lab script.
@/home/student/Data/cit225/oracle/lab3/apply_oracle_lab3.sql
@/home/student/Data/cit225/oracle/lib1/seed/seeding.sql
 
-- ... insert calls to other code script files here ...
-- ------------------------------------------------------------------
-- Call the lab versions of the file.
-- ------------------------------------------------------------------
@@group_account1_lab.sql
@@group_account2_lab.sql
@@group_account3_lab.sql
@@item_inserts_lab.sql
@@create_insert_contacts_lab.sql
@@individual_accounts_lab.sql
@@update_members_lab.sql
@@rental_inserts_lab.sql
@@create_view_lab.sql
 
SPOOL apply_oracle_lab4.txt
-- ------------------------------------------------------------------
--  The following queries should be placed here:
-- ------------------------------------------------------------------
COL account_number  FORMAT A10  HEADING "Account|Number"
COL full_name       FORMAT A20  HEADING "Name|(Last, First MI)"
COL city            FORMAT A12  HEADING "City"
COL state_province  FORMAT A10  HEADING "State"
COL telephone       FORMAT A18  HEADING "Telephone"
SELECT   m.account_number
,        c.last_name || ', ' || c.first_name
||       CASE
           WHEN c.middle_name IS NOT NULL THEN ' ' || SUBSTR(c.middle_name,1,1)
         END AS full_name
,        a.city
,        a.state_province
,        t.country_code || '-(' || t.area_code || ') ' || t.telephone_number AS telephone
FROM     member_lab m INNER JOIN contact_lab c ON m.member_lab_id = c.member_lab_id INNER JOIN
         address_lab a ON c.contact_lab_id = a.contact_lab_id INNER JOIN
         street_address_lab sa ON a.address_lab_id = sa.address_lab_id INNER JOIN
         telephone_lab t ON c.contact_lab_id = t.contact_lab_id AND a.address_lab_id = t.address_lab_id
WHERE    m.member_type = (SELECT common_lookup_lab_id
                          FROM   common_lookup_lab
                          WHERE  common_lookup_context = 'MEMBER_LAB'
                          AND    common_lookup_type = 'INDIVIDUAL');

                          
                          
                          
COLUMN member_lab_id         FORMAT 999999 HEADING "Member|ID"
COLUMN members               FORMAT 999999 HEADING "Member|Qty #"
COLUMN member_type           FORMAT 999999 HEADING "Member|Type|ID #"
COLUMN common_lookup_lab_id  FORMAT 999999 HEADING "Member|Lookup|ID #"
COLUMN common_lookup_type    FORMAT A12    HEADING "Common|Lookup|Type"
SELECT   m.member_lab_id
,        COUNT(contact_lab_id) AS MEMBERS
,        m.member_type
,        cl.common_lookup_lab_id
,        cl.common_lookup_type
FROM     member_lab m INNER JOIN contact_lab c
ON       m.member_lab_id = c.member_lab_id INNER JOIN common_lookup_lab cl
ON       m.member_type = cl.common_lookup_lab_id
GROUP BY m.member_lab_id
,        m.member_type
,        cl.common_lookup_lab_id
,        cl.common_lookup_type
ORDER BY m.member_lab_id;



COL member_lab_id       FORMAT 9999 HEADING "Member|ID #"
COL account_number      FORMAT A10  HEADING "Account|Number"
COL full_name           FORMAT A20  HEADING "Name|(Last, First MI)"
COL rental_lab_id       FORMAT 9999 HEADING "Rent|ID #"
COL rental_item_lab_id  FORMAT 9999 HEADING "Rent|Item|ID #"
COL item_title          FORMAT A26  HEADING "Item Title"
SELECT   m.member_lab_id
,        m.account_number
,        c.last_name || ', ' || c.first_name
||       CASE
           WHEN c.middle_name IS NOT NULL THEN ' ' || SUBSTR(c.middle_name,1,1)
         END AS full_name
,        r.rental_lab_id
,        ri.rental_item_lab_id
,        i.item_title
FROM     member_lab m INNER JOIN contact_lab c ON m.member_lab_id = c.member_lab_id INNER JOIN
         rental_lab r ON c.contact_lab_id = r.customer_lab_id INNER JOIN
         rental_item_lab ri ON r.rental_lab_id = ri.rental_lab_id INNER JOIN
         item_lab i ON ri.item_lab_id = i.item_lab_id
ORDER BY r.rental_lab_id;




COL full_name       FORMAT A16  HEADING "Name|(Last, First MI)"
COL title           FORMAT A30  HEADING "Item Title"
COL check_out_date  FORMAT A11  HEADING "Check|Out|Date"
COL return_date     FORMAT A11  HEADING "Return|Date"
SELECT   cr.full_name
,        cr.title
,        cr.check_out_date
,        cr.return_date 
FROM     current_rental_lab cr;

SPOOL OFF
