# data-analytics-coder
# RetailPro - Data Analytics Project

Repositorio para el caso de negocio RetailPro (distribuidora de tecnología).

## Archivos del proyecto

* `ventas_tech_db.sql`: Creación de la base de datos `Ventas_Tech_DB`, tablas (`categorias`, `clientes`, `productos`, `ventas`), restricciones (PK, FK) y carga inicial de datos.
* `m4_consultas_negocio.sql`: Consultas con funciones de agregación (`SUM`, `COUNT`, `AVG`), agrupaciones (`GROUP BY`, `HAVING`) y lógica condicional con `CASE WHEN`.
* `m5_consultas_joins.sql`: Consultas avanzadas cruzando dimensiones con `INNER JOIN`, detección de registros inactivos con `LEFT JOIN` e `IS NULL`, y consolidación por canal con `UNION ALL`.

## Cómo ejecutar

1. Abrir MySQL Workbench y ejecutar `ventas_tech_db.sql` para crear la base y poblar los datos.
2. Ejecutar `m4_consultas_negocio.sql` o `m5_consultas_joins.sql` según el análisis deseado.
