-- BASE DE DATO DE DISTRIBUIDORA.

/*
Creador : GASTÓN FERNÁNDEZ.
CURSO: SQL CODERHOUSE
AÑO: 2O26

*/
        
-- BEGIN ENTREGA 1.        
    
    DROP DATABASE IF EXISTS distribuidora;
    
	CREATE DATABASE IF NOT EXISTS distribuidora;
    
    USE distribuidora; -- Utilizo la BD distribuidora.

-- Creo tablas.

	-- PRODUCTOS -----------------------------------------------------------------------------------
    
		-- Creo tabla.
        
        CREATE TABLE IF NOT EXISTS PRODUCT
		(
			Id_PRODUCT INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- > Identificador del producto.
			Name VARCHAR(50) NOT NULL, -- > Nombre del producto.
			Pack VARCHAR(10) NOT NULL, -- > Formato de entrega.
			Unit_x_pack DECIMAL(5,2) NOT NULL, -- > Unidades por pack.
			Unit_price DECIMAL(5,2) NOT NULL, -- > Precio por unidad.
			unit_weight DECIMAL(9,2) NOT NULL-- > Peso de mis productos (En gramos).
        );
		        
	-- CLIENTES -----------------------------------------------------------------------------------

		-- Creo tabla.
        
        CREATE TABLE IF NOT EXISTS CLIENT
		(
			Id_CLIENT INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- > Identificador unico del cliente.
			Company_name VARCHAR(100) UNIQUE NOT NULL, -- > Razón social.
			fisrt_name_contact VARCHAR(30) NOT NULL, -- > Nombre del contacto
			last_name_contact VARCHAR(50) NOT NULL, -- > Apellido del contacto
			Address VARCHAR(50) NOT NULL, -- > Dirección de clientes
			Postal_code VARCHAR(6) NOT NULL, -- > Codigo postal
			Email VARCHAR(100) NOT NULL UNIQUE, -- > Mail de cliente.
			CUIT VARCHAR(20) NOT NULL, -- > CUIT de cliente.
            Market VARCHAR(20) NOT NULL -- > Mercado de pertenencia.
		);
        
    -- VENDEDORES -----------------------------------------------------------------------------------
    
		CREATE TABLE IF NOT EXISTS SELLER
		(
			ID_SELLER INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- > Pk de vendedor.
			Fist_name VARCHAR(15) NOT NULL, -- > Pk de vendedores.
			Last_name VARCHAR(20) NOT NULL, -- > Apellido del vendedor
			Email VARCHAR(25) UNIQUE NOT NULL, -- > Email del vendedor.
			DNI VARCHAR(8) NOT NULL UNIQUE NOT NULL, -- > D.N.I. Del vendedor
            Market VARCHAR(20) NOT NULL -- > Mercado de pertenencia.
		);
    
	-- PROVEEDORES -----------------------------------------------------------------------------------
    
		-- Creo tabla.
        
        CREATE TABLE IF NOT EXISTS SUPPLYER
		(
		   ID_SUPPLYER INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- > Pk del proveedor.
		   Company_name VARCHAR(100) UNIQUE NOT NULL, -- > Razón social.
           fisrt_name_contact VARCHAR(30) NOT NULL, -- > Nombre del  contacto
           last_name_contact VARCHAR(50) NOT NULL, -- > Apellido del contacto
           Address VARCHAR(50) NOT NULL, -- > Dirección
           Postal_code VARCHAR(6) NOT NULL, -- > Codigo postal
           Email VARCHAR(100) NOT NULL UNIQUE, -- > Mail de contacto.
           CUIT VARCHAR(20) NOT NULL, -- > CUIT .
           Market VARCHAR(20) NOT NULL -- > Mercado de pertenencia.
		);
   
	-- WHEREHOUSE -----------------------------------------------------------------------------------
        
        -- Creo tabla
        
        CREATE TABLE IF NOT EXISTS distribuidora.WHEREHOUSE
        (
        ID_Wherehouse INT NOT NULL AUTO_INCREMENT primary KEY, -- > Identificador de cada lugar del almacén.
		hallway INT NOT NULL, -- > Pasillo de estanteria.
		row_where INT NOT NULL , -- > Piso de estanteria.
        column_where CHAR(1) NOT NULL -- > Columna de estanteria.
        );

    -- COMPRADORES -----------------------------------------------------------------------------------
    
		CREATE TABLE IF NOT EXISTS PURCHASER
		(
			ID_PURCHASER INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- > Pk de vendedor.
			Fist_name VARCHAR(15) NOT NULL, -- > Pk de vendedores.
			Last_name VARCHAR(20) NOT NULL, -- > Apellido del vendedor
			Email VARCHAR(25) UNIQUE NOT NULL, -- > Email del vendedor.
			DNI VARCHAR(8) NOT NULL UNIQUE, -- > D.N.I. Del vendedor
            Market VARCHAR(20) NOT NULL -- > Mercado de pertenencia.
		);
    
   -- VENTAS ---------------------------------------------------------------------------------------
        
        -- Creo tabla.
        
        CREATE TABLE IF NOT EXISTS SELL
        (
			ID_SELL INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- > Nota de venta.
			Date_Sell DATE NOT NULL, -- > Fecha de factura.
			-- Creo las tablas foraneas.
            ID_CLIENT INT NOT NULL, -- > FK de cliente.
            ID_SELLER INT NOT NULL, -- > FK de vendedor.
            -- Creo las relaciones.
            FOREIGN KEY (ID_CLIENT) REFERENCES CLIENT(ID_CLIENT), -- > Relación con tabla de cliente.
            FOREIGN KEY (ID_SELLER) REFERENCES SELLER(ID_SELLER) -- > Relación con tabla de vendedor.
        );
        
	-- DETALLE DE VENTA -----------------------------------------------------------------------

        -- Creo tabla.
        
        CREATE TABLE IF NOT EXISTS Distribuidora.DET_SELL
        (
        ID_DET_SELL INT NOT NULL AUTO_INCREMENT primary KEY, -- > Identificador de lineas de ventas.
        Quantity DECIMAL(5,2) NOT NULL, -- > Cantidades pedidas de cada producto.
        -- Creo clave foraneas.
        ID_SELL INT NOT NULL, -- > Fk tabla ventas.
        ID_PRODUCT INT NOT NULL,-- > FK tabla product
        -- Creo relaciones.
        FOREIGN KEY (ID_SELL) REFERENCES SELL(ID_SELL),
        FOREIGN KEY (ID_PRODUCT) REFERENCES PRODUCT(ID_PRODUCT)
        );
   
   -- COMPRA -----------------------------------------------------------------------------------
    
		-- Creo la tabla.
   
		CREATE TABLE IF NOT EXISTS PURCHASE
		(
			ID_PURCHASE INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- > Orden de compra.
			Date_purchase DATE NOT NULL, -- > Fecha de compra
            -- Defino las claves foraneas.
            ID_SUPPLYER INT NOT NULL, -- >  Fk del cliente.
            ID_PURCHASER INT NOT NULL, -- > FK del vendedor.
            -- Defino las relaciones.
            FOREIGN KEY (ID_SUPPLYER) REFERENCES SUPPLYER(ID_SUPPLYER), -- > Relacion con la tabla de cliente.
            FOREIGN KEY (ID_PURCHASER) REFERENCES PURCHASER(ID_PURCHASER) -- > Relación con la tabla de seller.
		);
   
	-- DETALLE DE COMPRA ------------------------------------------------------------------
    
        -- Creo la tabla.
        
        CREATE TABLE IF NOT EXISTS distribuidora.DET_PURCHASE
        (
        ID_DET_PURCHASE INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  -- > Identificador de orden de compra.
        Quantity DECIMAL(5,2) NOT NULL, -- > Cantidad pedida a proveedor.
        -- Creo las FK.
        ID_PURCHASE INT NOT NULL, -- > FK de tabla compra.
        ID_PRODUCT INT NOT NULL, -- > FK de tabla producto.
        -- Creo las relaciones.
        FOREIGN KEY (ID_PURCHASE) REFERENCES PURCHASE(ID_PURCHASE),
        FOREIGN KEY (ID_PRODUCT) REFERENCES PRODUCT(ID_PRODUCT)
        );
        
       -- MOVIMIENTOS ----------------------------------------------------------------
       
       -- Creo mi tabla 
       
       CREATE TABLE IF NOT EXISTS Distribuidora.MOVE
       (
       ID_MOVE INT NOT NULL AUTO_INCREMENT primary KEY, -- > Identificador unico del movimiento de stock.
       Date_move DATE NOT NULL, -- > Fecha de movimiento.
       Quatity DECIMAL(9,2) NOT NULL,  -- > Cantidad movilizada.
       -- Creo fk.
       ID_WHEREHOUSE INT NOT NULL, -- > Clave de tabla almacen.
       ID_DET_SELL INT, -- > Clave de tabla detalle de venta.
       ID_DET_PURCHASE INT, -- > Clave de tabla detalle de compra.
       -- Creo las relaciones.
       FOREIGN KEY (ID_WHEREHOUSE) REFERENCES WHEREHOUSE(ID_WHEREHOUSE),
       FOREIGN KEY (ID_DET_SELL) REFERENCES DET_SELL(ID_DET_SELL),
       FOREIGN KEY (ID_DET_PURCHASE) REFERENCES DET_PURCHASE(ID_DET_PURCHASE)
       );
       
       
-- END ENTREGA 1.
       
       /*
Creador : GASTÓN FERNÁNDEZ.
CURSO: SQL CODERHOUSE
AÑO: 2O26

*/

-- BEGIN ENTREGA 2

 USE distribuidora; -- Utilizo la BD distribuidora.
 
-- Step 1: Inserción de datos.

	-- Inserto datos tabla de productos.
INSERT INTO PRODUCT (Name, Pack, Unit_x_pack, Unit_price, unit_weight) VALUES
('Galletitas de arroz', 'Caja', 12, 2.50, 120),
('Fideos de arroz', 'Bolsa', 10, 3.20, 500),
('Harina de almendras', 'Bolsa', 8, 5.80, 500),
('Pan sin gluten', 'Pack', 6, 4.20, 350),
('Premezcla pizza', 'Bolsa', 10, 4.90, 600),
('Galletitas de maiz', 'Caja', 12, 2.80, 150),
('Cereal sin gluten', 'Caja', 10, 4.50, 300),
('Harina de arroz', 'Bolsa', 8, 3.10, 1000),
('Snack de quinoa', 'Pack', 12, 3.70, 90),
('Granola sin TACC', 'Bolsa', 6, 5.10, 400),
('Tapas de empanada', 'Pack', 12, 3.90, 450),
('Tapas de tarta', 'Pack', 8, 4.00, 500),
('Galletas de coco', 'Caja', 10, 3.60, 200),
('Mix semillas', 'Bolsa', 6, 4.80, 250),
('Harina de garbanzo', 'Bolsa', 8, 3.90, 700);

	-- Inserto datos tabla de clientes.
INSERT INTO CLIENT 
(Company_name, fisrt_name_contact, last_name_contact, Address, Postal_code, Email, CUIT, Market)
VALUES
('Dietética Vida Sana','Juan','Perez','Av Corrientes 1234','1043','dieteticavidasana@gmail.com','30-12345678-9','Dietética'),
('Alimentos Naturales SRL','María','Gomez','Av Santa Fe 2210','1425','alimentosnaturales@gmail.com','30-23456789-1','Mayorista'),
('Mercado Saludable','Carlos','Lopez','Av Cabildo 876','1426','mercadosaludable@gmail.com','30-34567891-2','Retail'),
('Tienda Sin Gluten','Ana','Martinez','Av Rivadavia 3321','1203','tiendasingluten@gmail.com','30-45678912-3','Dietética'),
('Distribuidora Natural','Pedro','Sanchez','Belgrano 120','5000','distribuidoranatural@gmail.com','30-56789123-4','Mayorista'),
('Vida Fit','Lucia','Ramirez','Colon 800','5000','vidafit@gmail.com','30-67891234-5','Dietética'),
('Almacen Orgánico','Diego','Fernandez','San Martin 500','5500','almacenorganico@gmail.com','30-78912345-6','Retail'),
('Salud Integral','Sofia','Diaz','Mitre 900','2000','saludintegral@gmail.com','30-89123456-7','Dietética'),
('Green Market','Martin','Torres','9 de Julio 333','4000','greenmarket@gmail.com','30-91234567-8','Retail'),
('NutriVida','Paula','Suarez','Laprida 450','7600','nutrivida@gmail.com','30-22334455-6','Dietética'),
('Eco Alimentos','Ricardo','Castro','Sarmiento 222','3000','ecoalimentos@gmail.com','30-33445566-7','Mayorista'),
('Bio Market','Carla','Rojas','Italia 333','2000','biomarket@gmail.com','30-44556677-8','Retail'),
('Natural Store','Fernando','Acosta','Urquiza 900','3100','naturalstore@gmail.com','30-55667788-9','Dietética'),
('Saludable Market','Elena','Molina','España 222','4400','saludablemarket@gmail.com','30-66778899-0','Retail'),
('Dietetica Centro','Pablo','Navarro','Av Alem 120','8000','dieteticacentro@gmail.com','30-77889911-2','Dietética');
	
    -- ingreso datos de vendedores
    
INSERT INTO SELLER (Fist_name, Last_name, Email, DNI, Market) VALUES
('Lucas','Gonzalez','lucasgonzalez@gmail.com','30111222','AMBA'),
('Mariano','Perez','marianoperez@gmail.com','30222333','AMBA'),
('Carolina','Diaz','carolinadiaz@gmail.com','30333444','Interior'),
('Sebastian','Lopez','sebalopez@gmail.com','30444555','Interior'),
('Natalia','Romero','nataliaromero@gmail.com','30555666','AMBA'),
('Javier','Ruiz','javierruiz@gmail.com','30666777','Interior'),
('Florencia','Mendez','florenciamendez@gmail.com','30777888','AMBA'),
('Diego','Castillo','diegocastillo@gmail.com','30888999','Interior'),
('Valeria','Ortega','valeriaortega@gmail.com','30999000','AMBA'),
('Matias','Silva','matiassilva@gmail.com','31000111','Interior'),
('Agustina','Cabrera','agustinacabrera@gmail.com','31111222','AMBA'),
('Ezequiel','Vega','ezequielvega@gmail.com','31222333','Interior'),
('Brenda','Paz','brendapaz@gmail.com','31333444','AMBA'),
('Federico','Godoy','federicogodoy@gmail.com','31444555','Interior'),
('Rocio','Herrera','rocioherrera@gmail.com','31555666','AMBA');

	-- Inserto datos de proveedores
    
INSERT INTO SUPPLYER
(Company_name,fisrt_name_contact,last_name_contact,Address,Postal_code,Email,CUIT,Market)
VALUES
('Molinos Naturales SA','Juan','Alvarez','Ruta 8 km 40','1629','molinosnaturales@gmail.com','30-11223344-5','Harinas'),
('SinTACC Foods','Mario','Benitez','Av Industrial 450','1704','sintaccfoods@gmail.com','30-22334455-6','Alimentos'),
('Natural Grain','Laura','Campos','Ruta 9 km 20','2000','naturalgrain@gmail.com','30-33445566-7','Cereales'),
('BioHarinas','Pedro','Dominguez','Parque Industrial 100','5000','bioharinas@gmail.com','30-44556677-8','Harinas'),
('GlutenFree SA','Marta','Escobar','Av Mitre 200','1870','glutenfreesa@gmail.com','30-55667788-9','Alimentos'),
('Quinoa Foods','Ricardo','Farias','Ruta 7 km 80','5500','quinoafoods@gmail.com','30-66778899-0','Semillas'),
('Granola Natural','Carla','Gutierrez','Av Colon 450','5000','granolanatural@gmail.com','30-77889911-2','Cereales'),
('Arroz del Litoral','Luis','Herrera','Ruta 12 km 10','3400','arrozdellitoral@gmail.com','30-88991122-3','Arroz'),
('Semillas Andinas','Ana','Ibarra','Ruta 40 km 150','4400','semillasandinas@gmail.com','30-99112233-4','Semillas'),
('Campo Natural','Diego','Juarez','Av San Martin 500','5600','camponatural@gmail.com','30-12312312-3','Alimentos'),
('BioCereal','Sofia','Klein','Ruta 2 km 50','7600','biocereal@gmail.com','30-23423423-4','Cereales'),
('Natural Mix','Martin','Luna','Av Belgrano 300','2000','naturalmix@gmail.com','30-34534534-5','Snacks'),
('Eco Food','Lucia','Mora','Av Alem 100','8000','ecofood@gmail.com','30-45645645-6','Alimentos'),
('Andes Harinas','Pablo','Neri','Ruta 40 km 900','5500','andesharinas@gmail.com','30-56756756-7','Harinas'),
('Vida Natural','Elena','Ojeda','Av Roca 333','8300','vidanatural@gmail.com','30-67867867-8','Alimentos');

	-- Inserto datos de compradores
    
INSERT INTO PURCHASER (Fist_name, Last_name, Email, DNI, Market) VALUES
('Juan','Perez','juanperez@gmail.com','32111222','AMBA'),
('Maria','Gomez','mariagomez@gmail.com','32222333','Interior'),
('Carlos','Lopez','carloslopez@gmail.com','32333444','CABA'),
('Ana','Martinez','anamartinez@gmail.com','32444555','CABA'),
('Pedro','Sanchez','pedrosanchez@gmail.com','32555666','AMBA'),
('Lucia','Ramirez','luciaramirez@gmail.com','32666777','Interior'),
('Diego','Fernandez','diegofernandez@gmail.com','32777888','AMBA'),
('Sofia','Diaz','sofiadiaz@gmail.com','32888999','AMBA'),
('Martin','Torres','martintorres@gmail.com','32999000','AMBA'),
('Paula','Suarez','paulasuarez@gmail.com','33000111','Interior'),
('Ricardo','Castro','ricardocastro@gmail.com','33111222','Interior'),
('Carla','Rojas','carlarojas@gmail.com','33222333','CABA'),
('Fernando','Acosta','fernandoacosta@gmail.com','33333444','AMBA'),
('Elena','Molina','elenamolina@gmail.com','33444555','Interior'),
('Pablo','Navarro','pablonavarro@gmail.com','33555666','CABA');

-- Inserto datos en wherehouse 

INSERT INTO WHEREHOUSE (hallway,row_where,column_where) VALUES
(1,1,'A'),
(1,1,'B'),
(1,2,'A'),
(1,2,'B'),
(2,1,'A'),
(2,1,'B'),
(2,2,'A'),
(2,2,'B'),
(3,1,'A'),
(3,1,'B'),
(3,2,'A'),
(3,2,'B'),
(4,1,'A'),
(4,1,'B'),
(4,2,'A');

	--  Inserto datos de ventas.
    
INSERT INTO SELL (Date_Sell,ID_CLIENT,ID_SELLER) VALUES
('2025-01-05',1,1),
('2025-01-07',2,2),
('2025-01-08',3,3),
('2025-01-10',4,4),
('2025-01-11',5,5),
('2025-01-12',6,6),
('2025-01-15',7,7),
('2025-01-16',8,8),
('2025-01-17',9,9),
('2025-01-18',10,10),
('2025-01-20',11,11),
('2025-01-21',12,12),
('2025-01-22',13,13),
('2025-01-23',14,14),
('2025-01-24',15,15),
('2025-02-01',1,5),
('2025-02-02',3,2),
('2025-02-03',4,8),
('2025-02-04',2,7),
('2025-02-05',6,3),
('2025-02-06',7,9),
('2025-02-07',8,4),
('2025-02-08',9,6),
('2025-02-09',10,1),
('2025-02-10',11,10),
('2025-02-11',12,12),
('2025-02-12',13,11),
('2025-02-13',14,14),
('2025-02-14',15,13),
('2025-02-15',5,15),
('2025-02-12',13,11),
('2025-02-13',14,14),
('2025-02-14',15,13),
('2025-02-15',5,15);

-- Inserto datos de compras

INSERT INTO PURCHASE (Date_purchase,ID_SUPPLYER,ID_PURCHASER) VALUES
('2024-12-01',1,1),
('2024-12-02',2,2),
('2024-12-03',3,3),
('2024-12-04',4,4),
('2024-12-05',5,5),
('2024-12-06',6,6),
('2024-12-07',7,7),
('2024-12-08',8,8),
('2024-12-09',9,9),
('2024-12-10',10,10),
('2024-12-11',11,11),
('2024-12-12',12,12),
('2024-12-13',13,13),
('2024-12-14',14,14),
('2024-12-15',15,15),
('2025-01-10',2,5),
('2025-01-11',4,2),
('2025-01-12',6,3),
('2025-01-13',8,4),
('2025-01-14',1,6),
('2025-01-15',3,7),
('2025-01-16',5,8),
('2025-01-17',7,9),
('2025-01-18',9,10),
('2025-01-19',10,11),
('2025-01-20',11,12),
('2025-01-21',12,13),
('2025-01-22',13,14),
('2025-01-23',14,15),
('2025-01-24',15,1);

-- Inserto datos de detalles de ventas.
INSERT INTO DET_SELL (Quantity,ID_SELL,ID_PRODUCT) VALUES
(10,1,1),
(5,2,2),
(8,3,3),
(12,4,4),
(7,5,5),
(6,6,6),
(9,7,7),
(11,8,8),
(4,9,9),
(3,10,10),
(15,11,11),
(10,12,12),
(7,13,13),
(5,14,14),
(8,15,15),
(6,16,3),
(10,17,5),
(4,18,7),
(8,19,2),
(12,20,6),
(5,21,8),
(7,22,9),
(9,23,4),
(11,24,10),
(3,25,1),
(14,26,11),
(6,27,12),
(8,28,13),
(10,29,14),
(7,30,15);

-- Inserto datos de detalles de compra

INSERT INTO DET_PURCHASE (Quantity,ID_PURCHASE,ID_PRODUCT) VALUES
(100,1,1),
(120,2,2),
(90,3,3),
(80,4,4),
(150,5,5),
(110,6,6),
(130,7,7),
(140,8,8),
(160,9,9),
(100,10,10),
(90,11,11),
(120,12,12),
(140,13,13),
(110,14,14),
(150,15,15),
(200,16,1),
(150,17,2),
(180,18,3),
(170,19,4),
(160,20,5),
(140,21,6),
(130,22,7),
(120,23,8),
(110,24,9),
(100,25,10),
(90,26,11),
(80,27,12),
(70,28,13),
(60,29,14),
(50,30,15);

-- Inserto datos de movimientos

INSERT INTO MOVE (Date_move,Quatity,ID_WHEREHOUSE,ID_DET_SELL,ID_DET_PURCHASE) VALUES
('2024-12-01',100,1,NULL,1),
('2024-12-02',120,2,NULL,2),
('2024-12-03',90,3,NULL,3),
('2024-12-04',80,4,NULL,4),
('2024-12-05',150,5,NULL,5),
('2024-12-06',110,6,NULL,6),
('2024-12-07',130,7,NULL,7),
('2024-12-08',140,8,NULL,8),
('2024-12-09',160,9,NULL,9),
('2024-12-10',100,10,NULL,10),
('2025-01-05',10,1,1,NULL),
('2025-01-07',5,2,2,NULL),
('2025-01-08',8,3,3,NULL),
('2025-01-10',12,4,4,NULL),
('2025-01-11',7,5,5,NULL),
('2025-01-10',200,6,NULL,16),
('2025-01-11',150,7,NULL,17),
('2025-01-12',180,8,NULL,18),
('2025-01-13',170,9,NULL,19),
('2025-01-14',160,10,NULL,20),
('2025-01-15',140,11,NULL,21),
('2025-01-16',130,12,NULL,22),
('2025-01-17',120,13,NULL,23),
('2025-01-18',110,14,NULL,24),
('2025-01-19',100,15,NULL,25),
('2025-02-01',6,6,16,NULL),
('2025-02-02',10,7,17,NULL),
('2025-02-03',4,8,18,NULL),
('2025-02-04',8,9,19,NULL),
('2025-02-05',12,10,20,NULL);

-- Vista 1

-- > Clientes criticos.

CREATE OR REPLACE VIEW vw_clientes_criticos AS
SELECT
 c.ID_Client AS '#Cliente',
 c.company_name AS Cliente,
 count(s.id_Sell) AS Ventas
FROM Client  AS c
INNER JOIN sell AS S 
	ON c.ID_Client = S.ID_Client
GROUP BY Cliente
ORDER BY ventas DESC LIMIT 5;

--  Vista 2

-- > Productos criticos.

CREATE OR REPLACE VIEW vw_productos_criticos AS 
SELECT
	P.ID_Product AS '#Producto',
	p.Name AS Producto,
   round(ds.ID_PRODUCT*p.unit_x_pack*p.unit_price) AS Facturación
FROM product AS p
INNER JOIN 
	Det_sell AS ds ON p.id_PRODUCT = ds.ID_product
GROUP BY
	DS.ID_PRODUCT
ORDER BY Facturación DESC LIMIT 5;

-- Vista 3
	-- > Mercado destacado
    
    CREATE OR REPLACE VIEW vw_mercado_clave AS
SELECT
    c.Market AS Mercado,
    ROUND(SUM(ds.quantity * p.unit_x_pack * p.unit_price)) AS facturado
FROM sell s
JOIN client c ON c.ID_Client = s.ID_Client
JOIN det_sell ds ON ds.ID_Sell = s.ID_Sell
JOIN product p ON p.ID_Product = ds.ID_Product
GROUP BY c.Market;
    
-- FUNCIONES

-- > STOCK ACTUAL

DELIMITER $$

CREATE FUNCTION distribuidora.fn_Stock_actual (ID_Producto INT)
RETURNS INT
DETERMINISTIC
	BEGIN 
		DECLARE resultado INT DEFAULT 0 ;
		DECLARE entrada INT DEFAULT 0;
        DECLARE Salida INT DEFAULT 0;
        SELECT COALESCE(sum(dp.Quantity),0)
        INTO entrada 
        FROM Det_purchase AS DP 
        WHERE DP.ID_PRODUCT = ID_PRODUCTO;
        SELECT COALESCE(sum(ds.Quantity),0)
        INTO salida
        FROM Det_sell AS DS
        WHERE DS.ID_PRODUCT = ID_PRODUCTO;
        SET RESULTADO = ENTRADA - SALIDA;
        RETURN Resultado;
	END $$
    
DELIMITER ;
-- > Función 2

DELIMITER $$

DROP FUNCTION IF EXISTS distribuidora.fn_factura_pedido $$
CREATE FUNCTION distribuidora.fn_factura_pedido (p_id_sell INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE v_facturado DECIMAL(12,2) DEFAULT 0;

    SELECT COALESCE(SUM(ds.quantity * (p.unit_x_pack * p.unit_price)), 0)
      INTO v_facturado
      FROM det_sell AS ds
      JOIN product  AS p
        ON p.ID_PRODUCT = ds.ID_PRODUCT
     WHERE ds.ID_Sell = p_id_sell;

    RETURN v_facturado;
END $$

DELIMITER ;

-- STORED PROCEDDURES

-- > Movimientos de material

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_mov_producto$$
CREATE PROCEDURE sp_mov_producto (IN p_id_product INT)
BEGIN
    -- ENTRADAS (compras)
    SELECT
        dp.ID_PRODUCT AS id_producto,
        dp.quantity AS cantidad,
        'ENTRADA' AS tipo_mov,
        m.date_move AS fecha
    FROM det_purchase AS dp
    INNER JOIN move as m ON m.ID_DET_PURCHASE = dp.ID_DET_PURCHASE
    WHERE dp.ID_PRODUCT = p_id_product

    UNION ALL

    -- SALIDAS (ventas)
    SELECT
        ds.ID_PRODUCT AS id_producto,
        ds.quantity*-1 AS cantidad,
        'SALIDA' AS tipo_mov,
        m.date_move AS fecha
    FROM det_sell AS ds
    INNER JOIN move as m ON m.ID_DET_SELL = ds.ID_DET_SELL
    WHERE ds.ID_PRODUCT = p_id_product;
END$$

DELIMITER ;

-- STORED PROCEDURE 2

-- > Stock

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_stock_product $$

CREATE PROCEDURE sp_stock_product (IN ID_Product INT)
	BEGIN
		SELECT 
        Dp.ID_PRODUCT AS '#Producto',
        m.quatity as Cantidad,
        M.date_move as fecha,
        Wh.ID_WHEREHOUSE AS Posicion,
        CONCAT(Wh.Hallway,'-', Wh.row_where, '-', Wh.column_where) AS ubicacion
        FROM wherehouse AS Wh
        iNNER JOIN move AS m ON m.ID_WHEREHOUSE = Wh.ID_WHEREHOUSE
        INNER JOIN Det_purchase AS Dp ON dp.ID_DET_PURCHASE = M.ID_DET_PURCHASE
		WHERE dp.ID_PRODUCT = ID_PRODUCT;
    END $$
    
DELIMITER ;

 -- TRIGERS
    
    -- > VALIDADOR DE FECHAS
    
    DELIMITER $$
    
    DROP TRIGGER IF EXISTS trg_fecha_pedido $$
    CREATE TRIGGER trg_fecha_pedido 
    BEFORE INSERT ON SELL
    FOR EACH ROW 
    BEGIN
		IF new.Date_Sell <> current_date()
        THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha debe ser la actual';
        END IF;
	END $$

DELIMITER ;
--  Trigger 2
	-- > Validador de mails
    
    DELIMITER $$
    DROP TRIGGER IF EXISTS trg_val_mail $$
    CREATE TRIGGER trg_val_mail
    BEFORE INSERT ON CLIENT
    FOR EACH ROW
    BEGIN
    IF LOWER(new.Email) NOT LIKE '%@gmail.com'
		THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El mail debe ser valido';
        END IF;
	END $$
    
    DELIMITER ;
    
    -- END ENTREGA 2.
       
       /*
Creador : GASTÓN FERNÁNDEZ.
CURSO: SQL CODERHOUSE
AÑO: 2O26
*/
