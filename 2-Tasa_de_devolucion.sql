-- KPI 2: Tasa de Devolución
WITH tabla_vendidos AS (
    SELECT p.id,
        p.name,
        p.category,
        COUNT(*) * 1.0 AS cantidad_vendidos
    FROM `bigquery-public-data.thelook_ecommerce.products` p
        INNER JOIN `bigquery-public-data.thelook_ecommerce.order_items` o ON p.id = o.product_id
        AND o.status = 'Complete'
    GROUP BY p.id,
        p.name,
        p.category
),
tabla_devueltos AS (
    SELECT p.id,
        p.name,
        p.category,
        COUNT(*) * 1.0 AS cantidad_devueltos
    FROM `bigquery-public-data.thelook_ecommerce.products` p
        INNER JOIN `bigquery-public-data.thelook_ecommerce.order_items` o ON p.id = o.product_id
        AND o.status = 'Returned'
    GROUP BY p.id,
        p.name,
        p.category
),
tabla_unificada AS (
    SELECT COALESCE(v.id, d.id) AS id,
        COALESCE(v.name, d.name) AS name,
        COALESCE(v.category, d.category) AS category,
        COALESCE(v.cantidad_vendidos, 0) AS cantidad_vendidos,
        COALESCE(d.cantidad_devueltos, 0) AS cantidad_devueltos
    FROM tabla_vendidos v
        FULL OUTER JOIN tabla_devueltos d ON v.id = d.id
)
SELECT category,
    name,
    SUM(cantidad_vendidos + cantidad_devueltos) AS total_ordenes,
    SUM(cantidad_devueltos) AS total_devueltos,
    ROUND(
        SAFE_DIVIDE(
            SUM(cantidad_devueltos),
            SUM(cantidad_devueltos) + SUM(cantidad_vendidos)
        ),
        3
    ) AS tasa_de_devolucion
FROM tabla_unificada
GROUP BY category,
    name
ORDER BY category,
    name;