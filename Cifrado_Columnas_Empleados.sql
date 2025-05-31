
-- Crear tabla cifrada
CREATE TABLE empleados_cifrados (
  emp_no INT PRIMARY KEY,
  first_name VARBINARY(255),
  last_name VARBINARY(255)
);

-- Clave de cifrado (modificable)
SET @key = 'claveSecreta123';

-- Insertar datos cifrados desde la tabla original
INSERT INTO empleados_cifrados (emp_no, first_name, last_name)
SELECT 
  emp_no, 
  AES_ENCRYPT(first_name, @key), 
  AES_ENCRYPT(last_name, @key)
FROM employees
LIMIT 10;

-- Consultar datos cifrados
SELECT * FROM empleados_cifrados;

-- Consultar datos descifrados
SELECT 
  emp_no,
  CONVERT(AES_DECRYPT(first_name, @key) USING utf8mb4) AS first_name,
  CONVERT(AES_DECRYPT(last_name, @key) USING utf8mb4) AS last_name
FROM empleados_cifrados;
