CREATE DATABASE IF NOT EXISTS sistema_peliculas;
USE sistema_peliculas;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE peliculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    year YEAR NOT NULL
);

INSERT INTO usuarios (nombre, email) VALUES
('David', 'david@email.com'),
('Nuria', 'nuria@email.com'),
('Ceci', 'ceci@email.com');

INSERT INTO peliculas (titulo, year) VALUES
('Titanic', 1998),
('Gremlins', 1982),
('Rambo', 1985);


SELECT * FROM usuarios;
SELECT * FROM peliculas;

INSERT INTO peliculas (titulo, year) VALUES
('El silencio de los corderos', 2001),
('Naufrago', 2004);

INSERT INTO usuarios (nombre, email) VALUES
('Victor', 'victor@gmail.com'),
('Javi', 'javi@gmail.com'),
('Antonio', 'antoniogmail.com');

CREATE DATABASE IF NOT EXISTS productos_tecnologicos;
USE productos_tecnologicos;

CREATE TABLE apple (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dispositivo VARCHAR(100) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    costo FLOAT NOT NULL,
    año_compra YEAR
);

CREATE TABLE android (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    costo FLOAT NOT NULL, 
    año_compra YEAR NOT NULL,
);

ALTER TABLE apple
ADD COLUMN venta YEAR;

INSERT INTO apple (dispositivo, modelo, costo) VALUES
('Macbook', 'Pro', 2500),
('Macbook', 'Air', 1100),
('iPad', 'Air', 650),
('iPhone', '16 pro max', 1300),
('Watch', '10', 370);

INSERT INTO apple (dispositivo, modelo, costo, año_compra) VALUES
('iPhone', '18 pro Max', 1800, 2026);

INSERT INTO apple (dispositivo, modelo, costo, año_compra, venta) VALUES
('iPad', 'Pro', 1600, 2015, 2020);

INSERT INTO android (marca, modelo, costo, año_compra) VALUES
('Samsung', 'Fold', 2350, 2020),
('Oppo', '9', 800, 2022),
('Huawei', 'notebook', 950, 2021),
('Samsung', 'Galaxy 20', 1200, 2025);

SELECT * FROM apple;
SELECT * FROM android;
DROP TABLE apple;