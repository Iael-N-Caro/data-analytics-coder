USE Ventas_Tech_DB;

-- Ajustes de datos de prueba para verificar registros sin compras y variedad de fechas
INSERT IGNORE INTO clientes VALUES (6, 'Martin Peralta', 'martin@mail.com', 'Rosario', '2024-03-20');
INSERT IGNORE INTO productos VALUES (7, 'Camara Web Pro', 2, 85.00, 20, 1);
INSERT IGNORE INTO ventas VALUES (11, 1, 1, 1, 1200.00, '2024-04-02');


-- 1. Vista base del proyecto (INNER JOIN)
-- Proposito: Cruzo la tabla transaccional con las tablas descriptivas para generar la vista de Power BI.
SELECT 
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    c.ciudad AS region,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;

-- Hallazgo: La vista consolida todas las transacciones vinculadas con sus dimensiones. Computacion sigue siendo la categoria que mayor volumen de dinero aporta a la facturacion total.


-- 2. Clientes sin ventas (LEFT JOIN)
-- Proposito: Identificar que clientes se registraron pero todavia no tienen compras para que actue CRM.
SELECT 
    c.nombre AS nombre_cliente,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: Se detecto 1 cliente registrado sin compras (Martin Peralta). Sirve para que CRM le envie una promocion de bienvenida o primer pedido.


-- 3. Productos sin ventas (LEFT JOIN)
-- Proposito: Saber que articulos del catalogo no registran salida comercial para el area de producto.
SELECT 
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- Hallazgo: Aparece 1 producto sin ventas registradas (Camara Web Pro). El area de producto deberia revisar si necesita descuento o mayor visibilidad.


-- 4. Consolidado por canal (UNION ALL)
-- Proposito: Asignar un canal literal (Online y Presencial) a las ventas, unirlas sin perder registros y calcular el total por canal.
SELECT 
    canal,
    COUNT(*) AS cantidad_pedidos,
    SUM(total) AS total_canal
FROM (
    SELECT 
        fecha_venta, 
        (cantidad * precio_unitario) AS total, 
        'Online' AS canal
    FROM ventas 
    WHERE id_venta % 2 = 0

    UNION ALL

    SELECT 
        fecha_venta, 
        (cantidad * precio_unitario) AS total, 
        'Presencial' AS canal
    FROM ventas 
    WHERE id_venta % 2 != 0
) AS consolidado
GROUP BY canal;

-- Hallazgo: Con UNION ALL se conservan todas las ventas sin eliminar duplicados. El canal Presencial acumulo mayor facturacion que el Online.