-- Creamos nuestra base de datos

CREATE DATABASE DB_Buena_Salud
GO

-- Nos ubicamos dentro de nuestra base de datos
USE DB_Buena_Salud
GO

-- Creamos las tablas

CREATE TABLE dept(
	id_dept INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	nombre VARCHAR(32) NOT NULL,
	loc VARCHAR(32) NOT NULL
	)
GO

CREATE TABLE emp(
	id_emp INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	nombre VARCHAR(32) NOT NULL,
	apellido VARCHAR(64) NOT NULL,
	oficio VARCHAR(64) NOT NULL,
	direccion VARCHAR(64) NOT NULL,
	fehca_alta DATE NOT NULL,
	salario DECIMAL(8, 2) NOT NULL,
	comision DECIMAL(8, 2),
	estado BIT DEFAULT 1,
	id_dept INT
	)
GO

-- Agregamos edad a la tabla
ALTER TABLE dbo.emp ADD edad INT NULL
GO 

CREATE TABLE enfermo(
	id_enfermo INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	inscripcion DATE NOT NULL,
	nombre VARCHAR(32),
	apellido VARCHAR(64) NOT NULL,
	direccion VARCHAR(64) NOT NULL,
	fecha_nac DATE NOT NULL
	)
GO

-- Creeamos una llave foranea, para relacionar la tabla de emp con dept

ALTER TABLE emp ADD CONSTRAINT fk_id_dept
FOREIGN KEY (id_dept )
REFERENCES dept(id_dept)
GO

-- Insertamos departamentos y realizamos la lista 2

-- 2.-Crear un procedimiento almacenado que permita insertar un nuevo departamento

CREATE PROCEDURE sp_agregar_departamento
@nombre VARCHAR(32),
@loc VARCHAR(32)
AS
BEGIN
IF NOT EXISTS(SELECT * FROM dept WHERE nombre = @nombre)
	BEGIN
		INSERT INTO dept(nombre, loc) VALUES(
			@nombre,
			@loc
			)
	END
ELSE
	BEGIN
		RAISERROR('Departamento ya existe', 16, 1)
		WITH NOWAIT
	END
END
GO

EXEC sp_agregar_departamento "Medicina general", Puno
EXEC sp_agregar_departamento Odontologia, Puno
EXEC sp_agregar_departamento "Emergencia", Puno
EXEC sp_agregar_departamento "Pediatria", Puno
EXEC sp_agregar_departamento "Psiquiatria", Puno
EXEC sp_agregar_departamento "Farmacia", Puno
EXEC sp_agregar_departamento "Laboratorio", Puno
EXEC sp_agregar_departamento "Radiologia", Puno
EXEC sp_agregar_departamento "Gerencia", Puno
GO

SELECT * FROM dept
GO

-- Insertamos datos en en la tabla empleados, nos ayudaremos de los procedimietos almacenados

CREATE PROCEDURE sp_agregar_emp
@nombre VARCHAR(32),
@apellido VARCHAR(64),
@oficio VARCHAR(32),
@direccion VARCHAR(64),
@fecha_alta DATE,
@salario DECIMAL(8, 2),
@comision DECIMAL(8, 2),
@id_dep INT,
@edad INT
AS
BEGIN
IF NOT EXISTS(SELECT * FROM emp 
			WHERE @nombre = nombre AND
				  @apellido = apellido AND
				  @edad = edad AND
				  @direccion = direccion)
	BEGIN
		INSERT INTO emp(nombre, apellido, oficio, direccion, fehca_alta, salario, comision, estado, id_dept, edad)
			VALUES (
			@nombre,
			@apellido,
			@oficio,
			@direccion,
			@fecha_alta,
			@salario,
			@comision,
			1,
			@id_dep,
			@edad
			)
	END
ELSE
	BEGIN
		RAISERROR('Empleado ya registrado', 16, 1)
		WITH NOWAIT
	END
END
GO

EXEC sp_agregar_emp Kenyi, Hancco, "Gerente general", "Calle Miraflores, Juliaca","2017-01-01", 7999.00, 1999.99, 9, 25
GO
EXEC sp_agregar_emp Narcisa, Galvez, "Medico general", "Calle Los Tulipanes, Juliaca","2017-11-01", 1599.00, 99.99, 1, 28
EXEC sp_agregar_emp Kenyi, Hancco, "Medico general", "Calle El Triunfo, Juliaca","2017-11-01", 1599.00, 99.99, 1, 27
EXEC sp_agregar_emp Kenyi, Hancco, "Odontologo", "Calle Brasil, Juliaca","2017-11-01", 1299.00, 599.90, 2, 25
EXEC sp_agregar_emp Cecilio, Herrera, "Odontologo", "Calle Ecuador, Juliaca","2017-11-01", 1299.00, 599.90, 2, 29
EXEC sp_agregar_emp Harold, Palomar, "Medico general", "Calle Colombia, Juliaca","2018-01-01", 1199.00, 499.90, 3, 26
EXEC sp_agregar_emp Juan, Ramis, "Medico general", "Calle Peru, Juliaca","2018-01-01", 1199.00, 499.90, 3, 25
EXEC sp_agregar_emp Ana, Elorza, "Pediatra", "Calle El Triunfo, Juliaca","2018-01-01", 1199.00, 499.90, 4, 23
EXEC sp_agregar_emp Kenyi, Hancco, "Pediatra", "Calle Ecuador, Juliaca","2018-01-01", 1199.00, 499.90, 4, 27
EXEC sp_agregar_emp Paola, Gonzales, "Psiquiatra", "Calle Mexico, Juliaca","2018-11-01", 1199.00, 499.90, 5, 26
EXEC sp_agregar_emp Kenyi, Hancco, "Psiquiatra", "Calle El Salvador, Juliaca","2018-01-01", 1199.00, 499.90, 5, 22
EXEC sp_agregar_emp Coral, Prada, "Farmaceutico", "Calle Espana, Juliaca","2018-01-01", 1199.00, 499.90, 6, 27
EXEC sp_agregar_emp Ismael, Vasquez, "Farmaceutico", "Calle Madrid, Juliaca","2018-11-01", 1199.00, 499.90, 6, 22
EXEC sp_agregar_emp Kenyi, Hancco, "Tecnologo medico", "Calle Puno, Juliaca","2018-01-01", 1199.00, 499.90, 7, 24
EXEC sp_agregar_emp Kenyi, Hancco, "Tecnologo medico", "Calle Arequipa, Juliaca","2018-01-01", 1199.00, 499.90, 7, 28
EXEC sp_agregar_emp Florencio, Cepeda, "Radiologo", "Calle Tacna, Juliaca","2018-01-01", 1199.00, 499.90, 8, 24
EXEC sp_agregar_emp Lupita, Borrel, "Radiologo", "Calle Tumbes, Juliaca","2018-01-01", 1199.00, 499.90, 8, 26
EXEC sp_agregar_emp Candido, Pinedo, "Medico cirujano", "Calle Piura, Juliaca","2018-01-01", 7999.00, 1999.99, 1, 22
EXEC sp_agregar_emp Azucena, "del Rey", "Medico cirujano", "Calle Madre de Dios, Juliaca","2018-01-01", 7999.00, 1999.99, 1, 26
EXEC sp_agregar_emp Jesus, Barcena, "Odontologo", "Calle Los Pinos, Juliaca","2018-01-01", 1299.00, 599.90, 2, 24
GO

SELECT * FROM emp
GO

UPDATE emp SET edad = 25 WHERE id_emp = 1
GO

UPDATE emp SET nombre = 'Hector', apellido = 'Aroquipa' WHERE id_emp = 3
UPDATE emp SET nombre = 'Edgar', apellido = 'Perello' WHERE id_emp = 4
UPDATE emp SET nombre = 'Odaliz', apellido = 'Cruz' WHERE id_emp = 5
UPDATE emp SET nombre = 'Feliciano', apellido = 'Quintanilla' WHERE id_emp = 6
UPDATE emp SET nombre = 'Imelda', apellido = 'Acuna' WHERE id_emp = 7
UPDATE emp SET nombre = 'Domitila', apellido = 'Garay' WHERE id_emp = 8

UPDATE emp SET salario = 1999.90, comision = 999.90 WHERE id_emp = 11
UPDATE emp SET salario = 1999.90, comision = 999.90 WHERE id_emp = 12

-- Generamos la consulta para la afirmacion 1

SELECT
e.nombre + ' '+ e.apellido AS 'Nombre y apellidos',
e.fehca_alta AS 'Fecha de alta',
d.nombre AS Departamento
FROM emp E
INNER JOIN dept D ON E.id_dept = D.id_dept
WHERE E.fehca_alta BETWEEN '2017-01-01' AND '2017-12-31'
GO

SELECT * FROM emp
GO

-- El procedimiento almacenado para la afirmacion 2 ya esta generada

-- Generamos consulta para la afirmacion 3

SELECT
AVG(E.edad) AS 'Promedio de edad',
D.nombre AS Departamento
FROM
emp E
INNER JOIN dept D ON D.id_dept = E.id_dept
GROUP BY D.nombre
ORDER BY Departamento
GO

-- Creamos el procedimieto almacenado para la afirmacion 3

CREATE PROCEDURE sp_promedio_edad_departamento
AS
BEGIN
	SELECT
	AVG(E.edad) AS 'Promedio de edad',
	D.nombre AS Departamento
	FROM
	emp E
	INNER JOIN dept D ON D.id_dept = E.id_dept
	GROUP BY D.nombre
	ORDER BY Departamento
END
GO

EXEC sp_promedio_edad_departamento
GO

-- Geenramos consulta para la afirmacion 4

SELECT nombre, apellido, oficio, salario
FROM
emp
WHERE id_emp = 1
GO

--Generamos la afrimacion 4

CREATE PROCEDURE sp_buscar_empleado
@id INT
AS
BEGIN
	IF EXISTS (SELECT * FROM emp WHERE id_emp = @id)
	BEGIN
		SELECT
		nombre + ' ' + apellido AS 'Nombres y apellido',
		oficio AS Oficio,
		salario AS Salario
		FROM emp WHERE id_emp = @id
	END
	ELSE
	BEGIN
		RAISERROR('Empleado no encontrado', 16, 1)
		WITH NOWAIT
	END
END
GO

EXEC sp_buscar_empleado 1
GO

-- Generamos la consulta para la afirmacion 5

UPDATE emp SET estado = 1
WHERE apellido = 'Hancco'
GO

-- Generamos la afirmacion 5

CREATE PROCEDURE sp_cambiar_estado_empleado
@apellido VARCHAR(64)
AS
BEGIN
	IF EXISTS (SELECT * FROM emp WHERE apellido = @apellido)
	BEGIN
		IF (SELECT estado FROM emp WHERE estado = 0) = 0
		BEGIN
			UPDATE emp SET estado = 1
			WHERE apellido = @apellido
		END
		ELSE
			
		BEGIN
			UPDATE emp SET estado = 0
			WHERE apellido = @apellido
		END
	END
	ELSE
	BEGIN
		RAISERROR('Empleado no encontrado', 16, 1)
		WITH NOWAIT
	END
END
GO

EXEC sp_cambiar_estado_empleado Hancco
GO

SELECT * FROM emp
GO

-- Generamos una consulta para ver los estados de los empleados

SELECT nombre Nombre, oficio, CASE estado
WHEN 1 THEN 'Activo'
WHEN 0 THEN 'De baja'
END Estado
FROM
emp
GO