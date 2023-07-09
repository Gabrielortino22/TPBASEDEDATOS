-- 3.Modificación de tablas:

-- ● Agrega una columna "descuento" a la tabla "Productos" utilizando ALTER TABLE.

ALTER TABLE productos
ADD descuento decimal(10,2);


-- ● Modifica el tipo de datos de la columna "precio" en la tabla "Productos" utilizando

ALTER COLUMN.
ALTER TABLE productos
MODIFY COLUMN Precio BIGINT not null;

-- 4.consultas

-- ● Realiza una consulta utilizando SELECT JOIN para obtener la información de los productos comprados por cada cliente.

SELECT clientes.idclientes, clientes.nombre, compra.idcompra, compra.IdProductos, compra.cantidad, compra.fecha
FROM clientes
JOIN compra ON clientes.idclientes = compra.idclientes;

-- ● Crea una VIEW que muestre los productos con descuento.

CREATE VIEW ProductosConDescuento AS
SELECT *
FROM productos
WHERE descuento > 10;


 -- ● Crea un INDEX en la columna "nombre" de la tabla "Productos" para mejorar la velocidad de las consultas.

ALTER TABLE productos
ADD INDEX idx_nombre (Nombres);

-- 5.Procedimientos almacenados:

-- ● Crea un STORE PROCEDURE que calcule el total de ventas para un cliente dado.

DELIMITER //
CREATE PROCEDURE CalcularTotalVentas(
    IN clienteId INT,
    OUT totalVentas DECIMAL(10, 2)
)
BEGIN
    SELECT SUM(p.Precio * c.cantidad) INTO totalVentas
    FROM Compra c
    INNER JOIN productos p ON c.idproductos = p.idproductos
    WHERE c.idclientes = clienteId;
END //
DELIMITER ;

-- ● Utiliza el STORE PROCEDURE para obtener el total de ventas de un cliente específico.

SET @resultado = 0;
CALL CalcularTotalVentas(1, @resultado);
SELECT @resultado;

-- 6.Funciones:

-- ● Crea una función que calcule el promedio de precios de los productos.

SET @@global.log_bin_trust_function_creators = 1;
DELIMITER //

CREATE FUNCTION CalcularPromedioPrecios()
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE promedio DECIMAL(10, 2);
    SELECT AVG(precio) INTO promedio
    FROM productos;
    RETURN promedio;
END //

DELIMITER ;


-- ● Utiliza la función para obtener el promedio de precios de todos los productos.

SELECT CalcularPromedioPrecios() AS promedio_precios;

-- 7.Transacciones:

-- ● Crea una transacción que inserte un nuevo cliente y una nueva orden de compra al mismo tiempo.




-- ● Asegúrate de que la transacción se ejecute correctamente y se haga un rollback encaso de error



-- 8.Triggers:

-- ● Crea un TRIGGER que actualice el stock de un producto después de realizar una orden de compra.

DELIMITER //
CREATE TRIGGER actualizar_stock AFTER INSERT ON compra
FOR EACH ROW
BEGIN
    -- Obtiene el id del producto insertado en la orden de compra
    SELECT NEW.IdProductos INTO @producto_id;

    -- Obtiene la cantidad comprada en la orden de compra
    SELECT NEW.cantidad INTO @cantidad_comprada;

    -- Actualiza el stock del producto restando la cantidad comprada
    UPDATE productos
    SET stock = stock - @cantidad_comprada
    WHERE IdProductos = @producto_id;
END //
DELIMITER ;

-- ● Verifica que el TRIGGER se dispare correctamente y actualice el stock de manera






