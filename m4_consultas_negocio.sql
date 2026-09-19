USE Ventas_Tech_DB;

-- Resumen ejecutivo mensual
SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    ROUND(SUM(cantidad * precio_unitario) / COUNT(*), 2) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;

-- Ranking de productos (Top 5)
SELECT 
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC
LIMIT 5;

-- Clientes recurrentes
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- Desempeño mensual respecto al promedio
SELECT 
    mes,
    total_mes,
    CASE 
        WHEN total_mes >= (
            SELECT AVG(total_mensual) 
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_mensual 
                FROM ventas 
                GROUP BY EXTRACT(MONTH FROM fecha_venta)
            ) AS sub
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS rendimiento_mensual
FROM (
    SELECT 
        EXTRACT(MONTH FROM fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_mes
    FROM ventas
    GROUP BY EXTRACT(MONTH FROM fecha_venta)
) AS resumen_meses;

-- Hallazgos:
-- 1. El producto 1 concentra $3600 de facturacion en 3 unidades, representando mas del 50% de los ingresos totales.
-- 2. La totalidad de los clientes (5) son recurrentes con exactamente 2 transacciones cada uno en el periodo.
-- 3. El producto 2 lidera en volumen con 13 unidades vendidas, pero aporta solo $364 a la facturacion global.