-- ------------------------------------------------------------------
--  Program Name:   create_insert_contacts.sql
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
--  This automates creating accounts.
-- ------------------------------------------------------------------
-- ------------------------------------------------------------------
--  Automates inserts of member accounts for individual accounts. 
-- ------------------------------------------------------------------

-- ------------------------------------------------------------------
--  Open log file.
-- ------------------------------------------------------------------
SPOOL create_insert_contacts.txt

-- Transaction Management Example.
CREATE OR REPLACE PROCEDURE contact_insert_lab
( pv_member_type         VARCHAR2
, pv_account_number      VARCHAR2
, pv_credit_card_number  VARCHAR2
, pv_credit_card_type    VARCHAR2
, pv_first_name          VARCHAR2
, pv_middle_name         VARCHAR2 := ''
, pv_last_name           VARCHAR2
, pv_contact_type        VARCHAR2
, pv_address_type        VARCHAR2
, pv_city                VARCHAR2
, pv_state_province      VARCHAR2
, pv_postal_code         VARCHAR2
, pv_street_address      VARCHAR2
, pv_telephone_type      VARCHAR2
, pv_country_code        VARCHAR2
, pv_area_code           VARCHAR2
, pv_telephone_number    VARCHAR2
, pv_created_by          NUMBER   := 1001
, pv_creation_date       DATE     := SYSDATE
, pv_last_updated_by     NUMBER   := 1001
, pv_last_update_date    DATE     := SYSDATE) IS

BEGIN
 
  /* Create a SAVEPOINT as a starting point. */
  SAVEPOINT starting_point;

  /* Insert into the member table. */
  INSERT INTO member_lab
  ( member_lab_id
  , member_type
  , account_number
  , credit_card_number
  , credit_card_type
  , created_by
  , creation_date
  , last_updated_by
  , last_update_date )
  VALUES
  ( member_lab_s1.NEXTVAL
  ,(SELECT   common_lookup_lab_id
    FROM     common_lookup_lab
    WHERE    common_lookup_context = 'MEMBER_LAB'
    AND      common_lookup_type = pv_member_type)
  , pv_account_number
  , pv_credit_card_number
  ,(SELECT   common_lookup_lab_id
    FROM     common_lookup_lab
    WHERE    common_lookup_context = 'MEMBER_LAB'
    AND      common_lookup_type = pv_credit_card_type)
  , pv_created_by
  , pv_creation_date
  , pv_last_updated_by
  , pv_last_update_date );

  /* Insert into the contact table. */
  INSERT INTO contact_lab
  VALUES
  ( contact_lab_s1.NEXTVAL
  , member_lab_s1.CURRVAL
  ,(SELECT   common_lookup_lab_id
    FROM     common_lookup_lab
    WHERE    common_lookup_context = 'CONTACT_LAB'
    AND      common_lookup_type = pv_contact_type)
  , pv_first_name
  , pv_middle_name
  , pv_last_name
  , pv_created_by
  , pv_creation_date
  , pv_last_updated_by
  , pv_last_update_date );  

  /* Insert into the address table. */
  INSERT INTO address_lab
  VALUES
  ( address_lab_s1.NEXTVAL
  , contact_lab_s1.CURRVAL
  ,(SELECT   common_lookup_lab_id
    FROM     common_lookup_lab
    WHERE    common_lookup_context = 'MULTIPLE'
    AND      common_lookup_type = pv_address_type)
  , pv_city
  , pv_state_province
  , pv_postal_code
  , pv_created_by
  , pv_creation_date
  , pv_last_updated_by
  , pv_last_update_date );  

  /* Insert into the street_address table. */
  INSERT INTO street_address_lab
  VALUES
  ( street_address_lab_s1.NEXTVAL
  , address_lab_s1.CURRVAL
  , pv_street_address
  , pv_created_by
  , pv_creation_date
  , pv_last_updated_by
  , pv_last_update_date );  

  /* Insert into the telephone table. */
  INSERT INTO telephone_lab
  VALUES
  ( telephone_lab_s1.NEXTVAL                              -- TELEPHONE_ID
  , contact_lab_s1.CURRVAL                                -- CONTACT_ID
  , address_lab_s1.CURRVAL                                -- ADDRESS_ID
  ,(SELECT   common_lookup_lab_id                         -- ADDRESS_TYPE
    FROM     common_lookup_lab
    WHERE    common_lookup_context = 'MULTIPLE'
    AND      common_lookup_type = pv_telephone_type)
  , pv_country_code                                   -- COUNTRY_CODE
  , pv_area_code                                      -- AREA_CODE
  , pv_telephone_number                               -- TELEPHONE_NUMBER
  , pv_created_by                                     -- CREATED_BY
  , pv_creation_date                                  -- CREATION_DATE
  , pv_last_updated_by                                -- LAST_UPDATED_BY
  , pv_last_update_date);                             -- LAST_UPDATE_DATE

  /* Commit the series of inserts. */
  COMMIT;
EXCEPTION 
  WHEN OTHERS THEN
    ROLLBACK TO starting_point;
    RETURN;
END contact_insert_lab;
/

-- ------------------------------------------------------------------
--  Close log file.
-- ------------------------------------------------------------------
SPOOL OFF

