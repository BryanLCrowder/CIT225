-- ------------------------------------------------------------------
-- Call the prior lab.
-- ------------------------------------------------------------------
 
@@/home/student/Data/cit225/oracle/lab9/apply_oracle_lab9.sql
 
-- Open log file.  
SPOOL apply_oracle_lab8.txt
 
-- --------------------------------------------------------
--  Step #1
--  -------
--  Using the query from Lab 7, Step 4, insert the 135
--  rows in the PRICE table created in Lab 6.
-- --------------------------------------------------------
 
 
 
SELECT   DISTINCT c.contact_id
FROM     member m INNER JOIN transaction_upload tu
ON       m.account_number = tu.account_number INNER JOIN contact c
ON       m.member_id = c.member_id
WHERE    c.first_name = tu.first_name
AND      NVL(c.middle_name,'x') = NVL(tu.middle_name,'x')
AND      c.last_name = tu.last_name
ORDER BY c.contact_id;
 
 SET NULL '<Null>'
COLUMN rental_id        FORMAT 9999 HEADING "Rental|ID #"
COLUMN customer         FORMAT 9999 HEADING "Customer|ID #"
COLUMN check_out_date   FORMAT A9   HEADING "Check Out|Date"
COLUMN return_date      FORMAT A10  HEADING "Return|Date"
COLUMN created_by       FORMAT 9999 HEADING "Created|By"
COLUMN creation_date    FORMAT A10  HEADING "Creation|Date"
COLUMN last_updated_by  FORMAT 9999 HEADING "Last|Update|By"
COLUMN last_update_date FORMAT A10  HEADING "Last|Updated"
INSERT INTO rental
SELECT   NVL(r.rental_id,rental_s1.NEXTVAL) AS rental_id
,        r.contact_id
,        r.check_out_date
,        r.return_date
,        r.created_by
,        r.creation_date
,        r.last_updated_by
,        r.last_update_date
FROM    (SELECT   DISTINCT
                  r.rental_id
         ,        c.contact_id
         ,        tu.check_out_date AS check_out_date
         ,        tu.return_date AS return_date
         ,        1001 AS created_by
         ,        TRUNC(SYSDATE) AS creation_date
         ,        1001 AS last_updated_by
         ,        TRUNC(SYSDATE) AS last_update_date
         FROM     member m INNER JOIN contact c
         ON       m.member_id = c.member_id INNER JOIN transaction_upload tu
         ON       c.first_name = tu.first_name
         AND      NVL(c.middle_name,'x') = NVL(tu.middle_name,'x')
         AND      c.last_name = tu.last_name LEFT JOIN rental r
         ON       c.contact_id = r.customer_id
         AND      TRUNC(r.check_out_date) = TRUNC(tu.check_out_date)
         AND      TRUNC(r.return_date) = TRUNC(tu.return_date)) r;
 
 
COL rental_count FORMAT 999,999 HEADING "Rental|after|Count"
SELECT   COUNT(*) AS rental_count
FROM     rental;

-- --------------------------------------------------------
--  Step #2
--  -------
--  Add a NOT NULL constraint on the PRICE_TYPE column
--  of the PRICE table.
-- --------------------------------------------------------

COL rental_item_count FORMAT 999,999 HEADING "Rental|Item|Before|Count"
SELECT   COUNT(*) AS rental_item_count
FROM     rental_item;

INSERT INTO rental_item
(SELECT   NVL(ri.rental_item_id,rental_item_s1.NEXTVAL)
 ,        r.rental_id
 ,        tu.item_id
 ,        1 AS created_by
 ,        TRUNC(SYSDATE) AS creation_date
 ,        1 AS last_updated_by
 ,        TRUNC(SYSDATE) AS last_update_date
 ,        cl1.common_lookup_id AS rental_item_type
 ,        r.return_date - r.check_out_date AS rental_item_price
 FROM     member m INNER JOIN contact c
 ON       m.member_id = c.member_id INNER JOIN transaction_upload tu
 ON       c.first_name = tu.first_name
 AND      NVL(c.middle_name,'x') = NVL(tu.middle_name,'x')
 AND      c.last_name = tu.last_name
 AND      tu.account_number = m.account_number LEFT JOIN rental r
 ON       c.contact_id = r.customer_id
 AND      TRUNC(r.check_out_date) = TRUNC(tu.check_out_date)
 AND      TRUNC(r.return_date) = TRUNC(tu.return_date)
 LEFT JOIN common_lookup cl1
 ON      cl1.common_lookup_table = 'RENTAL_ITEM'
 AND     cl1.common_lookup_column = 'RENTAL_ITEM_TYPE'
 AND     cl1.common_lookup_type = tu.rental_item_type LEFT JOIN rental_item ri
 on      r.rental_id = ri.rental_id
 );

 
COL rental_item_count FORMAT 999,999 HEADING "Rental|Item|after|Count"
SELECT   COUNT(*) AS rental_item_count
FROM     rental_item;


-- --------------------------------------------------------
--  Step #3
--  -------
--  Update the RENTAL_ITEM_PRICE column with valid price
--  values in the RENTAL_ITEM table.
-- --------------------------------------------------------
 
INSERT INTO TRANSACTION
SELECT   NVL(t.transaction_id,transaction_s1.NEXTVAL) transaction_id
,        t.transaction_account
,        t.transaction_type
,        t.transaction_date
,        t.transaction_amount
,        t.rental_id
,        t.payment_method_type
,        t.payment_account_number
,        t.created_by
,        t.creation_date
,        t.last_updated_by
,        t.last_update_date
FROM    (SELECT   t.transaction_id
         ,        tu.payment_account_number AS transaction_account
         ,        cl1.common_lookup_id AS transaction_type
         ,        tu.transaction_date
         ,       (SUM(tu.transaction_amount) / 1.06) AS transaction_amount
         ,        r.rental_id
         ,        cl2.common_lookup_id AS payment_method_type
         ,        m.credit_card_number AS payment_account_number
         ,        1001 AS created_by
         ,        TRUNC(SYSDATE) AS creation_date
         ,        1001 AS last_updated_by
         ,        TRUNC(SYSDATE) AS last_update_date
         FROM     member m INNER JOIN contact c
         ON       m.member_id = c.member_id INNER JOIN transaction_upload tu
         ON       c.first_name = tu.first_name
         AND      NVL(c.middle_name,'x') = NVL(tu.middle_name,'x')
         AND      c.last_name = tu.last_name LEFT JOIN rental r
         ON       c.contact_id = r.customer_id
         AND      TRUNC(r.check_out_date) = TRUNC(tu.check_out_date)
         AND      TRUNC(r.return_date) = TRUNC(tu.return_date)
         INNER JOIN common_lookup cl1
         ON      cl1.common_lookup_table = 'TRANSACTION'
         AND     cl1.common_lookup_column = 'TRANSACTION_TYPE'
         AND     cl1.common_lookup_type = tu.transaction_type 
         INNER JOIN common_lookup cl2
         ON      cl2.common_lookup_table = 'TRANSACTION'
         AND     cl2.common_lookup_column = 'PAYMENT_METHOD_TYPE'
         AND     cl2.common_lookup_type = tu.payment_method_type 
         LEFT JOIN transaction t
         ON  t.TRANSACTION_ACCOUNT = tu.account_number
         AND t.rental_id = r.rental_id
         AND t.transaction_type = cl2.common_lookup_id
         AND t.TRANSACTION_DATE = tu.transaction_date
         AND t.TRANSACTION_AMOUNT = tu.TRANSACTION_AMOUNT
         AND t.PAYMENT_METHOD_type = cl2.common_lookup_id
         AND t.PAYMENT_ACCOUNT_NUMBER = m.credit_card_number
         GROUP BY t.transaction_id
         ,        tu.payment_account_number
         ,        cl1.common_lookup_id
         ,        tu.transaction_date
         ,        r.rental_id
         ,        cl2.common_lookup_id
         ,        m.credit_card_number
         ,        1001
         ,        TRUNC(SYSDATE)
         ,        1001
         ,        TRUNC(SYSDATE)) t;
         
         COL transaction_count FORMAT 999,999 HEADING "Transaction|After|Count"
         SELECT   COUNT(*) AS transaction_count
         FROM     TRANSACTION;
-- --------------------------------------------------------
--  Step #4
--  -------
--  Add a NOT NULL constraint on the RENTAL_ITEM_PRICE
--  column of the RENTAL_ITEM table.
-- --------------------------------------------------------
 
-- Insert step #4 statements here.
 
-- Close log file.
SPOOL OFF
 
-- Make all changes permanent.
COMMIT;
