-- BASE DE DATO DE DISTRIBUIDORA.

/*
Creador : GASTÓN FERNÁNDEZ.
CURSO: SQL CODERHOUSE
AÑO: 2O26

*/
        
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
       
       -- END.
       
       /*
Creador : GASTÓN FERNÁNDEZ.
CURSO: SQL CODERHOUSE
AÑO: 2O26

*/