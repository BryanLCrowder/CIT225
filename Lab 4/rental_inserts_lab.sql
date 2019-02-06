-- ------------------------------------------------------------------
--  Program Name:   rental_inserts.sql
--  Lab Assignment: N/A
--  Program Author: Michael McLaughlin
--  Creation Date:  29-Jan-2018
-- ------------------------------------------------------------------
--  Change Log:
-- ------------------------------------------------------------------
--  Change Date    Change Reason
-- -------------  ---------------------------------------------------
--  
-- ------------------------------------------------------------------
--  This seeds data in the video store model.
--   - Inserts the data in the rental table for 5 records and
--     then inserts 9 dependent records in a non-sequential 
--     order.
--   - A non-sequential order requires that you use subqueries
--     to discover the foreign key values for the inserts.
-- ------------------------------------------------------------------

-- ------------------------------------------------------------------
--  Open log file.
-- ------------------------------------------------------------------
SPOOL rental_inserts.txt

-- ------------------------------------------------------------------
-- Insert 5 records in the RENTAL table.
-- ------------------------------------------------------------------

INSERT INTO rental_lab
( rental_lab_id
, customer_lab_id
, check_out_date
, return_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( rental_lab_s1.nextval
,(SELECT   contact_lab_id
  FROM     contact_lab
  WHERE    last_name = 'Vizquel'
  AND      first_name = 'Oscar')
, TRUNC(SYSDATE)
, TRUNC(SYSDATE) + 5
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO rental_lab
( rental_lab_id
, customer_lab_id
, check_out_date
, return_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( rental_lab_s1.nextval
,(SELECT   contact_lab_id
  FROM     contact_lab
  WHERE    last_name = 'Vizquel'
  AND      first_name = 'Doreen')
, TRUNC(SYSDATE)
, TRUNC(SYSDATE) + 5
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO rental_lab
( rental_lab_id
, customer_lab_id
, check_out_date
, return_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( rental_lab_s1.nextval
,(SELECT   contact_lab_id
  FROM     contact_lab
  WHERE    last_name = 'Sweeney'
  AND      first_name = 'Meaghan')
, TRUNC(SYSDATE)
, TRUNC(SYSDATE) + 5
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO rental_lab
( rental_lab_id
, customer_lab_id
, check_out_date
, return_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( rental_lab_s1.nextval
,(SELECT   contact_lab_id
  FROM     contact_lab
  WHERE    last_name = 'Sweeney'
  AND      first_name = 'Ian')
, TRUNC(SYSDATE)
, TRUNC(SYSDATE) + 5
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO rental_lab
( rental_lab_id
, customer_lab_id
, check_out_date
, return_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( rental_lab_s1.nextval
,(SELECT   contact_lab_id
  FROM     contact_lab
  WHERE    last_name = 'Winn'
  AND      first_name = 'Brian')
, TRUNC(SYSDATE)
, TRUNC(SYSDATE) + 5
, 1001
, SYSDATE
, 1001
, SYSDATE);

-- ------------------------------------------------------------------
-- Insert 9 records in the RENTAL_ITEM table.
-- ------------------------------------------------------------------

INSERT INTO rental_item_lab
( rental_item_lab_id
, rental_lab_id
, item_lab_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_lab_s1.nextval
,(SELECT   r.rental_lab_id
  FROM     rental_lab r
  ,        contact_lab c
  WHERE    r.customer_lab_id = c.contact_lab_id
  AND      c.last_name = 'Vizquel'
  AND      c.first_name = 'Oscar')
,(SELECT   i.item_lab_id
  FROM     item_lab i
  ,        common_lookup_lab cl
  WHERE    i.item_title = 'Star Wars I'
  AND      i.item_subtitle = 'Phantom Menace'
  AND      i.item_type = cl.common_lookup_lab_id
  AND      cl.common_lookup_type = 'DVD_WIDE_SCREEN')
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO rental_item_lab
( rental_item_lab_id
, rental_lab_id
, item_lab_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_lab_s1.nextval
,(SELECT   r.rental_lab_id
  FROM     rental_lab r inner join contact_lab c
  ON       r.customer_lab_id = c.contact_lab_id
  WHERE    c.last_name = 'Vizquel'
  AND      c.first_name = 'Oscar')
,(SELECT   d.item_lab_id
  FROM     item_lab d join common_lookup_lab cl
  ON       d.item_title = 'Star Wars II'
  WHERE    d.item_subtitle = 'Attack of the Clones'
  AND      d.item_type = cl.common_lookup_lab_id
  AND      cl.common_lookup_type = 'DVD_WIDE_SCREEN')
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO rental_item_lab
( rental_item_lab_id
, rental_lab_id
, item_lab_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_lab_s1.nextval
,(SELECT   r.rental_lab_id
  FROM     rental_lab r
  ,        contact_lab c
  WHERE    r.customer_lab_id = c.contact_lab_id
  AND      c.last_name = 'Vizquel'
  AND      c.first_name = 'Oscar')
,(SELECT   d.item_lab_id
  FROM     item_lab d
  ,        common_lookup_lab cl
  WHERE    d.item_title = 'Star Wars III'
  AND      d.item_subtitle = 'Revenge of the Sith'
  AND      d.item_type = cl.common_lookup_lab_id
  AND      cl.common_lookup_type = 'DVD_WIDE_SCREEN')
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO rental_item_lab
( rental_item_lab_id
, rental_lab_id
, item_lab_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_lab_s1.nextval
,(SELECT   r.rental_lab_id
  FROM     rental_lab r
  ,        contact_lab c
  WHERE    r.customer_lab_id = c.contact_lab_id
  AND      c.last_name = 'Vizquel'
  AND      c.first_name = 'Doreen')
,(SELECT   d.item_lab_id
  FROM     item_lab d
  ,        common_lookup_lab cl
  WHERE    d.item_title = 'I Remember Mama'
  AND      d.item_subtitle IS NULL
  AND      d.item_type = cl.common_lookup_lab_id
  AND      cl.common_lookup_type = 'BLU-RAY')
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO rental_item_lab
( rental_item_lab_id
, rental_lab_id
, item_lab_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_lab_s1.nextval
,(SELECT   r.rental_lab_id
  FROM     rental_lab r
  ,        contact_lab c
  WHERE    r.customer_lab_id = c.contact_lab_id
  AND      c.last_name = 'Vizquel'
  AND      c.first_name = 'Doreen')
,(SELECT   d.item_lab_id
  FROM     item_lab d
  ,        common_lookup_lab cl
  WHERE    d.item_title = 'Camelot'
  AND      d.item_subtitle IS NULL
  AND      d.item_type = cl.common_lookup_lab_id
  AND      cl.common_lookup_type = 'BLU-RAY')
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO rental_item_lab
( rental_item_lab_id
, rental_lab_id
, item_lab_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_lab_s1.nextval
,(SELECT   r.rental_lab_id
  FROM     rental_lab r
  ,        contact_lab c
  WHERE    r.customer_lab_id = c.contact_lab_id
  AND      c.last_name = 'Sweeney'
  AND      c.first_name = 'Meaghan')
,(SELECT   d.item_lab_id
  FROM     item_lab d
  ,        common_lookup_lab cl
  WHERE    d.item_title = 'Hook'
  AND      d.item_subtitle IS NULL
  AND      d.item_type = cl.common_lookup_lab_id
  AND      cl.common_lookup_type = 'BLU-RAY')
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO rental_item_lab
( rental_item_lab_id
, rental_lab_id
, item_lab_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_lab_s1.nextval
,(SELECT   r.rental_lab_id
  FROM     rental_lab r
  ,        contact_lab c
  WHERE    r.customer_lab_id = c.contact_lab_id
  AND      c.last_name = 'Sweeney'
  AND      c.first_name = 'Ian')
,(SELECT   d.item_lab_id
  FROM     item_lab d
  ,        common_lookup_lab cl
  WHERE    d.item_title = 'Cars'
  AND      d.item_subtitle IS NULL
  AND      d.item_type = cl.common_lookup_lab_id
  AND      cl.common_lookup_type = 'XBOX')
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO rental_item_lab
( rental_item_lab_id
, rental_lab_id
, item_lab_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_lab_s1.nextval
,(SELECT   r.rental_lab_id
  FROM     rental_lab r
  ,        contact_lab c
  WHERE    r.customer_lab_id = c.contact_lab_id
  AND      c.last_name = 'Winn'
  AND      c.first_name = 'Brian')
,(SELECT   d.item_lab_id
  FROM     item_lab d
  ,        common_lookup_lab cl
  WHERE    d.item_title = 'RoboCop'
  AND      d.item_subtitle IS NULL
  AND      d.item_type = cl.common_lookup_lab_id
  AND      cl.common_lookup_type = 'XBOX')
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO rental_item_lab
( rental_item_lab_id
, rental_lab_id
, item_lab_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_lab_s1.nextval
,(SELECT   r.rental_lab_id
  FROM     rental_lab r
  ,        contact_lab c
  WHERE    r.customer_lab_id = c.contact_lab_id
  AND      c.last_name = 'Winn'
  AND      c.first_name = 'Brian')
,(SELECT   d.item_lab_id
  FROM     item_lab d
  ,        common_lookup_lab cl
  WHERE    d.item_title = 'The Hunt for Red October'
  AND      d.item_subtitle = 'Special Collector''s Edition'
  AND      d.item_type = cl.common_lookup_lab_id
  AND      cl.common_lookup_type = 'DVD_WIDE_SCREEN')
, 1001
, SYSDATE
, 1001
, SYSDATE);

-- ------------------------------------------------------------------
--   Query to verify nine rental agreements, some with one and some
--   with more than one rental item.
-- ------------------------------------------------------------------
COL member_id       FORMAT 9999 HEADING "Member|ID #"
COL account_number  FORMAT A10  HEADING "Account|Number"
COL full_name       FORMAT A20  HEADING "Name|(Last, First MI)"
COL rental_id       FORMAT 9999 HEADING "Rent|ID #"
COL rental_item_id  FORMAT 9999 HEADING "Rent|Item|ID #"
COL item_title      FORMAT A26  HEADING "Item Title"
SELECT   m.member_id
,        m.account_number
,        c.last_name || ', ' || c.first_name
||       CASE
           WHEN c.middle_name IS NOT NULL THEN ' ' || SUBSTR(c.middle_name,1,1)
         END AS full_name
,        r.rental_id
,        ri.rental_item_id
,        i.item_title
FROM     member m INNER JOIN contact c ON m.member_id = c.member_id INNER JOIN
         rental r ON c.contact_id = r.customer_id INNER JOIN
         rental_item ri ON r.rental_id = ri.rental_id INNER JOIN
         item i ON ri.item_id = i.item_id
ORDER BY r.rental_id;

-- Commit changes.
COMMIT;

-- ------------------------------------------------------------------
--  Close log file.
-- ------------------------------------------------------------------
SPOOL OFF
