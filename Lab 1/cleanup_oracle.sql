-- ------------------------------------------------------------------
--  Program Name:   cleanup_oracle.sql
--  Lab Assignment: N/A
--  Program Author: Michael McLaughlin
--  Creation Date:  02-Mar-2010
-- ------------------------------------------------------------------
--  Change Log:
-- ------------------------------------------------------------------
--  Change Date    Change Reason
-- -------------  ---------------------------------------------------
--  08-Jun-2014    Update lab for weekly deliverables.
--  23-Aug-2018    Update script to work with APEX 18.1.
-- ------------------------------------------------------------------
-- This creates tables, sequences, indexes, and constraints necessary
-- to begin lesson #3. Demonstrates proper process and syntax.
-- ------------------------------------------------------------------

-- Open log file.
SPOOL cleanup_oracle.txt

-- Anonymous block to cleanup the lab files.
BEGIN
  FOR i IN (SELECT    object_name
            ,         object_type
            ,         last_ddl_time
            FROM      user_objects
            WHERE     object_name NOT IN
                        ('APEX$_ACL'
                        ,'APEX$_ACL_IDX1'
                        ,'APEX$_ACL_PK'
                        ,'APEX$_ACL_T1'
                        ,'APEX$_WS_FILES'
                        ,'APEX$_WS_FILES_IDX1'
                        ,'APEX$_WS_FILES_IDX2'
                        ,'APEX$_WS_FILES_PK'
                        ,'APEX$_WS_FILES_T1'
                        ,'APEX$_WS_HISTORY'
                        ,'APEX$_WS_HISTORY_IDX'
                        ,'APEX$_WS_LINKS'
                        ,'APEX$_WS_LINKS_IDX1'
                        ,'APEX$_WS_LINKS_IDX2'
                        ,'APEX$_WS_LINKS_PK'
                        ,'APEX$_WS_LINKS_T1'
                        ,'APEX$_WS_NOTES'
                        ,'APEX$_WS_NOTES_IDX1'
                        ,'APEX$_WS_NOTES_IDX2'
                        ,'APEX$_WS_NOTES_PK'
                        ,'APEX$_WS_NOTES_T1'
                        ,'APEX$_WS_ROWS'
                        ,'APEX$_WS_ROWS_IDX'
                        ,'APEX$_WS_ROWS_PK'
                        ,'APEX$_WS_ROWS_T1'
                        ,'APEX$_WS_ROWS_UK1'
                        ,'APEX$_WS_SEQ'
                        ,'APEX$_WS_TAGS'
                        ,'APEX$_WS_TAGS_IDX1'
                        ,'APEX$_WS_TAGS_IDX2'
                        ,'APEX$_WS_TAGS_PK'
                        ,'APEX$_WS_TAGS_T1'
                        ,'APEX$_WS_WEBPG_SECHIST_IDX1'
                        ,'APEX$_WS_WEBPG_SECTIONS'
                        ,'APEX$_WS_WEBPG_SECTIONS_PK'
                        ,'APEX$_WS_WEBPG_SECTIONS_T1'
                        ,'APEX$_WS_WEBPG_SECTION_HISTORY'
                        ,'DEMO_CONSTRAINT_LOOKUP'
                        ,'DEMO_CUSTOMERS'
                        ,'DEMO_CUSTOMERS_BD'
                        ,'DEMO_CUSTOMERS_BIU'
                        ,'DEMO_CUSTOMERS_BI'
                        ,'DEMO_CUSTOMERS_PK'
                        ,'DEMO_CUSTOMERS_UK'
                        ,'DEMO_CUST_NAME_IX'
                        ,'DEMO_CUST_SEQ'
                        ,'DEMO_ORDERS'
                        ,'DEMO_ORDERS_BD'
                        ,'DEMO_ORDERS_BIU'
                        ,'DEMO_ORDER_ITEMS'
                        ,'DEMO_ORDER_ITEMS_AIUD_TOTAL'
                        ,'DEMO_ORDER_ITEMS_BI'
                        ,'DEMO_ORDER_ITEMS_BIU_GET_PRICE'
                        ,'DEMO_ORDER_ITEMS_PK'
                        ,'DEMO_ORDER_ITEMS_SEQ'
                        ,'DEMO_ORDER_ITEMS_UK'
                        ,'DEMO_ORDER_PK'
                        ,'DEMO_ORD_CUSTOMER_IX'
                        ,'DEMO_ORD_SEQ'
                        ,'DEMO_PRODUCT_INFO'
                        ,'DEMO_PRODUCT_INFO_BD'
                        ,'DEMO_PRODUCT_INFO_BIU'
                        ,'DEMO_PRODUCT_INFO_PK'
                        ,'DEMO_PRODUCT_INFO_UK'
                        ,'DEMO_PROD_SEQ'
                        ,'DEMO_STATES'
                        ,'DEMO_TAGS'
                        ,'DEMO_TAGS_BIU'
                        ,'DEMO_TAGS_SUM'
                        ,'DEMO_TAGS_SUM_PK'
                        ,'DEMO_TAGS_TYPE_SUM'
                        ,'DEMO_TAGS_TYPE_SUM_PK'
                        ,'DEPT'
                        ,'DEPT_SEQ'
                        ,'DEPT_TRG1'
                        ,'EMP'
                        ,'EMP_SEQ'
                        ,'EMP_TRG1'
                        ,'SAMPLE_DATA_PKG'
                        ,'SAMPLE_DATA_PKG'
                        ,'SAMPLE_PKG'
                        ,'SAMPLE_PKG'
                        ,'SYS_C0011214'
                        ,'SYS_C0011216'
                        ,'SYS_C0011221'
                        ,'SYS_C0011248'
                        ,'SYS_LOB0000025723C00007$$'
                        ,'SYS_LOB0000025745C00007$$'
                        ,'SYS_LOB0000025745C00008$$'
                        ,'SYS_LOB0000025751C00165$$'
                        ,'SYS_LOB0000025751C00166$$'
                        ,'SYS_LOB0000025759C00007$$'
                        ,'SYS_LOB0000025767C00010$$'
                        ,'SYS_LOB0000025771C00008$$'
                        ,'SYS_LOB0000025771C00009$$')
            ORDER BY object_name ASC) LOOP
 
    /* Drop types in descending order. */
    IF i.object_type = 'TYPE' THEN

      /* Print the executed statement. */
      dbms_output.put_line('DROP '||i.object_type||' '||i.object_name||';');
      /* Drop type and force operation because dependencies may exist. Oracle 12c
         also fails to remove object types with dependents in pluggable databases
         (at least in release 12.1). Type evolution works in container database
         schemas. */
      EXECUTE IMMEDIATE 'DROP '||i.object_type||' '||i.object_name||' FORCE';
 
    /* Drop table tables in descending order. */
    ELSIF i.object_type = 'TABLE' THEN
 
      /* Print the executed statement. */
      dbms_output.put_line('DROP '||i.object_type||' '||i.object_name||';');
      /* Drop table with cascading constraints to ensure foreign key constraints
         don't prevent the action. */
      EXECUTE IMMEDIATE 'DROP '||i.object_type||' '||i.object_name||' CASCADE CONSTRAINTS PURGE';
      
      /* Oracle 12c ONLY: Purge the recyclebin to dispose of system-generated
         sequence values because dropping the table doesn't automatically 
         remove them from the active session.
         CRITICAL: Remark out the following when working in Oracle Database 11g. */
      EXECUTE IMMEDIATE 'PURGE RECYCLEBIN';
 
    ELSIF i.object_type = 'LOB' OR i.object_type = 'INDEX' THEN

      /* Print the executed statement. */
      dbms_output.put_line('DROP '||i.object_type||' '||i.object_name||';');
      /* A system generated LOB column or INDEX will cause a failure in a
         generic drop of a table because it is listed in the cursor but removed
         by the drop of its table. This NULL block ensures there is no attempt
         to drop an implicit LOB data type or index because the dropping the
         table takes care of it. */
      NULL;

    ELSE

      /* Print the executed statement. */
      dbms_output.put_line('DROP '||i.object_type||' '||i.object_name||';');
      /* Drop any other objects, like sequences, functions, procedures, and packages. */
      -- EXECUTE IMMEDIATE 'DROP '||i.object_type||' '||i.object_name;
      NULL;
      
    END IF;
  END LOOP;
END;
/

-- Close the log file.
SPOOL OFF
