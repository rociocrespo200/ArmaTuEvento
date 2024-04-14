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
    imagen VARCHAR(255));

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

INSERT INTO Proveedor (nombre, apellido, empresa, email, telefono, region_id, provincia_id, plan_id) VALUES
('Juan', 'Martínez', 'Fotografía Martínez', 'juan.martinez@example.com', '123-456-7890', 1, 1, 1),
('María', 'González', 'Catering Gourmet', 'maria.gonzalez@example.com', '987-654-3210', 2, 2, 2),
('Pedro', 'López', 'Salones de Pedro', 'pedro.lopez@example.com', '456-789-0123', 3, 3, 3),
('Laura', 'Díaz', 'Decoraciones Laura', 'laura.diaz@example.com', '321-654-0987', 1, 2, 1),
('Carlos', 'Rodríguez', 'Sonido y Luces Carlos', 'carlos.rodriguez@example.com', '789-012-3456', 2, 3, 2);


INSERT INTO Imagenes (imagen) VALUES ("sinImagen.jpg");

INSERT INTO Servicio (titulo, tipoDeServicio_id, descripcion, imagenes_id, proveedor_id) VALUES
('Gran Salón Celestial', 4, 'Un majestuoso salón con techos altos y una decoración elegante. Perfecto para bodas y eventos formales.', 1, 1),
('Salón Dorado', 4, 'Un espacio encantador con una atmósfera cálida y acogedora. Ideal para celebraciones íntimas y reuniones familiares.', 1, 1),
('Salón de Cristal', 4, 'Un salón moderno con paredes de vidrio que ofrecen vistas panorámicas de la ciudad. Perfecto para eventos corporativos y lanzamientos de productos.', 1, 1),
('Salón de la Luna', 4, 'Un salón íntimo ubicado en el corazón del centro histórico. Su encanto rústico lo convierte en el escenario perfecto para bodas bohemias y fiestas temáticas.', 1, 1),
('Salón Esmeralda', 4, 'Un salón espacioso con un diseño contemporáneo y una iluminación espectacular. Ideal para fiestas de cumpleaños y eventos sociales.', 1, 1),
('Servicio de fotografía', 3, 'Capturamos los momentos más especiales de tu evento con profesionalismo y creatividad. Paquetes personalizados disponibles.', 1, 1),
('Catering gourmet', 8, 'Deliciosos platillos preparados por nuestros chefs expertos. Ofrecemos una amplia variedad de opciones para satisfacer todos los gustos.',1, 3),
('Alquiler de mobiliario', 9, 'Contamos con una amplia selección de mobiliario elegante y funcional para tu evento. Desde sillas y mesas hasta lounges y barras.', 1, 4),
('DJ y entretenimiento', 5, 'Haz que tu evento sea inolvidable con la mejor música y entretenimiento. Nuestros DJs profesionales mantendrán a tus invitados en movimiento toda la noche.', 1, 5),
('Decoración temática', 10, 'Transformamos cualquier espacio en el escenario perfecto para tu evento. Desde bodas elegantes hasta fiestas temáticas, creamos ambientes mágicos.', 1, 3),
('Servicio de transporte', 1, 'Nos encargamos de que tus invitados lleguen y regresen seguros a casa. Contamos con una flota de vehículos cómodos y conductores profesionales.', 1, 4),
('Planificación de eventos', 10, 'Deja que nuestro equipo de expertos se encargue de todos los detalles para que puedas disfrutar al máximo de tu evento. Desde la conceptualización hasta la ejecución.', 1, 3);

SELECT * FROM servicio s JOIN tipodeservicio t ON t.id = s.tipodeservicio_id  JOIN imagenes i ON t.id = s.imagenes_id WHERE t.tipo = "Adicionales"

