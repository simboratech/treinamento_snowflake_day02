USE ROLE sysadmin;
USE WAREHOUSE tb_de_wh;

-- Create or replace the Cortex Search Service named 'tasty_bytes_review_search'. --
CREATE OR REPLACE CORTEX SEARCH SERVICE tb_101.harmonized.tasty_bytes_review_search
ON REVIEW 
ATTRIBUTES LANGUAGE, ORDER_ID, REVIEW_ID, TRUCK_BRAND_NAME, PRIMARY_CITY, DATE, SOURCE 
WAREHOUSE = tb_de_wh
TARGET_LAG = '1 day' 
AS (
    SELECT
        REVIEW,             
        LANGUAGE,           
        ORDER_ID,           
        REVIEW_ID,          
        TRUCK_BRAND_NAME,  
        PRIMARY_CITY,       
        DATE,               
        SOURCE             
    FROM
        tb_101.harmonized.truck_reviews_v 
    WHERE
        REVIEW IS NOT NULL 
);
