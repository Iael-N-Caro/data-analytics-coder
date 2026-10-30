# RetailPro — Proyecto Integrador de Data Analytics

Repositorio correspondiente al proyecto de análisis de datos para la distribuidora de tecnología **RetailPro**.

## Objetivo del Proyecto
Diagnosticar y analizar las causas detrás de la caída del 12% semestral en la facturación y margen de ganancia en sucursales físicas, evaluando el desempeño por regiones, categorías de producto, canales (Online vs. Presencial) y comportamiento de clientes corporativos.

## Herramientas Utilizadas
* **MySQL Workbench:** Diseño relacional, creación de esquemas (DDL), carga de datos (DML) y consultas analíticas de negocio (agregaciones, JOINs y filtros condicionales).
* **Power BI Desktop:** 
  * **Power Query (Lenguaje M):** Pipeline ETL para extracción, limpieza de datos, tipado y desduplicación.
  * **DAX & Modelado:** Esquema en estrella con relaciones 1:N activas, tabla calendario (`Dim_Fechas`) y medidas core de inteligencia temporal.

## Estructura de Archivos
* `ventas_tech_db.sql`: Script DDL/DML para la creación de la base de datos `Ventas_Tech_DB`, tablas con claves primarias/foráneas y registros de prueba.
* `m4_consultas_negocio.sql`: Consultas de agregación (`SUM`, `AVG`, `COUNT`), métricas mensuales y ranking de productos.
* `m5_consultas_joins.sql`: Consultas analíticas avanzadas cruzando dimensiones con `INNER JOIN`, detección de registros con `LEFT JOIN` y consolidación por canal con `UNION ALL`.
* `Pipeline_ETL_Caro_Iael.pbix`: Archivo base con el proceso de transformación y carga de datos.
* `Caro_Iael_Checkpoint2.pbix`: Modelo analítico final con relaciones 1:N y las 5 medidas DAX core implementadas.

## Guía de Ejecución
1. Abrir **MySQL Workbench** y conectarse al servidor local.
2. Abrir y ejecutar el script `ventas_tech_db.sql` para crear la base de datos y poblar las tablas.
3. Ejecutar las consultas de análisis en `m4_consultas_negocio.sql` o `m5_consultas_joins.sql`.
4. Para visualizar el modelo y los cálculos analíticos, abrir el archivo `.pbix` en **Power BI Desktop**.
