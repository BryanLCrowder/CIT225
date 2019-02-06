-- ------------------------------------------------------------------
--  Program Name:   system_user_inserts.sql
--  Lab Assignment: N/A
--  Program Author: Michael McLaughlin
--  Creation Date:  30-Jan-2018
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

-- Insert statement demonstrates a mandatory-only column override signature.
-- ------------------------------------------------------------------
-- TIP: When a comment ends the last line, you must use a forward slash on
--      on the next line to run the statement rather than a semicolon.
-- ------------------------------------------------------------------

-- ------------------------------------------------------------------
--  Open log file.
-- ------------------------------------------------------------------
SPOOL create_view.txt

-- --------------------------------------------------------
--  Step #1
--  --------
--   Display the rows in the member and contact tables.
-- --------------------------------------------------------

COL member_lab_id           FORMAT 9999  HEADING "Member|ID #"
COL members_lab            FORMAT 9999  HEADING "Member|#"
COL common_lookup_type  FORMAT A12   HEADING "Common|Lookup Type"
SELECT   m.member_lab_id
,        COUNT(contact_lab_id) AS MEMBERS
,        cl.common_lookup_type
FROM     member_lab m INNER JOIN contact_lab c
ON       m.member_lab_id = c.member_lab_id INNER JOIN common_lookup_lab cl
ON       m.member_type = cl.common_lookup_lab_id
GROUP BY m.member_lab_id
,        m.member_type
,        cl.common_lookup_lab_id
,        cl.common_lookup_type
ORDER BY m.member_lab_id;

-- --------------------------------------------------------
--  Step #2
--  --------
--   Create a view .
-- --------------------------------------------------------
CREATE OR REPLACE VIEW current_rental_lab AS
  SELECT   m.account_number
  ,        c.last_name || ', ' || c.first_name
  ||       CASE
             WHEN c.middle_name IS NOT NULL THEN ' ' || SUBSTR(c.middle_name,1,1)
           END AS full_name
  ,        i.item_title AS title
  ,        i.item_subtitle AS subtitle
  ,        SUBSTR(cl.common_lookup_meaning,1,3) AS product
  ,        r.check_out_date
  ,        r.return_date
  FROM     member_lab m INNER JOIN contact_lab c ON m.member_lab_id = c.member_lab_id INNER JOIN
           rental_lab r ON c.contact_lab_id = r.customer_lab_id INNER JOIN
           rental_item_lab ri ON r.rental_lab_id = ri.rental_lab_id INNER JOIN
           item_lab i ON ri.item_lab_id = i.item_lab_id INNER JOIN
           common_lookup_lab cl ON i.item_type = cl.common_lookup_lab_id
  ORDER BY 1, 2, 3;

-- --------------------------------------------------------
--  Step #3
--  --------
--   Display the content of a view .
-- --------------------------------------------------------
COL full_name      FORMAT A24
COL title          FORMAT A30
COL subtitlei      FORMAT A4
COL product        FORMAT A7
COL check_out_date FORMAT A11
COL return_date    FORMAT A11
SELECT   cr.full_name
,        cr.title
,        cr.check_out_date
,        cr.return_date
FROM     current_rental_lab cr;

-- ------------------------------------------------------------------
--  Close log file.
-- ------------------------------------------------------------------       
SPOOL OFF
