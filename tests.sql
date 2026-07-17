/* NOTA: Para poder ejecutar este script, se deberá reemplazar TU_PROJECT_ID por el ID 
de tu proyecto en BigQuery*/

-- Count rows per month
/* Para poder analizar tendencias de cantidad de movimientos por mes en busca
de alguna anomalía coorregible

Resultados:
El análisis arroja resultados explicables - el volumen de ventas tiende a
aumentar cada mes como sería el caso de un negocio exitoso. No es necesario
corregir datos.

PUNTO IMPORTANTE: 
Se deberá excluír del informe el último mes al ser un 
mes no terminado*/
SELECT CAST(DATE_TRUNC(created_at, MONTH) AS date) AS mes_orden,
    COUNT(*) AS month_data_size
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY mes_orden
ORDER BY mes_orden;

-- Chequeo de Fechas de Creación de Orden
/*Para el KPI de evolución mensual se analiza por fecha de creación de orden
cada orden exitosa. Sin embargo, vale la pena analizar si cada orden exitosa
tiene una fecha de entrega válida.

Resultados:

*/
SELECT COUNT(*) AS casos_problematicos
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status = 'COMPLETE' and created_at IS NULL;


-- Chequeo de Totales Calculados
/*Chequeo de las sumatorias de ventas para ver corroborar el buen cálculo 
mediante la coincidencia de los valores.

Resultados:
Se observa que en ambas tablas la sumatoria total de ventas coincide, por lo que
se asume un correcto cálculo en ambos casos.*/
SELECT SUM(ventas) AS ventas_total_vxcategoria
FROM `TU_PROJECT_ID.portafolio_ecommerce.kpi_ventas_categoria`
UNION ALL
SELECT SUM(ingreso_por_ventas) AS ventas_total_evmensual
FROM `TU_PROJECT_ID.portafolio_ecommerce.kpi_evolucion_mensual`;