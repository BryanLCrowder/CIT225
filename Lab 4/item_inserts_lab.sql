-- ------------------------------------------------------------------
--  Program Name:   item_inserts.sql
--  Lab Assignment: N/A
--  Program Author: Michael McLaughlin
--  Creation Date:  30-Jan-2018
-- ------------------------------------------------------------------
--  Change Log:
-- ------------------------------------------------------------------
--  Change Date    Change Reason
-- -------------  ---------------------------------------------------

-- ------------------------------------------------------------------
--  Open log file.
-- ------------------------------------------------------------------
SPOOL item_inserts.txt

-- ------------------------------------------------------------------
--  This seeds rows in a item table.
-- ------------------------------------------------------------------
--  - Insert 21 rows in the ITEM table.
-- ------------------------------------------------------------------

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'9736-05640-4'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'DVD_WIDE_SCREEN')
,'The Hunt for Red October'
,'Special Collector''s Edition'
,'PG'
,'02-MAR-90'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'24543-02392'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'DVD_WIDE_SCREEN')
,'Star Wars I'
,'Phantom Menace'
,'PG'
,'04-MAY-99'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'24543-5615'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'DVD_FULL_SCREEN')
,'Star Wars II'
,'Attack of the Clones'
,'PG'
,'16-MAY-02'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab 
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'24543-05539'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'DVD_WIDE_SCREEN')
,'Star Wars II'
,'Attack of the Clones'
,'PG'
,'16-MAY-02'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'24543-20309'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'DVD_WIDE_SCREEN')
,'Star Wars III'
,'Revenge of the Sith'
,'PG13'
,'19-MAY-05'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'86936-70380'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'DVD_WIDE_SCREEN')
,'The Chronicles of Narnia'
,'The Lion, the Witch and the Wardrobe','PG'
,'16-MAY-02'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'91493-06475'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'XBOX')
,'RoboCop'
,''
,'Mature'
,'24-JUL-03'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'93155-11810'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'XBOX')
,'Pirates of the Caribbean'
,''
,'Teen'
,'30-JUN-03'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'12725-00173'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'XBOX')
,'The Chronicles of Narnia'
,'The Lion, the Witch and the Wardrobe'
,'Everyone'
,'30-JUN-03'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'45496-96128'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'NINTENDO_GAMECUBE')
,'MarioKart'
,'Double Dash'
,'Everyone'
,'17-NOV-03'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'08888-32214'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'PLAYSTATION2')
,'Splinter Cell'
,'Chaos Theory'
,'Teen'
,'08-APR-03'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'14633-14821'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'PLAYSTATION2')
,'Need for Speed'
,'Most Wanted'
,'Everyone'
,'15-NOV-04'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'10425-29944'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'XBOX')
,'The DaVinci Code'
,''
,'Teen'
,'19-MAY-06'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'52919-52057'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'XBOX')
,'Cars'
,''
,'Everyone'
,'28-APR-06'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'9689-80547-3'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'BLU-RAY')
,'Beau Geste'
,''
,'PG'
,'01-MAR-92'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'53939-64103'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'BLU-RAY')
,'I Remember Mama'
,''
,'NR'
,'05-JAN-98'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'24543-01292'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'BLU-RAY')
,'Tora! Tora! Tora!'
,'The Attack on Pearl Harbor'
,'G'
,'02-NOV-99'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'43396-60047'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'BLU-RAY')
,'A Man for All Seasons'
,''
,'G'
,'28-JUN-94'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'43396-70603'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'BLU-RAY')
,'Hook'
,''
,'PG'
,'11-DEC-91'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'85391-13213'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'BLU-RAY')
,'Around the World in 80 Days'
,''
,'G'
,'04-DEC-92'
, 1001
, SYSDATE
, 1001
, SYSDATE);

INSERT INTO item_lab
( item_lab_id
, item_barcode
, item_type
, item_title
, item_subtitle
, item_rating
, item_release_date
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
( item_lab_s1.nextval
,'85391-10843'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_context = 'ITEM_LAB'
  AND      common_lookup_type = 'BLU-RAY')
,'Camelot'
,''
,'G'
,'15-MAY-98'
, 1001
, SYSDATE
, 1001
, SYSDATE);

-- ------------------------------------------------------------------
--  Display the 21 inserts into the item table.
-- ------------------------------------------------------------------
SET PAGESIZE 99
COL item_lab_id                FORMAT 9999  HEADING "Item|ID #"
COL common_lookup_meaning  FORMAT A20  HEADING "Item Description"
COL item_title             FORMAT A30  HEADING "Item Title"
COL item_release_date      FORMAT A11  HEADING "Item|Release|Date"
SELECT   i.item_lab_id
,        cl.common_lookup_meaning
,        i.item_title
,        i.item_release_date
FROM     item_lab i INNER JOIN common_lookup_lab cl ON i.item_type = cl.common_lookup_lab_id;


-- Commit changes.
COMMIT;

-- ------------------------------------------------------------------
--  Close log file.
-- ------------------------------------------------------------------
SPOOL OFF

