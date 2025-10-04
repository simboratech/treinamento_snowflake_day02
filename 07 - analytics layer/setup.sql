/*--
 • analytics view creation
--*/
USE ROLE sysadmin;
USE WAREHOUSE tb_de_wh;
-- orders_v view
CREATE OR REPLACE VIEW tb_101.analytics.orders_v
COMMENT = 'Tasty Bytes Order Detail View'
    AS
SELECT DATE(o.order_ts) AS date, * FROM tb_101.harmonized.orders_v o;

-- customer_loyalty_metrics_v view
CREATE OR REPLACE VIEW tb_101.analytics.customer_loyalty_metrics_v
COMMENT = 'Tasty Bytes Customer Loyalty Member Metrics View'
    AS
SELECT * FROM tb_101.harmonized.customer_loyalty_metrics_v;

-- truck_reviews_v view
CREATE OR REPLACE VIEW tb_101.analytics.truck_reviews_v 
    AS
SELECT * FROM harmonized.truck_reviews_v;

GRANT USAGE ON SCHEMA tb_101.raw_support to ROLE tb_admin;
GRANT SELECT ON TABLE tb_101.raw_support.truck_reviews TO ROLE tb_admin;

-- view for streamlit app
CREATE OR REPLACE VIEW tb_101.analytics.japan_menu_item_sales_feb_2022
AS
SELECT
    DISTINCT menu_item_name,
    date,
    order_total
FROM analytics.orders_v
WHERE country = 'Japan'
    AND YEAR(date) = '2022'
    AND MONTH(date) = '2'
GROUP BY ALL
ORDER BY date;

-- Orders view for the Semantic Layer
CREATE OR REPLACE VIEW tb_101.semantic_layer.orders_v
AS
SELECT * FROM (
    SELECT
        order_id::VARCHAR AS order_id,
        truck_id::VARCHAR AS truck_id,
        order_detail_id::VARCHAR AS order_detail_id,
        truck_brand_name,
        menu_type,
        primary_city,
        region,
        country,
        franchise_flag,
        franchise_id::VARCHAR AS franchise_id,
        location_id::VARCHAR AS location_id,
        customer_id::VARCHAR AS customer_id,
        gender,
        marital_status,
        menu_item_id::VARCHAR AS menu_item_id,
        menu_item_name,
        quantity,
        order_total
    FROM tb_101.harmonized.orders_v
)
LIMIT 10000;

-- Customer Loyalty Metrics view for the Semantic Layer
CREATE OR REPLACE VIEW tb_101.semantic_layer.customer_loyalty_metrics_v
AS
SELECT * FROM (
    SELECT
        cl.customer_id::VARCHAR AS customer_id,
        cl.city,
        cl.country,
        SUM(o.order_total) AS total_sales,
        ARRAY_AGG(DISTINCT o.location_id::VARCHAR) WITHIN GROUP (ORDER BY o.location_id::VARCHAR) AS visited_location_ids_array
    FROM tb_101.harmonized.customer_loyalty_metrics_v AS cl
    JOIN tb_101.harmonized.orders_v AS o
        ON cl.customer_id = o.customer_id
    GROUP BY
        cl.customer_id,
        cl.city,
        cl.country
    ORDER BY
        cl.customer_id
)
LIMIT 10000;
