-- KPI 4: Evolución Mensual del Ingreos por Ventas
SELECT CAST(DATE_TRUNC(created_at, MONTH) AS date) AS mes_orden,
    SUM(sale_price) AS ingreso_por_ventas
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status = 'Complete'
GROUP BY mes_orden
ORDER BY mes_orden;