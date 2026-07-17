-- KPI 5: Ticket Promedio
WITH ticket_por_pedido AS (
    SELECT order_id,
        SUM(sale_price) AS total_pedido
    FROM `bigquery-public-data.thelook_ecommerce.order_items`
    WHERE status = 'Complete'
    GROUP BY order_id
)
SELECT COUNT(*) AS total_ordenes,
    SUM(total_pedido) AS ventas_total,
    ROUND(AVG(total_pedido), 2) AS ticket_promedio
FROM ticket_por_pedido;