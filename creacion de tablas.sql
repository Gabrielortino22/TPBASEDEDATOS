-- 1.Creación de tablas:
-- Creación de tabla clientes:
CREATE TABLE Clientes (
  idclientes INT PRIMARY KEY,
  nombre VARCHAR(50),
  correo VARCHAR(50),
  direccion VARCHAR(100)
);
-- Creación de tabla productos:

CREATE TABLE Producto (
  IdProductos INT PRIMARY KEY,
  Nombres VARCHAR(45),
  Precio VARCHAR(45),
  stock INT,
  );

-- Creación tabla compra:

CREATE TABLE Compra (
  idcompra INT PRIMARY KEY,
  idclientes INT,
  cantidad INT,
  fecha DATE,
  IdProductos INT,
  FOREIGN KEY (idclientes) REFERENCES clientes(idclientes),
  FOREIGN KEY (IdProductos) REFERENCES productos(IdProductos)
);
