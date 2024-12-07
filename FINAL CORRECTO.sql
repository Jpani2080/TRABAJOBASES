
    CREATE DATABASE tarea22;

USE tarea22;

-- Tabla de clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Telefono VARCHAR(15),
    Email VARCHAR(100),
    Direccion VARCHAR(255),
    FechaRegistro DATE 
);

-- Tabla de vehículos
CREATE TABLE Vehiculos (
    VehiculoID INT PRIMARY KEY,
    ClienteID INT,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Ano INT NOT NULL,
    Placa VARCHAR(20) UNIQUE NOT NULL,
    TipoVehiculo VARCHAR(15) DEFAULT 'Automóvil' NOT NULL, 
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Restricción CHECK para limitar los valores de TipoVehiculo
ALTER TABLE Vehiculos
ADD CONSTRAINT CHK_TipoVehiculo 
CHECK (TipoVehiculo IN ('Automóvil', 'Motocicleta', 'Camión', 'Otro'));

-- Tabla de empleados
CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    Telefono VARCHAR(15),
    Email VARCHAR(100),
    FechaContratacion DATE 
);

-- Tabla de servicios
CREATE TABLE Servicios (
    ServicioID INT PRIMARY KEY,
    NombreServicio VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10, 2) NOT NULL
);

-- Tabla de repuestos
CREATE TABLE Repuestos (
    RepuestoID INT PRIMARY KEY,
    NombreRepuesto VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL
);

-- Tabla de órdenes de reparación
CREATE TABLE OrdenesReparacion (
    OrdenID INT PRIMARY KEY,
    VehiculoID INT NOT NULL,
    EmpleadoID INT NOT NULL,
    FechaInicio DATE,
    FechaFin DATE,
    Estado VARCHAR(15) DEFAULT 'Pendiente',
    Total DECIMAL(10, 2),
    FOREIGN KEY (VehiculoID) REFERENCES Vehiculos(VehiculoID),
    FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID)
);

ALTER TABLE OrdenesReparacion
ADD CONSTRAINT CHK_Estado 
CHECK (Estado IN ('Pendiente', 'En Proceso', 'Completada', 'Cancelada'));

-- Tabla de detalle de servicios en la orden
CREATE TABLE DetalleServicios (
    DetalleID INT PRIMARY KEY,
    OrdenID INT NOT NULL,
    ServicioID INT NOT NULL,
    Cantidad INT NOT NULL,
    Subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrdenID) REFERENCES OrdenesReparacion(OrdenID),
    FOREIGN KEY (ServicioID) REFERENCES Servicios(ServicioID)
);

-- Tabla de detalle de repuestos en la orden
CREATE TABLE DetalleRepuestos (
    DetalleID INT PRIMARY KEY,
    OrdenID INT NOT NULL,
    RepuestoID INT NOT NULL,
    Cantidad INT NOT NULL,
    Subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrdenID) REFERENCES OrdenesReparacion(OrdenID),
    FOREIGN KEY (RepuestoID) REFERENCES Repuestos(RepuestoID)
);

-- Tabla de facturación
CREATE TABLE Facturas (
    FacturaID INT PRIMARY KEY,
    OrdenID INT NOT NULL,
    FechaFactura DATE,
    TotalFactura DECIMAL(10, 2),
    FOREIGN KEY (OrdenID) REFERENCES OrdenesReparacion(OrdenID)
);

-- Insertar datos de ejemplo en Clientes
INSERT INTO Clientes (ClienteID, Nombre, Apellidos, Telefono, Email, Direccion, FechaRegistro) VALUES
(1, 'Juan', 'Pérez', '555123456', 'juan.perez@example.com', 'Calle Falsa 123','2024-07-10'),
(2, 'María', 'Gómez', '555987654', 'maria.gomez@example.com', 'Avenida Siempre Viva 456', '2024-10-26'),
(3, 'Juan', 'Pérez', '555-1234', 'juan.perez@mail.com', 'Calle 1', '2024-11-30'),
(4, 'María', 'López', '555-5678', 'maria.lopez@mail.com', 'Calle 2', '2024-11-30'),
(5, 'Carlos', 'Martínez', '555-8765', 'carlos.martinez@mail.com', 'Calle 3', '2024-11-28'),
(6, 'Luisa', 'González', '555-1122', 'luisa.gonzalez@mail.com', 'Calle 4', '2024-11-27'),
(7, 'Pedro', 'Ruiz', '555-2233', 'pedro.ruiz@mail.com', 'Calle 5', '2024-11-25'),
(8, 'Ana', 'Sánchez', '555-3344', 'ana.sanchez@mail.com', 'Calle 6', '2024-11-24'),
(9, 'José', 'Rodríguez', '555-4455', 'jose.rodriguez@mail.com', 'Calle 7', '2024-11-23'),
(10, 'Raúl', 'Martín', '555-5566', 'raul.martin@mail.com', 'Calle 8', '2024-11-22'),
(11, 'Isabel', 'Fernández', '555-6677', 'isabel.fernandez@mail.com', 'Calle 9', '2024-11-20'),
(12, 'Luis', 'López', '555-7788', 'luis.lopez@mail.com', 'Calle 10', '2024-11-19'),
(13, 'Eva', 'Mendoza', '555-8899', 'eva.mendoza@mail.com', 'Calle 11', '2024-11-18'),
(14, 'Ricardo', 'Martínez', '555-9900', 'ricardo.martinez@mail.com', 'Calle 12', '2024-11-17'),
(15, 'Patricia', 'Ramírez', '555-1010', 'patricia.ramirez@mail.com', 'Calle 13', '2024-11-16'),
(16, 'Tomás', 'Díaz', '555-1111', 'tomas.diaz@mail.com', 'Calle 14', '2024-11-15');

-- Insertar datos de ejemplo en Vehiculos (corregido)
INSERT INTO Vehiculos (ClienteID, VehiculoID, Marca, Modelo, Ano, Placa, TipoVehiculo) VALUES
(1, 1, 'Toyota', 'Corolla', 2015, 'ABC1242', 'Automóvil'),
(2, 2, 'Honda', 'Civic', 2018, 'XYZ7842', 'Automóvil'),
(3, 3, 'Toyota', 'Corolla', 2020, 'ABC123', 'Automóvil'),
(4, 4, 'Honda', 'Civic', 2019, 'XYZ789', 'Automóvil'),
(5, 5, 'Ford', 'Focus', 2018, 'FDF456', 'Automóvil'),
(6, 6, 'Chevrolet', 'Cruze', 2021, 'CRU234', 'Automóvil'),
(7, 7, 'Nissan', 'Altima', 2017, 'ALT567', 'Automóvil'),
(8, 8, 'Mazda', '3', 2016, 'MAZ123', 'Automóvil'),
(9, 9, 'Kia', 'Optima', 2022, 'OPT999', 'Automóvil'),
(10, 10, 'Hyundai', 'Elantra', 2021, 'ELA888', 'Automóvil'),
(11, 11, 'BMW', 'X5', 2020, 'X50001', 'Automóvil'),
(12, 12, 'Audi', 'Q5', 2020, 'Q50002', 'Automóvil'),
(13, 13, 'Mercedes-Benz', 'C-Class', 2019, 'MB1234', 'Automóvil'),
(14, 14, 'Volkswagen', 'Golf', 2020, 'VWL567', 'Automóvil'),
(15, 15, 'Subaru', 'Outback', 2018, 'SUB345', 'Automóvil'),
(16, 16, 'Jeep', 'Cherokee', 2019, 'JEEP456', 'Automóvil');

-- Insertar datos de ejemplo en Empleados
INSERT INTO Empleados (EmpleadoID, Nombre, Apellidos, Cargo, Telefono, Email) VALUES
(1, 'Luis', 'Gómez', 'Mecánico', '555-9876', 'luis.gomez@mail.com'),
(2, 'Ana', 'Martínez', 'Recepcionista', '555-6543', 'ana.martinez@mail.com'),
(3, 'Carlos', 'Sánchez', 'Mecánico', '555-4321', 'carlos.sanchez@mail.com'),
(4, 'José', 'Fernández', 'Jefe de Taller', '555-1122', 'jose.fernandez@mail.com'),
(5, 'María', 'Ramírez', 'Asistente Administrativo', '555-3344', 'maria.ramirez@mail.com'),
(6, 'Pedro', 'García', 'Mecánico', '555-5566', 'pedro.garcia@mail.com'),
(7, 'Raúl', 'Díaz', 'Recepcionista', '555-6677', 'raul.diaz@mail.com'),
(8, 'Isabel', 'López', 'Mecánico', '555-7788', 'isabel.lopez@mail.com'),
(9, 'Verónica', 'Pérez', 'Administrativa', '555-8899', 'veronica.perez@mail.com'),
(10, 'David', 'Moreno', 'Jefe de Taller', '555-9900', 'david.moreno@mail.com'),
(11, 'Tomás', 'Gutiérrez', 'Mecánico', '555-1010', 'tomas.gutierrez@mail.com'),
(12, 'Patricia', 'Vázquez', 'Mecánico', '555-1123', 'patricia.vazquez@mail.com'),
(13, 'Ricardo', 'Jiménez', 'Asesor Técnico', '555-2234', 'ricardo.jimenez@mail.com'),
(14, 'Luis', 'Castillo', 'Mecánico', '555-3345', 'luis.castillo@mail.com'),
(15, 'Javier', 'Torres', 'Jefe de Mecánicos', '555-4456', 'javier.torres@mail.com');

-- Insertar datos de ejemplo en Servicios
INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio) VALUES
(1, 'Cambio de Aceite', 'Aceite sintético 5W-30', 50.00),
(2, 'Alineación y Balanceo', 'Alineación de las 4 ruedas', 30.00),
(3, 'Revisión General', 'Inspección completa del auto', 80.00),
(4, 'Frenos', 'Reemplazo de pastillas de freno', 100.00),
(5, 'Cambio de Neumáticos', 'Cambio de los 4 neumáticos', 200.00),
(6, 'Sistema de Suspensión', 'Revisión y reparación de suspensión', 150.00),
(7, 'Diagnóstico Eléctrico', 'Revisión de sistema eléctrico', 120.00),
(8, 'Batería', 'Cambio de batería nueva', 90.00),
(9, 'Cambio de Filtro de Aire', 'Reemplazo de filtro de aire', 25.00),
(10, 'Reemplazo de Correa', 'Cambio de correa de distribución', 110.00),
(11, 'Lavado de Motor', 'Limpieza del motor del vehículo', 40.00),
(12, 'Reparación de Transmisión', 'Reparación de transmisión automática', 250.00),
(13, 'Chequeo de Radiador', 'Revisión del sistema de refrigeración', 70.00),
(14, 'Ajuste de Dirección', 'Reparación y alineación de dirección', 60.00),
(15, 'Servicio de Climatización', 'Reparación del aire acondicionado', 130.00);

-- Insertar datos de ejemplo en Repuestos
INSERT INTO Repuestos (RepuestoID, NombreRepuesto, Descripcion, Precio, Stock) VALUES
(1, 'Filtro de aire', 'Filtro de aire para motor', 15.50, 100),
(2, 'Pastillas de freno', 'Juego de pastillas para freno delantero',  45.30, 50),
(3, 'Bujía', 'Bujía de encendido para motor de 4 cilindros', 5.75, 200),
(4, 'Amortiguador', 'Amortiguador delantero para vehículo tipo sedan', 120.00, 30),
(5, 'Aceite de motor', 'Aceite para motor 5W-30', 25.00, 75);

INSERT INTO OrdenesReparacion (OrdenID, VehiculoID, EmpleadoID, FechaInicio, FechaFin, Estado, Total) VALUES
(1, 1, 1, '2024-01-10', '2024-01-15', 'Completada', 250.00),
(2, 2, 3, '2024-02-15', '2024-02-20', 'Completada', 300.00),
(3, 3, 1, '2024-03-05', '2024-03-10', 'En Proceso', 180.00),
(4, 4, 2, '2024-04-12', NULL, 'Pendiente', NULL),
(5, 5, 3, '2024-05-01', '2024-05-05', 'Completada', 400.00);

SELECT c.Nombre AS NombreCliente, c.Apellidos AS ApellidosCliente, 
       v.Marca, v.Modelo, v.Ano, v.Placa
FROM Clientes c
LEFT JOIN Vehiculos v ON c.ClienteID = v.ClienteID;

SELECT SUM(ds.Subtotal) AS TotalIngresos
FROM DetalleServicios ds
JOIN OrdenesReparacion o ON ds.OrdenID = o.OrdenID
WHERE MONTH(o.FechaInicio) = 1 AND YEAR(o.FechaInicio) = 2024;

SELECT o.OrdenID, c.Nombre AS NombreCliente, c.Apellidos AS ApellidosCliente, 
       v.Marca, v.Modelo, v.Placa, o.FechaInicio
FROM OrdenesReparacion o
JOIN Vehiculos v ON o.VehiculoID = v.VehiculoID
JOIN Clientes c ON v.ClienteID = c.ClienteID
WHERE o.Estado = 'Pendiente';

SELECT o.OrdenID, c.Nombre AS NombreCliente, c.Apellidos AS ApellidoCliente, 
       e.Nombre AS NombreEmpleado, e.Apellidos AS ApellidoEmpleado,
       o.FechaInicio, o.FechaFin, o.Estado, o.Total
FROM OrdenesReparacion o
JOIN Vehiculos v ON o.VehiculoID = v.VehiculoID
JOIN Clientes c ON v.ClienteID = c.ClienteID
JOIN Empleados e ON o.EmpleadoID = e.EmpleadoID;

