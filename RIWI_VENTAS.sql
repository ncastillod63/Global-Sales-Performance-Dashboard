CREATE TABLE ventas (
    ciudad TEXT,
    fecha DATE,
    producto TEXT,
    tipo_producto TEXT,
    cantidad FLOAT,
    precio_unitario FLOAT,
    tipo_venta TEXT,
    tipo_cliente TEXT,
    descuento FLOAT,
    costo_envio FLOAT,
    total FLOAT
);

CREATE TABLE dim_ciudad (
    id_ciudad SERIAL PRIMARY KEY,
    ciudad TEXT UNIQUE
);

INSERT INTO dim_ciudad (ciudad)
SELECT DISTINCT ciudad
FROM ventas
WHERE ciudad IS NOT NULL;

ALTER TABLE ventas
ADD COLUMN id_ciudad INT;

UPDATE ventas v
SET id_ciudad = d.id_ciudad
FROM dim_ciudad d
WHERE v.ciudad = d.ciudad;

ALTER TABLE ventas
ADD CONSTRAINT fk_ventas_ciudad
FOREIGN KEY (id_ciudad) REFERENCES dim_ciudad(id_ciudad);

CREATE TABLE dim_producto (
    id_producto SERIAL PRIMARY KEY,
    producto TEXT UNIQUE,
    tipo_producto TEXT
);

INSERT INTO dim_producto (producto, tipo_producto)
SELECT DISTINCT producto, tipo_producto
FROM ventas
WHERE producto IS NOT NULL;


ALTER TABLE ventas
ADD COLUMN id_producto INT;

UPDATE ventas v
SET id_producto = d.id_producto
FROM dim_producto d
WHERE v.producto = d.producto;

ALTER TABLE ventas
ADD CONSTRAINT fk_ventas_producto
FOREIGN KEY (id_producto) REFERENCES dim_producto(id_producto);

CREATE TABLE dim_tipo_cliente (
    id_tipo_cliente SERIAL PRIMARY KEY,
    tipo_cliente TEXT UNIQUE
);

INSERT INTO dim_tipo_cliente (tipo_cliente)
SELECT DISTINCT tipo_cliente
FROM ventas
WHERE tipo_cliente IS NOT NULL;

ALTER TABLE ventas
ADD COLUMN id_tipo_cliente INT;

UPDATE ventas v
SET id_tipo_cliente = d.id_tipo_cliente
FROM dim_tipo_cliente d
WHERE v.tipo_cliente = d.tipo_cliente;

ALTER TABLE ventas
ADD CONSTRAINT fk_ventas_tipo_cliente
FOREIGN KEY (id_tipo_cliente) REFERENCES dim_tipo_cliente(id_tipo_cliente);

CREATE TABLE dim_tipo_venta (
    id_tipo_venta SERIAL PRIMARY KEY,
    tipo_venta TEXT UNIQUE
);

INSERT INTO dim_tipo_venta (tipo_venta)
SELECT DISTINCT tipo_venta
FROM ventas
WHERE tipo_venta IS NOT NULL;

ALTER TABLE ventas
ADD COLUMN id_tipo_venta INT;

UPDATE ventas v
SET id_tipo_venta = d.id_tipo_venta
FROM dim_tipo_venta d
WHERE v.tipo_venta = d.tipo_venta;

ALTER TABLE ventas
ADD CONSTRAINT fk_ventas_tipo_venta
FOREIGN KEY (id_tipo_venta) REFERENCES dim_tipo_venta(id_tipo_venta);

CREATE TABLE dim_fecha (
    id_fecha SERIAL PRIMARY KEY,
    fecha DATE UNIQUE,
    anio INT,
    mes INT,
    dia INT
);

INSERT INTO dim_fecha (fecha, anio, mes, dia)
SELECT DISTINCT
    fecha,
    EXTRACT(YEAR FROM fecha)::INT,
    EXTRACT(MONTH FROM fecha)::INT,
    EXTRACT(DAY FROM fecha)::INT
FROM ventas
WHERE fecha IS NOT NULL;

ALTER TABLE ventas
ADD COLUMN id_fecha INT;

UPDATE ventas v
SET id_fecha = d.id_fecha
FROM dim_fecha d
WHERE v.fecha = d.fecha;

ALTER TABLE ventas
ADD CONSTRAINT fk_ventas_fecha
FOREIGN KEY (id_fecha) REFERENCES dim_fecha(id_fecha);

ALTER TABLE dim_ciudad
ADD COLUMN pais TEXT;

-- Argentina
UPDATE dim_ciudad
SET pais = 'Argentina'
WHERE ciudad IN ('Mendoza', 'Buenos Aires', 'Rosario', 'Córdoba');

-- México
UPDATE dim_ciudad
SET pais = 'México'
WHERE ciudad IN ('Ciudad De México', 'Monterrey', 'Puebla', 'Tijuana', 'Guadalajara');

-- Colombia
UPDATE dim_ciudad
SET pais = 'Colombia'
WHERE ciudad IN ('Pereira', 'Barranquilla', 'Bogotá', 'Bucaramanga', 'Medellín', 'Cartagena', 'Cali');

-- Chile
UPDATE dim_ciudad
SET pais = 'Chile'
WHERE ciudad IN ('Antofagasta', 'Valparaíso', 'Santiago', 'Concepción');

-- Perú
UPDATE dim_ciudad
SET pais = 'Perú'
WHERE ciudad IN ('Lima', 'Trujillo', 'Cusco', 'Arequipa');

-- España
UPDATE dim_ciudad
SET pais = 'España'
WHERE ciudad IN ('Madrid', 'Valencia', 'Sevilla', 'Barcelona');

-- Estados Unidos
UPDATE dim_ciudad
SET pais = 'Estados Unidos'
WHERE ciudad IN ('New York', 'Chicago', 'Houston', 'Los Angeles', 'Miami');

-- Lo que quede sin país
UPDATE dim_ciudad
SET pais = 'SinDato'
WHERE pais IS NULL;



