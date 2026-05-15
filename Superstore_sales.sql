CREATE TABLE public.orders (
    row_id          INT,
    order_id        VARCHAR(20),
    order_date      DATE,
    ship_date       DATE,
    ship_mode       VARCHAR(30),
    customer_id     VARCHAR(20),
    customer_name   VARCHAR(100),
    segment         VARCHAR(30),
    country         VARCHAR(50),
    city            VARCHAR(50),
    state           VARCHAR(50),
    postal_code     VARCHAR(10),
    region          VARCHAR(20),
    product_id      VARCHAR(20),
    category        VARCHAR(50),
    sub_category    VARCHAR(50),
    product_name    VARCHAR(255),
    sales           NUMERIC(10,2)
);


SELECT COUNT(*) FROM public.orders;


SELECT order_id, order_date, ship_date, sales
FROM public.orders
LIMIT 5;

-- cleaning data 
SELECT * FROM public.orders
WHERE
    order_date   IS NOT NULL
    AND ship_date    IS NOT NULL
    AND ship_date    >= order_date
    AND sales        > 0
    AND customer_id  IS NOT NULL
    AND product_id   IS NOT NULL;



SELECT
    DATE_TRUNC('month', order_date)     AS order_month,
    region,
    category,
    COUNT(DISTINCT order_id)            AS total_orders,
    ROUND(SUM(sales)::NUMERIC, 2)       AS total_sales
FROM public.orders
GROUP BY 1, 2, 3
ORDER BY 1, 2;

SELECT
    category,
    sub_category,
    COUNT(DISTINCT order_id)        AS total_orders,
    ROUND(SUM(sales)::NUMERIC, 2)   AS total_sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM public.orders
GROUP BY 1, 2
ORDER BY sales_rank;

SELECT
    customer_id,
    customer_name,
    segment,
    COUNT(DISTINCT order_id)        AS total_orders,
    ROUND(SUM(sales)::NUMERIC, 2)   AS total_sales
FROM public.orders
GROUP BY 1, 2, 3
ORDER BY total_sales DESC
LIMIT 10;

