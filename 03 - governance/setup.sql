/***************************************************************************************************       
Asset:        Setup Governance
Version:      v1     
****************************************************************************************************/

-- create roles
USE ROLE securityadmin;

-- functional roles
CREATE ROLE IF NOT EXISTS tb_admin
    COMMENT = 'admin for tasty bytes';
    
CREATE ROLE IF NOT EXISTS tb_data_engineer
    COMMENT = 'data engineer for tasty bytes';
    
CREATE ROLE IF NOT EXISTS tb_dev
    COMMENT = 'developer for tasty bytes';
    
CREATE ROLE IF NOT EXISTS tb_analyst
    COMMENT = 'analyst for tasty bytes';
    
-- role hierarchy
GRANT ROLE tb_admin TO ROLE sysadmin;
GRANT ROLE tb_data_engineer TO ROLE tb_admin;
GRANT ROLE tb_dev TO ROLE tb_data_engineer;
GRANT ROLE tb_analyst TO ROLE tb_data_engineer;

-- privilege grants
USE ROLE accountadmin;

GRANT IMPORTED PRIVILEGES ON DATABASE snowflake TO ROLE tb_data_engineer;

GRANT CREATE WAREHOUSE ON ACCOUNT TO ROLE tb_admin;

USE ROLE securityadmin;

GRANT USAGE ON DATABASE tb_101 TO ROLE tb_admin;
GRANT USAGE ON DATABASE tb_101 TO ROLE tb_data_engineer;
GRANT USAGE ON DATABASE tb_101 TO ROLE tb_dev;

GRANT USAGE ON ALL SCHEMAS IN DATABASE tb_101 TO ROLE tb_admin;
GRANT USAGE ON ALL SCHEMAS IN DATABASE tb_101 TO ROLE tb_data_engineer;
GRANT USAGE ON ALL SCHEMAS IN DATABASE tb_101 TO ROLE tb_dev;

GRANT ALL ON SCHEMA tb_101.raw_support TO ROLE tb_admin;
GRANT ALL ON SCHEMA tb_101.raw_support TO ROLE tb_data_engineer;
GRANT ALL ON SCHEMA tb_101.raw_support TO ROLE tb_dev;

GRANT ALL ON SCHEMA tb_101.raw_pos TO ROLE tb_admin;
GRANT ALL ON SCHEMA tb_101.raw_pos TO ROLE tb_data_engineer;
GRANT ALL ON SCHEMA tb_101.raw_pos TO ROLE tb_dev;

GRANT ALL ON SCHEMA tb_101.harmonized TO ROLE tb_admin;
GRANT ALL ON SCHEMA tb_101.harmonized TO ROLE tb_data_engineer;
GRANT ALL ON SCHEMA tb_101.harmonized TO ROLE tb_dev;

GRANT ALL ON SCHEMA tb_101.analytics TO ROLE tb_admin;
GRANT ALL ON SCHEMA tb_101.analytics TO ROLE tb_data_engineer;
GRANT ALL ON SCHEMA tb_101.analytics TO ROLE tb_dev;

GRANT ALL ON SCHEMA tb_101.governance TO ROLE tb_admin;
GRANT ALL ON SCHEMA tb_101.governance TO ROLE tb_data_engineer;
GRANT ALL ON SCHEMA tb_101.governance TO ROLE tb_dev;

GRANT ALL ON SCHEMA tb_101.semantic_layer TO ROLE tb_admin;
GRANT ALL ON SCHEMA tb_101.semantic_layer TO ROLE tb_data_engineer;
GRANT ALL ON SCHEMA tb_101.semantic_layer TO ROLE tb_dev;

-- warehouse grants
GRANT OWNERSHIP ON WAREHOUSE tb_de_wh TO ROLE tb_admin COPY CURRENT GRANTS;
GRANT ALL ON WAREHOUSE tb_de_wh TO ROLE tb_admin;
GRANT ALL ON WAREHOUSE tb_de_wh TO ROLE tb_data_engineer;

GRANT ALL ON WAREHOUSE tb_dev_wh TO ROLE tb_admin;
GRANT ALL ON WAREHOUSE tb_dev_wh TO ROLE tb_data_engineer;
GRANT ALL ON WAREHOUSE tb_dev_wh TO ROLE tb_dev;

GRANT ALL ON WAREHOUSE tb_analyst_wh TO ROLE tb_admin;
GRANT ALL ON WAREHOUSE tb_analyst_wh TO ROLE tb_data_engineer;
GRANT ALL ON WAREHOUSE tb_analyst_wh TO ROLE tb_dev;

GRANT ALL ON WAREHOUSE tb_cortex_wh TO ROLE tb_admin;
GRANT ALL ON WAREHOUSE tb_cortex_wh TO ROLE tb_data_engineer;
GRANT ALL ON WAREHOUSE tb_cortex_wh TO ROLE tb_dev;

-- future grants
GRANT ALL ON FUTURE TABLES IN SCHEMA tb_101.raw_pos TO ROLE tb_admin;
GRANT ALL ON FUTURE TABLES IN SCHEMA tb_101.raw_pos TO ROLE tb_data_engineer;
GRANT ALL ON FUTURE TABLES IN SCHEMA tb_101.raw_pos TO ROLE tb_dev;

GRANT ALL ON FUTURE TABLES IN SCHEMA tb_101.raw_customer TO ROLE tb_admin;
GRANT ALL ON FUTURE TABLES IN SCHEMA tb_101.raw_customer TO ROLE tb_data_engineer;
GRANT ALL ON FUTURE TABLES IN SCHEMA tb_101.raw_customer TO ROLE tb_dev;

GRANT ALL ON FUTURE VIEWS IN SCHEMA tb_101.harmonized TO ROLE tb_admin;
GRANT ALL ON FUTURE VIEWS IN SCHEMA tb_101.harmonized TO ROLE tb_data_engineer;
GRANT ALL ON FUTURE VIEWS IN SCHEMA tb_101.harmonized TO ROLE tb_dev;

GRANT ALL ON FUTURE VIEWS IN SCHEMA tb_101.analytics TO ROLE tb_admin;
GRANT ALL ON FUTURE VIEWS IN SCHEMA tb_101.analytics TO ROLE tb_data_engineer;
GRANT ALL ON FUTURE VIEWS IN SCHEMA tb_101.analytics TO ROLE tb_dev;

GRANT ALL ON FUTURE VIEWS IN SCHEMA tb_101.governance TO ROLE tb_admin;
GRANT ALL ON FUTURE VIEWS IN SCHEMA tb_101.governance TO ROLE tb_data_engineer;
GRANT ALL ON FUTURE VIEWS IN SCHEMA tb_101.governance TO ROLE tb_dev;

GRANT ALL ON FUTURE VIEWS IN SCHEMA tb_101.semantic_layer TO ROLE tb_admin;
GRANT ALL ON FUTURE VIEWS IN SCHEMA tb_101.semantic_layer TO ROLE tb_data_engineer;
GRANT ALL ON FUTURE VIEWS IN SCHEMA tb_101.semantic_layer TO ROLE tb_dev;

-- Apply Masking Policy Grants
USE ROLE accountadmin;
GRANT APPLY MASKING POLICY ON ACCOUNT TO ROLE tb_admin;
GRANT APPLY MASKING POLICY ON ACCOUNT TO ROLE tb_data_engineer;
  
-- Grants for tb_admin
GRANT EXECUTE DATA METRIC FUNCTION ON ACCOUNT TO ROLE tb_admin;

-- Grants for tb_analyst
GRANT ALL ON SCHEMA tbt101.harmonized TO ROLE tb_analyst;
GRANT ALL ON SCHEMA tbt101.analytics TO ROLE tb_analyst;
GRANT OPERATE, USAGE ON WAREHOUSE tb_analyst_wh TO ROLE tb_analyst;

-- Grants for cortex search service
GRANT DATABASE ROLE SNOWFLAKE.CORTEX_USER TO ROLE TB_DEV;
GRANT USAGE ON SCHEMA TB_101.HARMONIZED TO ROLE TB_DEV;
GRANT USAGE ON WAREHOUSE TB_DE_WH TO ROLE TB_DEV;

