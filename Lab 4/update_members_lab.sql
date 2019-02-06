-- ------------------------------------------------------------------
--  Program Name:   update_members.sql
--  Lab Assignment: N/A
--  Program Author: Michael McLaughlin
--  Creation Date:  25-Jan-2018
-- ------------------------------------------------------------------
--  Change Log:
-- ------------------------------------------------------------------
--  Change Date    Change Reason
-- -------------  ---------------------------------------------------
--  
-- ------------------------------------------------------------------
-- These steps modify the MEMBER table created during Lab #2, by adding
-- a MEMBER_TYPE column and seeding an appropriate group or individual 
-- account on the basis of how many contacts belong to a member.
-- ------------------------------------------------------------------

-- ------------------------------------------------------------------
--  Open log file.
-- ------------------------------------------------------------------
SPOOL update_members.txt

-- Update all MEMBER_TYPE values based on number of dependent CONTACT rows.
UPDATE member_lab m
SET    member_type =
        (SELECT   common_lookup_lab_id
         FROM     common_lookup_lab
         WHERE    common_lookup_context = 'MEMBER_LAB'
         AND      common_lookup_type =
                   (SELECT  dt.member_type
                    FROM   (SELECT   c.member_lab_id
                            ,        CASE
                                       WHEN COUNT(c.member_lab_id) > 1 THEN 'GROUP'
                                       ELSE 'INDIVIDUAL'
                                     END AS member_type
                            FROM     contact_lab c
                            GROUP BY c.member_lab_id) dt
                    WHERE    dt.member_lab_id = m.member_lab_id));

-- Modify the MEMBER table to add a NOT NULL constraint to the MEMBER_TYPE column.
ALTER TABLE member
  MODIFY (member_type  NUMBER  CONSTRAINT nn_member_lab_1  NOT NULL);

-- Use SQL*Plus report formatting commands.
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

-- Commit changes.
COMMIT;

-- ------------------------------------------------------------------
--  Close log file.
-- ------------------------------------------------------------------
SPOOL OFF
                            
