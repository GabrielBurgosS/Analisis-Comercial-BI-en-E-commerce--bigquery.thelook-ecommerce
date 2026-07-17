-- KPI 5: Ticket Promedio
WITH datos AS ( 
    SELECT
        (SELECT SUM(o.sale_price) AS ventas_total
        FROM `bigquery-public-data.thelook_ecommerce.order_items` o
        WHERE o.status = 'Complete' and o.created_at IS NOT NULL) AS ventas_total,
        (SELECT COUNT(*) AS total_ordenes
        FROM `bigquery-public-data.thelook_ecommerce.orders`
        WHERE status = 'Complete' and created_at IS NOT NULL) AS total_ordenes
)

SELECT ventas_total,
    total_ordenes,
    ventas_total / total_ordenes AS ticket_promedio
FROM datos;