-- ------------------------------------------------------------------
--  Program Name:   individual_accounts.sql
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
--  This inserts 5 individual accounts through procedure.
-- ------------------------------------------------------------------

-- ------------------------------------------------------------------
--  Open log file.
-- ------------------------------------------------------------------
SPOOL individual_accounts.txt

-- Insert first contact.
BEGIN
  /* Call the contact_insert procedure. */
  contact_insert_lab(
      pv_member_type => 'INDIVIDUAL'
    , pv_account_number => 'R11-514-34'
    , pv_credit_card_number => '1111-1111-1111-1111'
    , pv_credit_card_type => 'VISA_CARD'
    , pv_first_name => 'Goeffrey'
    , pv_middle_name => 'Ward'
    , pv_last_name => 'Clinton'
    , pv_contact_type => 'CUSTOMER'
    , pv_address_type => 'HOME'
    , pv_city => 'Provo'
    , pv_state_province => 'Utah'
    , pv_postal_code => '84606'
    , pv_street_address => '118 South 9th East'
    , pv_telephone_type => 'HOME'
    , pv_country_code => '001'
    , pv_area_code => '801'
    , pv_telephone_number => '423-1234' );
END;
/

-- Insert second contact.
BEGIN
  /* Call athe contact_insert procedure. */
  contact_insert_lab(
      pv_member_type => 'INDIVIDUAL'
    , pv_account_number => 'R11-514-35'
    , pv_credit_card_number => '1111-2222-1111-1111'
    , pv_credit_card_type => 'VISA_CARD'
    , pv_first_name => 'Wendy'
    , pv_last_name => 'Moss'
    , pv_contact_type => 'CUSTOMER'
    , pv_address_type => 'HOME'
    , pv_city => 'Provo'
    , pv_state_province => 'Utah'
    , pv_postal_code => '84606'
    , pv_street_address => '1218 South 10th East'
    , pv_telephone_type => 'HOME'
    , pv_country_code => '001'
    , pv_area_code => '801'
    , pv_telephone_number => '423-1235' );
END;
/

-- Insert third contact.
BEGIN
  /* Call the contact_insert procedure. */
  contact_insert_lab(
      pv_member_type => 'INDIVIDUAL'
    , pv_account_number => 'R11-514-36'
    , pv_credit_card_number => '1111-1111-2222-1111'
    , pv_credit_card_type => 'VISA_CARD'
    , pv_first_name => 'Simon'
    , pv_middle_name => 'Jonah'
    , pv_last_name => 'Gretelz'
    , pv_contact_type => 'CUSTOMER'
    , pv_address_type => 'HOME'
    , pv_city => 'Provo'
    , pv_state_province => 'Utah'
    , pv_postal_code => '84606'
    , pv_street_address => '2118 South 7th East'
    , pv_telephone_type => 'HOME'
    , pv_country_code => '001'
    , pv_area_code => '801'
    , pv_telephone_number => '423-1236' );
END;
/

-- Insert fourth contact.
BEGIN
  /* Call the contact_insert procedure. */
  contact_insert_lab(
      pv_member_type => 'INDIVIDUAL'
    , pv_account_number => 'R11-514-37'
    , pv_credit_card_number => '3333-1111-1111-2222'
    , pv_credit_card_type => 'VISA_CARD'
    , pv_first_name => 'Elizabeth'
    , pv_middle_name => 'Jane'
    , pv_last_name => 'Royal'
    , pv_contact_type => 'CUSTOMER'
    , pv_address_type => 'HOME'
    , pv_city => 'Provo'
    , pv_state_province => 'Utah'
    , pv_postal_code => '84606'
    , pv_street_address => '2228 South 14th East'
    , pv_telephone_type => 'HOME'
    , pv_country_code => '001'
    , pv_area_code => '801'
    , pv_telephone_number => '423-1237' );
END;
/

-- Insert fifth contact.
BEGIN
  /* Call the contact_insert procedure. */
  contact_insert_lab(
      pv_member_type => 'INDIVIDUAL'
    , pv_account_number => 'R11-514-38'
    , pv_credit_card_number => '1111-1111-3333-1111'
    , pv_credit_card_type => 'VISA_CARD'
    , pv_first_name => 'Brian'
    , pv_middle_name => 'Nathan'
    , pv_last_name => 'Smith'
    , pv_contact_type => 'CUSTOMER'
    , pv_address_type => 'HOME'
    , pv_city => 'Spanish Fork'
    , pv_state_province => 'Utah'
    , pv_postal_code => '84606'
    , pv_street_address => '333 North 2nd East'
    , pv_telephone_type => 'HOME'
    , pv_country_code => '001'
    , pv_area_code => '801'
    , pv_telephone_number => '423-1238' );
END;
/

-- ------------------------------------------------------------------
--   Query to verify five individual rows of chained inserts through
--   a procedure into the five dependent tables.
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
-- Commit changes.
COMMIT;

-- ------------------------------------------------------------------
--  Close log file.
-- ------------------------------------------------------------------
SPOOL OFF

