/*--
 • harmonized view creation
--*/

-- orders_v view
CREATE OR REPLACE VIEW tb_101.harmonized.orders_v
    AS
SELECT 
    oh.order_id,
    oh.truck_id,
    oh.order_ts,
    od.order_detail_id,
    od.line_number,
    m.truck_brand_name,
    m.menu_type,
    t.primary_city,
    t.region,
    t.country,
    t.franchise_flag,
    t.franchise_id,
    f.first_name AS franchisee_first_name,
    f.last_name AS franchisee_last_name,
    l.location_id,
    cl.customer_id,
    cl.first_name,
    cl.last_name,
    cl.e_mail,
    cl.phone_number,
    cl.children_count,
    cl.gender,
    cl.marital_status,
    od.menu_item_id,
    m.menu_item_name,
    od.quantity,
    od.unit_price,
    od.price,
    oh.order_amount,
    oh.order_tax_amount,
    oh.order_discount_amount,
    oh.order_total
FROM tb_101.raw_pos.order_detail od
JOIN tb_101.raw_pos.order_header oh
    ON od.order_id = oh.order_id
JOIN tb_101.raw_pos.truck t
    ON oh.truck_id = t.truck_id
JOIN tb_101.raw_pos.menu m
    ON od.menu_item_id = m.menu_item_id
JOIN tb_101.raw_pos.franchise f
    ON t.franchise_id = f.franchise_id
JOIN tb_101.raw_pos.location l
    ON oh.location_id = l.location_id
LEFT JOIN tb_101.raw_customer.customer_loyalty cl
    ON oh.customer_id = cl.customer_id;

-- loyalty_metrics_v view
CREATE OR REPLACE VIEW tb_101.harmonized.customer_loyalty_metrics_v
    AS
SELECT 
    cl.customer_id,
    cl.city,
    cl.country,
    cl.first_name,
    cl.last_name,
    cl.phone_number,
    cl.e_mail,
    SUM(oh.order_total) AS total_sales,
    ARRAY_AGG(DISTINCT oh.location_id) AS visited_location_ids_array
FROM tb_101.raw_customer.customer_loyalty cl
JOIN tb_101.raw_pos.order_header oh
ON cl.customer_id = oh.customer_id
GROUP BY cl.customer_id, cl.city, cl.country, cl.first_name,
cl.last_name, cl.phone_number, cl.e_mail;

-- truck_reviews_v view
  CREATE OR REPLACE VIEW tb_101.harmonized.truck_reviews_v
      AS
  SELECT DISTINCT
      r.review_id,
      r.order_id,
      oh.truck_id,
      r.language,
      source,
      r.review,
      t.primary_city,
      oh.customer_id,
      TO_DATE(oh.order_ts) AS date,
      m.truck_brand_name
  FROM raw_support.truck_reviews r
  JOIN raw_pos.order_header oh
      ON oh.order_id = r.order_id
  JOIN raw_pos.truck t
      ON t.truck_id = oh.truck_id
  JOIN raw_pos.menu m
      ON m.menu_type_id = t.menu_type_id;
