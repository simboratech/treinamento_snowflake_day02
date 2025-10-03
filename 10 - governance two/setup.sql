USE ROLE securityadmin;
-- Additional Grants on semantic layer
GRANT SELECT ON VIEW tb_101.semantic_layer.orders_v TO ROLE PUBLIC;
GRANT SELECT ON VIEW tb_101.semantic_layer.customer_loyalty_metrics_v TO ROLE PUBLIC;
GRANT READ ON STAGE tb_101.semantic_layer.semantic_model_stage TO ROLE tb_admin;
GRANT WRITE ON STAGE tb_101.semantic_layer.semantic_model_stage TO ROLE tb_admin;

-- Configure Attendee Account Part 3 --
USE ROLE ACCOUNTADMIN;

-- ability to run across cloud if claude is not in your region:
ALTER ACCOUNT SET CORTEX_ENABLED_CROSS_REGION = 'ANY_REGION';
 
 -- Create a database
CREATE DATABASE IF NOT EXISTS snowflake_intelligence;
CREATE SCHEMA IF NOT EXISTS snowflake_intelligence.agents;

-- create a schema to store the agents
GRANT USAGE ON DATABASE snowflake_intelligence TO ROLE TB_DEV;
GRANT USAGE ON SCHEMA snowflake_intelligence.agents TO ROLE TB_DEV;

-- Grant the CREATE AGENT privilege on the agents schema
GRANT CREATE AGENT ON SCHEMA snowflake_intelligence.agents TO ROLE TB_DEV;
