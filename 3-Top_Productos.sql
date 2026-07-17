-- KPI 3: Top 100 Productos que más recaudan
WITH ventas_por_producto AS (
    SELECT 
        p.category,
        p.name, 
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
        p.category, p.name
)

SELECT 
    DENSE_RANK() OVER (ORDER BY volumen_de_ventas DESC) AS top_vendidos,
    ROW_NUMBER() OVER (ORDER BY ventas DESC) AS top_recaudacion,
    category AS categoria,
    name,
    volumen_de_ventas,
    ventas AS recaudado
FROM
    ventas_por_producto
ORDER BY top_recaudacion
LIMIT 100;