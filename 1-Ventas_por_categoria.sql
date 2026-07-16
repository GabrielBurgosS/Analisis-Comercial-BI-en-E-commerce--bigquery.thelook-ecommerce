-- KPI 1: Ventas por Categoría
WITH ventas_por_categoria AS (
    SELECT 
        p.category, 
        COUNT(*) as volumen_de_ventas,
        SUM(o.sale_price) as ventas
    FROM 
        `bigquery-public-data.thelook_ecommerce.order_items` o
    INNER JOIN
        `bigquery-public-data.thelook_ecommerce.products` p
        ON o.product_id = p.id
    WHERE 
        o.status = 'Complete'
    GROUP BY
        p.category
)

SELECT 
    ROW_NUMBER() OVER (ORDER BY ventas DESC) AS top,
    category,
    volumen_de_ventas,
    ventas
FROM
    ventas_por_categoria
ORDER BY
    top;