CREATE DATABASE IF NOT EXISTS armatuevento;
USE armatuevento;

CREATE TABLE IF NOT EXISTS Provincia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    provincia VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS TipoDeServicio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(255),
    icono VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Region (
    id INT AUTO_INCREMENT PRIMARY KEY,
    localidad VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Capacidad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rango VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Plan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    precio INT,
    beneficios VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Proveedor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    apellido VARCHAR(255),
    empresa VARCHAR(255),
    email VARCHAR(255),
    telefono VARCHAR(20),
    region_id INT,
    provincia_id INT,
    plan_id INT,
    FOREIGN KEY (plan_id) REFERENCES Plan(id),
    FOREIGN KEY (region_id) REFERENCES Region(id),
	FOREIGN KEY (provincia_id) REFERENCES Provincia(id)
);

CREATE TABLE IF NOT EXISTS Imagenes (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255));

CREATE TABLE IF NOT EXISTS Servicio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT,
	tipoDeServicio_id INT,
    imagenes_id INT,
    proveedor_id INT,
	FOREIGN KEY (imagenes_id) REFERENCES Imagenes(id),
    FOREIGN KEY (proveedor_id) REFERENCES Proveedor(id),
    FOREIGN KEY (tipoDeServicio_id) REFERENCES TipoDeServicio(id)
    );


CREATE TABLE IF NOT EXISTS ServicioCapacidad (
    servicio_id INT,
    capacidad_id INT,
    PRIMARY KEY (servicio_id, capacidad_id),
    FOREIGN KEY (servicio_id) REFERENCES Servicio(id),
    FOREIGN KEY (capacidad_id) REFERENCES Capacidad(id)
);

INSERT INTO Provincia (provincia) VALUES ('Buenos Aires');
INSERT INTO Provincia (provincia) VALUES ('Catamarca');
INSERT INTO Provincia (provincia) VALUES ('Chaco');
INSERT INTO Provincia (provincia) VALUES ('Chubut');
INSERT INTO Provincia (provincia) VALUES ('Córdoba');
INSERT INTO Provincia (provincia) VALUES ('Corrientes');
INSERT INTO Provincia (provincia) VALUES ('Entre Ríos');
INSERT INTO Provincia (provincia) VALUES ('Formosa');
INSERT INTO Provincia (provincia) VALUES ('Jujuy');
INSERT INTO Provincia (provincia) VALUES ('La Pampa');
INSERT INTO Provincia (provincia) VALUES ('La Rioja');
INSERT INTO Provincia (provincia) VALUES ('Mendoza');
INSERT INTO Provincia (provincia) VALUES ('Misiones');
INSERT INTO Provincia (provincia) VALUES ('Neuquén');
INSERT INTO Provincia (provincia) VALUES ('Río Negro');
INSERT INTO Provincia (provincia) VALUES ('Salta');
INSERT INTO Provincia (provincia) VALUES ('San Juan');
INSERT INTO Provincia (provincia) VALUES ('San Luis');
INSERT INTO Provincia (provincia) VALUES ('Santa Cruz');
INSERT INTO Provincia (provincia) VALUES ('Santa Fe');
INSERT INTO Provincia (provincia) VALUES ('Santiago del Estero');
INSERT INTO Provincia (provincia) VALUES ('Tierra del Fuego');
INSERT INTO Provincia (provincia) VALUES ('Tucumán');

INSERT INTO Region (localidad) VALUES ('Zona Oeste'); 
INSERT INTO Region (localidad) VALUES ('Zona Norte'); 
INSERT INTO Region (localidad) VALUES ('Zona Sur'); 
INSERT INTO Region (localidad) VALUES ('Capital Federal'); 
INSERT INTO Region (localidad) VALUES ('Gran Buenos Aires'); 

INSERT INTO Capacidad (rango) VALUES ('0');
INSERT INTO Capacidad (rango) VALUES ('0-50 personas');
INSERT INTO Capacidad (rango) VALUES ('50-100 personas');
INSERT INTO Capacidad (rango) VALUES ('100-150 personas');
INSERT INTO Capacidad (rango) VALUES ('150-200 personas');
INSERT INTO Capacidad (rango) VALUES ('200-250 personas');
INSERT INTO Capacidad (rango) VALUES ('250-300 personas');
INSERT INTO Capacidad (rango) VALUES ('más de 300 personas');

INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Adicionales', 'icono_adicionales.png');
INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Barra de tragos', 'icono_barra.png');
INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Fotografía', 'icono_foto.png');
INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Salón', 'icono_salon.png');
INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Show', 'icono_show.png');
INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Sonido e iluminación', 'icono_sonidoilumi.png');
INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Maquillaje y peinado', 'icono_maquillaje.png');
INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Catering', 'icono_catering.png');
INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Ambientación', 'icono_ambientacion.png');
INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Organizador integral de eventos', 'icono_organizacion.png');
-- INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Distribuidoras de bebidas', 'icono_dj.png');
-- INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Disc Jokey', 'icono_dj.png');
-- INSERT INTO TipoDeServicio (tipo, icono) VALUES ('Decoración', 'icono_decoracion.png');

INSERT INTO Plan (nombre, precio, beneficios) VALUES ('Básico', 3000, 'Acceso a servicios básicos');
INSERT INTO Plan (nombre, precio, beneficios) VALUES ('Medium', 4500, 'Acceso a servicios intermedios');
INSERT INTO Plan (nombre, precio, beneficios) VALUES ('Pro', 6000, 'Acceso a todos los servicios');



