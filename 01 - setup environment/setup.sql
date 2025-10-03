/***************************************************************************************************       
Asset:        Environment Setup
Version:      v1    
Data:         Sample data from Snowflake - TastyBytes
****************************************************************************************************/

USE ROLE sysadmin;

-- create tb_101 database (tb = TastyBytes)
CREATE OR REPLACE DATABASE tb_101;

-- create raw_pos schema
CREATE OR REPLACE SCHEMA tb_101.raw_pos;

-- create raw_customer schema
CREATE OR REPLACE SCHEMA tb_101.raw_customer;

-- create harmonized schema
CREATE OR REPLACE SCHEMA tb_101.harmonized;

-- create analytics schema
CREATE OR REPLACE SCHEMA tb_101.analytics;

-- create governance schema
CREATE OR REPLACE SCHEMA tb_101.governance;

-- create raw_support
CREATE OR REPLACE SCHEMA tb_101.raw_support;

-- Create schema for the Semantic Layer
CREATE OR REPLACE SCHEMA tb_101.semantic_layer
COMMENT = 'Schema for the business-friendly semantic layer, optimized for analytical consumption.';
