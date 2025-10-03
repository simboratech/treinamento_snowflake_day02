/***************************************************************************************************       
Asset:        Setup file format and storage integration
Version:      v1     
****************************************************************************************************/

USE ROLE sysadmin;
USE WAREHOUSE tb_de_wh;

/*--
 • file format and stage creation
--*/

CREATE OR REPLACE FILE FORMAT tb_101.public.csv_ff 
type = 'csv';

CREATE OR REPLACE STAGE tb_101.public.s3load
COMMENT = 'Quickstarts S3 Stage Connection'
url = 's3://sfquickstarts/frostbyte_tastybytes/'
file_format = tb_101.public.csv_ff;

CREATE OR REPLACE STAGE tb_101.public.truck_reviews_s3load
COMMENT = 'Truck Reviews Stage'
url = 's3://sfquickstarts/tastybytes-voc/'
file_format = tb_101.public.csv_ff;

-- This stage will be used to upload your YAML files.
CREATE OR REPLACE STAGE tb_101.semantic_layer.semantic_model_stage
  DIRECTORY = (ENABLE = TRUE)
  COMMENT = 'Internal stage for uploading Cortex Analyst semantic model YAML files.';
