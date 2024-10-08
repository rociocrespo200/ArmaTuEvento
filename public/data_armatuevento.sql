CREATE DATABASE IF NOT EXISTS armatuevento;
USE armatuevento;

CREATE TABLE IF NOT EXISTS TipoDeServicio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(255),
    icono VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Provincia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    provincia VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS Zona (
    id INT AUTO_INCREMENT PRIMARY KEY,
    zona VARCHAR(255),
    id_provincia INT,
    FOREIGN KEY (id_provincia) REFERENCES Provincia(id)
);
CREATE TABLE IF NOT EXISTS Localidad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    localidad VARCHAR(255),
	id_provincia INT,
    id_zona INT,
    FOREIGN KEY (id_provincia) REFERENCES Provincia(id),
    FOREIGN KEY (id_zona) REFERENCES Zona(id)
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
    id_localidad INT,
    id_plan INT,
    FOREIGN KEY (id_plan) REFERENCES Plan(id),
    FOREIGN KEY (id_localidad) REFERENCES Localidad(id)
);

CREATE TABLE IF NOT EXISTS Servicio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT,
	id_tipo INT,
    id_proveedor INT,
    id_localidad INT,
    FOREIGN KEY (id_localidad) REFERENCES Localidad(id),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id),
    FOREIGN KEY (id_tipo) REFERENCES TipoDeServicio(id)
    );

CREATE TABLE IF NOT EXISTS Capacidad (
	id INT AUTO_INCREMENT PRIMARY KEY,
    rango VARCHAR(255),
    capacidad_max INT,
	capacidad_min INT
);

CREATE TABLE IF NOT EXISTS Salon (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT,
    calle VARCHAR(255),
    id_capacidad INT,
    id_proveedor INT,
	id_localidad INT,
    FOREIGN KEY (id_localidad) REFERENCES Localidad(id),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id),
    FOREIGN KEY (id_capacidad) REFERENCES Capacidad(id)
);

CREATE TABLE IF NOT EXISTS Imagen (
	id INT AUTO_INCREMENT PRIMARY KEY,
    imagen VARCHAR(255),
	id_servicio INT,
    id_salon INT,
    es_portada bool,
	FOREIGN KEY (id_servicio) REFERENCES Servicio(id),
    FOREIGN KEY (id_salon) REFERENCES Salon(id));

CREATE TABLE IF NOT EXISTS Caracteristica (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
	descripcion VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Caracteristica_Servicio (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
	descripcion VARCHAR(100),
    id_servicio INT,
    id_Caracteristica INT,
    FOREIGN KEY (id_Caracteristica) REFERENCES Caracteristica(id),
    FOREIGN KEY (id_servicio) REFERENCES Servicio(id)
);

CREATE TABLE IF NOT EXISTS Caracteristica_Salon (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
	descripcion VARCHAR(100),
    id_salon INT,
    id_Caracteristica INT,
    FOREIGN KEY (id_Caracteristica) REFERENCES Caracteristica(id),
    FOREIGN KEY (id_salon) REFERENCES Salon(id)
);

CREATE TABLE IF NOT EXISTS Servicio_localidad (
       id INT AUTO_INCREMENT PRIMARY KEY,
        id_localidad INT,
        id_servicio INT,
        FOREIGN KEY (id_localidad) REFERENCES Localidad(id),
		FOREIGN KEY (id_servicio) REFERENCES Servicio(id)
);

INSERT INTO TipoDeServicio (tipo, icono) VALUES
    ('Adicionales', 'icono_adicionales.png'),
    ('Barra de tragos', 'icono_barra.png'),
    ('Fotografía', 'icono_foto.png'),
    ('Show', 'icono_show.png'),
    ('Sonido e iluminación', 'icono_sonidoilumi.png'),
    ('Maquillaje y peinado', 'icono_maquillaje.png'),
    ('Catering', 'icono_catering.png'),
    ('Ambientación', 'icono_ambientacion.png'),
    ('Organizador integral de eventos', 'icono_organizacion.png'),
    ('Distribuidoras de bebidas', 'icono_bebidas.png'),
    ('Disc Jokey', 'icono_dj.png'),
    ('Decoración', 'icono_decoracion.png');

INSERT INTO Plan (nombre, precio, beneficios) VALUES
    ('Básico', 3000, 'Acceso a servicios básicos'),
    ('Medium', 4500, 'Acceso a servicios intermedios'),
    ('Pro', 6000, 'Acceso a todos los servicios');

INSERT INTO Capacidad (rango, capacidad_min, capacidad_max) VALUES 
			('0 - 50', 0, 50),
			('50 - 100', 50, 100),
			('100 - 150', 100, 150),
			('150 - 200', 150, 200),
			('200 - 250', 200, 250),
			('250 - 300', 250, 300),
            ('300 - 500', 300, 500);


INSERT INTO Provincia (provincia) VALUES
    ('Buenos Aires'),
    ('Catamarca'),
    ('Chaco'),
    ('Chubut'),
    ('Córdoba'),
    ('Corrientes'),
    ('Entre Ríos'),
    ('Formosa'),
    ('Jujuy'),
    ('La Pampa'),
    ('La Rioja'),
    ('Mendoza'),
    ('Misiones'),
    ('Neuquén'),
    ('Río Negro'),
    ('Salta'),
    ('San Juan'),
    ('San Luis'),
    ('Santa Cruz'),
    ('Santa Fe'),
    ('Santiago del Estero'),
    ('Tierra del Fuego'),
    ('Tucumán');

INSERT INTO Zona (zona, id_provincia) VALUES
    ('Zona Norte', 1),
    ('Zona Sur', 1),
    ('Zona Oeste', 1),
    ('Gran Buenos Aires', 1),
    ('Ciudad Autónoma de Buenos Aires', 1),
        -- Catamarca
    ('Capital', 2),
    ('Andalgalá', 2),
    ('Belén', 2),
    ('Pomán', 2),
    
    -- Chaco
    ('Gran Resistencia', 3),
    ('Noreste', 3),
    ('Suroeste', 3),
    
    -- Chubut
    ('Sierra', 4),
    ('Costa', 4),
    ('Valle', 4),
	
    -- Cordoba
    ('Capital', 5),
    ('Centro', 5),
    ('Sierras', 5),
    ('Pampas', 5),
    ('Norte', 5),
    ('Sudeste', 5),
    
    -- Corrientes
    ('Capital', 6),
    ('Interior', 6),
    
    -- Entre Ríos
    ('Capital', 7),
    ('Centro', 7),
    ('Norte', 7),
    ('Sur', 7),
    
    -- Formosa
    ('Capital', 8),
    ('Norte', 8),
    ('Centro', 8),
    ('Sur', 8),
    
    -- Jujuy
    ('Capital', 9),
    ('Quebrada', 9),
    ('Valles', 9),
    ('Puna', 9),
    
    -- La Pampa
    ('Capital', 10),
    ('Centro', 10),
    ('Norte', 10),
    ('Sur', 10),
    
    -- La Rioja
    ('Capital', 11),
    ('Centro', 11),
    ('Norte', 11),
    ('Sur', 11),
    
    -- Mendoza
    ('Capital', 12),
    ('Valle de Uco', 12),
    ('Este', 12),
    ('Noroeste', 12),
    
    -- Misiones
    ('Capital', 13),
    ('Norte', 13),
    ('Centro', 13),
    ('Sur', 13),
    
    -- Neuquén
    ('Capital', 14),
    ('Zona Norte', 14),
    ('Zona Centro', 14),
    ('Zona Sur', 14),
    
    -- Río Negro
    ('Capital', 15),
    ('Noroeste', 15),
    ('Suroeste', 15),
    ('Valle Inferior', 15),
    
    -- Salta
    ('Capital', 16),
    ('Valles', 16),
    ('Puna', 16),
    ('Chicoana', 16),
    
    -- San Juan
    ('Capital', 17),
    ('Norte', 17),
    ('Sur', 17),
    ('Este', 17),
    
    -- San Luis
    ('Capital', 18),
    ('Centro', 18),
    ('Noroeste', 18),
    ('Sudeste', 18),
    
    -- Santa Cruz
    ('Capital', 19),
    ('Centro', 19),
    ('Norte', 19),
    ('Sur', 19),
    
    -- Santa Fe
    ('Capital', 20),
    ('Norte', 20),
    ('Centro', 20),
    ('Sur', 20),
    
    -- Santiago del Estero
    ('Capital', 21),
    ('Norte', 21),
    ('Centro', 21),
    ('Sur', 21),
    
    -- Tierra del Fuego
    ('Capital', 22),
    ('Norte', 22),
    ('Sur', 22),
    
    -- Tucumán
    ('Capital', 23),
    ('Valle de Tafí', 23),
    ('Tafí del Valle', 23),
    ('Noroeste', 23);

INSERT INTO Localidad (localidad, id_provincia, id_zona) VALUES
    -- Buenos Aires
    -- Zona Norte
    ('Tigre', 1, 1),
    ('San Isidro', 1, 1),
    ('Vicente López', 1, 1),
    ('San Fernando', 1, 1),
    ('San Martín', 1, 1),
    ('Olivos', 1, 1),
    ('Martínez', 1, 1),
    ('Boulogne', 1, 1),
    ('Pilar', 1, 1),
    ('Escobar', 1, 1),
    ('Malvinas Argentinas', 1, 1),
    ('José C. Paz', 1, 1),
    ('San Miguel', 1, 1),
    ('Hurlingham', 1, 1),

    -- Zona Sur
    ('Quilmes', 1, 2),
    ('Avellaneda', 1, 2),
    ('Lanús', 1, 2),
    ('Berazategui', 1, 2),
    ('Lomas de Zamora', 1, 2),
    ('Almirante Brown', 1, 2),
    ('Florencio Varela', 1, 2),
    ('Esteban Echeverría', 1, 2),
    ('Ezeiza', 1, 2),
    ('Presidente Perón', 1, 2),

    -- Zona Oeste
    ('Morón', 1, 3),
    ('Merlo', 1, 3),
    ('Moreno', 1, 3),
    ('La Matanza', 1, 3),
    ('Ituzaingó', 1, 3),
    ('General Rodríguez', 1, 3),
    ('Tres de Febrero', 1, 3),
    ('San Justo', 1, 3),
    ('Castelar', 1, 3),
    ('Haedo', 1, 3),

    -- Gran Buenos Aires (GBA)
    ('Vicente López', 1, 4),
    ('Berisso', 1, 4),
    ('Ensenada', 1, 4),
    ('La Plata', 1, 4),
    ('Pilar', 1, 4),
    ('Zárate', 1, 4),
    ('Campana', 1, 4),
    ('General Pacheco', 1, 4),
    ('Tigre', 1, 4),
    ('Villa Ballester', 1, 4),

    -- Ciudad Autónoma de Buenos Aires (CABA)
    ('Palermo', 1, 5),
    ('Recoleta', 1, 5),
    ('Belgrano', 1, 5),
    ('Caballito', 1, 5),
    ('Almagro', 1, 5),
    ('Villa Urquiza', 1, 5),
    ('Balvanera', 1, 5),
    ('Flores', 1, 5),
    ('Villa Crespo', 1, 5),
    ('Retiro', 1, 5),

    -- Córdoba
    -- Capital
    ('Córdoba', 5, 6),
    ('Villa Allende', 5, 6),
    ('Río Cuarto', 5, 6),
    ('Córdoba Capital', 5, 6),

    -- Centro
    ('San Francisco', 5, 7),
    ('Morteros', 5, 7),
    ('Bell Ville', 5, 7),

    -- Sierras
    ('Villa Carlos Paz', 5, 8),
    ('La Falda', 5, 8),
    ('Capilla del Monte', 5, 8),

    -- Pampas
    ('Laboulaye', 5, 9),
    ('Río Segundo', 5, 9),
    ('Villa María', 5, 9),

    -- Norte
    ('San Francisco', 5, 10),
    ('Cruz del Eje', 5, 10),

    -- Sudeste
    ('Alta Gracia', 5, 11),
    ('Santa Rosa de Calamuchita', 5, 11),

    -- Catamarca
    ('San Fernando del Valle de Catamarca', 2, 12),
    ('Andalgalá', 2, 13),
    ('Belén', 2, 14),
    ('Pomán', 2, 15),

    -- Chaco
    ('Resistencia', 3, 16),
    ('Barranqueras', 3, 16),
    ('Fontana', 3, 16),
    ('Villa Ángela', 3, 17),
    ('Charata', 3, 17),
    ('San Bernardo', 3, 18),

    -- Chubut
    ('Rawson', 4, 19),
    ('Trelew', 4, 19),
    ('Comodoro Rivadavia', 4, 20),
    ('Puerto Madryn', 4, 20),
    ('Esquel', 4, 21),

    -- Corrientes
    ('Corrientes', 6, 22),
    ('Goya', 6, 23),
    ('Paso de los Libres', 6, 23),
    ('Mercedes', 6, 23),

    -- Entre Ríos
    ('Paraná', 7, 24),
    ('Gualeguaychú', 7, 25),
    ('Concordia', 7, 25),
    ('Villaguay', 7, 26),

    -- Formosa
    ('Formosa', 8, 27),
    ('Pirané', 8, 28),
    ('Clorinda', 8, 28),
    ('El Colorado', 8, 29),

    -- Jujuy
    ('San Salvador de Jujuy', 9, 30),
    ('Purmamarca', 9, 31),
    ('Tilcara', 9, 31),
    ('Humahuaca', 9, 32),

    -- La Pampa
    ('Santa Rosa', 10, 33),
    ('General Pico', 10, 34),
    ('General Acha', 10, 35),
    ('Macachín', 10, 36),

    -- La Rioja
    ('La Rioja', 11, 37),
    ('Chilecito', 11, 38),
    ('Famatina', 11, 39),
    ('Villa Unión', 11, 40),

    -- Mendoza
    ('Mendoza', 12, 41),
    ('San Rafael', 12, 42),
    ('Tunuyán', 12, 42),
    ('San Martín', 12, 43),

    -- Misiones
    ('Posadas', 13, 44),
    ('Oberá', 13, 45),
    ('Eldorado', 13, 45),
    ('San Vicente', 13, 46),

    -- Neuquén
    ('Neuquén', 14, 47),
    ('San Martín de los Andes', 14, 48),
    ('Villa La Angostura', 14, 48),
    ('Zapala', 14, 49),

    -- Río Negro
    ('Viedma', 15, 50),
    ('San Carlos de Bariloche', 15, 51),
    ('Cipolletti', 15, 52),
    ('General Roca', 15, 53),

    -- Salta
    ('Salta', 16, 54),
    ('San Lorenzo', 16, 55),
    ('Cachi', 16, 56),
    ('San Carlos', 16, 56),

    -- San Juan
    ('San Juan', 17, 57),
    ('Rivadavia', 17, 58),
    ('Chimbas', 17, 58),
    ('Albardón', 17, 59),

    -- San Luis
    ('San Luis', 18, 60),
    ('Villa Mercedes', 18, 61),
    ('La Punta', 18, 61),
    ('Merlo', 18, 62),

    -- Santa Cruz
    ('Río Gallegos', 19, 63),
    ('El Calafate', 19, 64),
    ('Caleta Olivia', 19, 64),
    ('Puerto Deseado', 19, 65),

    -- Santa Fe
    ('Santa Fe', 20, 66),
    ('Rosario', 20, 67),
    ('Rafaela', 20, 68),
    ('Venado Tuerto', 20, 69),

    -- Santiago del Estero
    ('Santiago del Estero', 21, 70),
    ('Termas de Río Hondo', 21, 71),
    ('La Banda', 21, 71),
    ('Añatuya', 21, 72),

    -- Tierra del Fuego
    ('Ushuaia', 22, 73),
    ('Río Grande', 22, 74),
    ('Tolhuin', 22, 75),

    -- Tucumán
    ('San Miguel de Tucumán', 23, 76),
    ('Tafí del Valle', 23, 77),
    ('Valle de Tafí', 23, 77),
    ('Concepción', 23, 78);

INSERT INTO Proveedor (nombre, apellido, empresa, email, telefono, id_localidad) VALUES
    ('Juan', 'Pérez', 'Eventos Juan', 'juan.perez@eventosjuan.com', '123456789', 1),
    ('Ana', 'Gómez', 'Gómez Celebraciones', 'ana.gomez@gomezcelebraciones.com', '987654321', 2),
    ('Carlos', 'Rodríguez', 'Fiestas Rodriguez', 'carlos.rodriguez@fiestasrodriguez.com', '456789123', 3),
    ('Lucía', 'Martínez', 'Martínez Eventos', 'lucia.martinez@martinezeventos.com', '789123456', 4),
    ('María', 'López', 'Eventos López', 'maria.lopez@eventoslopez.com', '321654987', 5);

INSERT INTO Servicio (titulo, descripcion, id_tipo, id_proveedor, id_localidad) VALUES
    ('Servicio de Adicionales Premium', 
     'Nuestro servicio de adicionales premium está diseñado para mejorar cualquier evento con detalles de lujo que impresionarán a tus invitados. Ofrecemos una amplia gama de opciones que incluyen servicios de bienvenida, recuerdos personalizados, y mucho más. Todo esto es proporcionado por profesionales experimentados que se aseguran de que cada elemento de tu evento se destaque y deje una impresión duradera.', 
     1, 1, 1),

    ('Barra de Tragos Exclusiva', 
     'La barra de tragos exclusiva ofrece una experiencia de coctelería de alto nivel, perfecta para eventos especiales. Nuestros bartenders profesionales preparan cócteles clásicos y modernos utilizando solo los mejores ingredientes. Este servicio incluye opciones personalizadas para adaptarse a tus preferencias y tema del evento, asegurando que tus invitados disfruten de una experiencia única e inolvidable.', 
     2, 2, 2),

    ('Fotografía Artística para Eventos', 
     'Capturamos los momentos más importantes de tu evento con nuestro servicio de fotografía artística. Nuestros fotógrafos expertos utilizan técnicas innovadoras para crear imágenes que cuentan la historia de tu celebración. Ofrecemos paquetes personalizados que incluyen sesiones previas al evento, cobertura completa del día del evento, y opciones de edición y entrega en formatos digitales y físicos.', 
     3, 3, 3),

    ('Show de Entretenimiento en Vivo', 
     'Nuestro show de entretenimiento en vivo ofrece actuaciones espectaculares para hacer de tu evento una experiencia memorable. Desde músicos y bailarines hasta actores y comediantes, ofrecemos una variedad de opciones que se pueden personalizar para adaptarse a cualquier tipo de evento y audiencia. Nuestros artistas están comprometidos a proporcionar un espectáculo de alta calidad que deleitará a todos los asistentes.', 
     4, 1, 4),

    ('Sonido e Iluminación de Vanguardia', 
     'El servicio de sonido e iluminación de vanguardia proporciona una atmósfera única para tu evento. Utilizamos tecnología de última generación para garantizar un sonido claro y envolvente, así como efectos de iluminación espectaculares que transformarán cualquier espacio. Nuestro equipo profesional se encarga de todos los detalles técnicos, asegurando que el evento se desarrolle sin problemas y sea visualmente impresionante.', 
     5, 2, 1),

    ('Maquillaje y Peinado Profesional', 
     'Ofrecemos servicios de maquillaje y peinado profesional para asegurarnos de que los clientes luzcan increíbles en su evento especial. Nuestros estilistas están altamente capacitados y utilizan productos de alta calidad para crear looks personalizados que realzan la belleza natural de cada persona. Este servicio es perfecto para bodas, eventos corporativos y cualquier ocasión donde desees lucir lo mejor posible.', 
     6, 3, 2),

    ('Catering Gourmet Personalizado', 
     'Nuestro servicio de catering gourmet ofrece menús personalizados diseñados por chefs expertos para satisfacer todos los gustos y necesidades dietéticas. Utilizamos ingredientes frescos y de alta calidad para crear platos deliciosos que harán las delicias de tus invitados. El servicio de catering incluye opciones para banquetes formales, buffets casuales, y estaciones de comida interactivas, asegurando que cada evento sea único.', 
     7, 1, 3),

    ('Ambientación Temática Innovadora', 
     'El servicio de ambientación temática transforma cualquier espacio en un entorno mágico que refleja el tema de tu evento. Desde decoraciones impresionantes hasta arreglos florales y mobiliario, ofrecemos soluciones completas que se adaptan a tus necesidades y presupuesto. Nuestro equipo de diseñadores trabaja contigo para crear una experiencia visualmente impactante que dejará a tus invitados maravillados.', 
     8, 2, 4),

    ('Organización Integral de Eventos', 
     'Nuestra organización integral de eventos se encarga de todos los aspectos de la planificación y ejecución de tu evento, asegurando que cada detalle sea perfecto. Ofrecemos servicios de gestión de logística, coordinación de proveedores, y supervisión en el lugar para garantizar que el evento se desarrolle sin problemas. Nuestro equipo de profesionales está comprometido a hacer que cada evento sea único y exitoso.', 
     9, 3, 1),

    ('Distribuidoras de Bebidas Selectas', 
     'Ofrecemos un servicio de distribución de bebidas selectas, proporcionando una amplia variedad de opciones de alta calidad para eventos de cualquier tamaño. Desde vinos y licores premium hasta cervezas artesanales y refrescos, nuestros expertos te ayudarán a seleccionar las mejores opciones para tus necesidades. Este servicio incluye entrega y logística, asegurando que tus bebidas lleguen a tiempo y en perfectas condiciones.', 
     10, 1, 2),

    ('Disc Jokey Profesional', 
     'Nuestro disc jockey profesional proporciona una experiencia musical excepcional para cualquier evento. Con un extenso catálogo de música y la habilidad de leer al público, nuestro DJ asegurará que todos los invitados se diviertan y disfruten de la pista de baile. Ofrecemos servicios personalizados para adaptarse a tus preferencias y tema del evento, creando una atmósfera electrizante que todos recordarán.', 
     11, 2, 3),

    ('Decoración Creativa para Eventos', 
     'La decoración creativa para eventos transforma cualquier espacio en un lugar hermoso y acogedor. Nuestro equipo de decoradores trabaja contigo para desarrollar un concepto que refleje tu visión y tema. Desde centros de mesa y telones de fondo hasta iluminación ambiental y arreglos florales, ofrecemos soluciones integrales que harán que tu evento sea inolvidable. Utilizamos materiales de alta calidad y técnicas innovadoras para garantizar resultados impresionantes.', 
     12, 3, 4);

INSERT INTO Salon (titulo, descripcion, calle, id_capacidad, id_proveedor, id_localidad) VALUES
    ('Salón Intimo Elegancia', 
     'El Salón Intimo Elegancia es el lugar perfecto para eventos pequeños y exclusivos. Con una capacidad de hasta 50 personas, ofrece un ambiente acogedor y elegante ideal para reuniones privadas, celebraciones íntimas y cenas de gala. El diseño del salón combina elementos clásicos con toques modernos, creando una atmósfera única y sofisticada. El personal dedicado está siempre a disposición para garantizar que cada detalle de su evento se desarrolle sin contratiempos, desde el catering hasta la música.', 
     'Calle A, 123', 1, 1, 1),

    ('Salón Fiesta Familiar', 
     'Este salón es ideal para celebraciones familiares y eventos de tamaño mediano, con capacidad para hasta 100 personas. Diseñado pensando en la comodidad y el estilo, el Salón Fiesta Familiar ofrece un espacio versátil que puede adaptarse a cualquier tipo de evento, ya sea una boda, un cumpleaños o una fiesta de aniversario. El equipo de profesionales se asegurará de que su evento sea un éxito, ofreciendo servicios personalizados para satisfacer todas sus necesidades. La tecnología de vanguardia garantiza una experiencia inolvidable para sus invitados.', 
     'Calle B, 456', 2, 2, 2),

    ('Salón de Gala Magnífico', 
     'El Salón de Gala Magnífico ofrece una capacidad para hasta 150 personas, siendo perfecto para bodas elegantes y eventos corporativos. Este impresionante espacio combina un diseño moderno con detalles clásicos, creando una atmósfera lujosa y sofisticada. Equipado con la última tecnología en sonido e iluminación, el salón ofrece un entorno ideal para presentaciones y recepciones. El equipo de planificación de eventos está disponible para asistirle en cada paso del camino, asegurando que su evento se desarrolle a la perfección.', 
     'Calle C, 789', 3, 3, 3),

    ('Gran Salón de Celebraciones', 
     'Con una capacidad para hasta 200 personas, el Gran Salón de Celebraciones es el escenario perfecto para grandes eventos sociales y corporativos. Su diseño espacioso y versátil permite una fácil personalización para adaptarse a cualquier tema o estilo. Desde bodas extravagantes hasta conferencias profesionales, el salón está equipado para manejar todo tipo de eventos con elegancia y eficacia. El personal experimentado proporciona un servicio excepcional, asegurando que su evento sea memorable y sin complicaciones.', 
     'Avenida D, 1011', 4, 1, 4),

    ('Salón Majestuoso', 
     'El Salón Majestuoso, con capacidad para hasta 250 personas, ofrece un entorno impresionante para eventos importantes. Su diseño elegante y moderno, combinado con instalaciones de alta calidad, proporciona el espacio ideal para bodas, recepciones y eventos corporativos. El equipo de catering y planificación está comprometido a ofrecer un servicio excepcional, asegurando que su evento se desarrolle sin problemas. La tecnología de sonido e iluminación avanzada garantiza una experiencia espectacular para todos los asistentes.', 
     'Avenida E, 1213', 5, 2, 1),

    ('Salón Épico', 
     'El Salón Épico es perfecto para grandes eventos, con capacidad para hasta 300 personas. Este salón ofrece un espacio amplio y versátil que puede adaptarse a una variedad de eventos, desde bodas hasta convenciones. Con un equipo dedicado a la planificación de eventos, ofrecemos soluciones personalizadas para garantizar el éxito de su evento. La tecnología de punta en sonido e iluminación crea un ambiente impresionante, mientras que el personal atento asegura que cada detalle sea perfecto.', 
     'Boulevard F, 1415', 6, 3, 2),

    ('Salón Imperial', 
     'El Salón Imperial es ideal para eventos de gran envergadura, con capacidad para hasta 500 personas. Este magnífico espacio combina un diseño elegante con características modernas, proporcionando un entorno ideal para bodas, banquetes y eventos corporativos. Nuestro equipo de planificación de eventos está disponible para ayudarle en cada etapa del proceso, asegurando que su evento sea un éxito rotundo. La tecnología avanzada y el personal dedicado garantizan que cada detalle se maneje con precisión y estilo.', 
     'Boulevard G, 1617', 7, 1, 3);


INSERT INTO `armatuevento`.`imagen` (`id`, `imagen`, `es_portada`) VALUES ('1', 'sinImagen.jpg', '1');
INSERT INTO `armatuevento`.`imagen` (`id`, `imagen`, `id_servicio`, `es_portada`) VALUES ('2', 'bar1.png', '2', '1');
INSERT INTO `armatuevento`.`imagen` (`id`, `imagen`, `id_servicio`, `es_portada`) VALUES ('3', 'bar2.png', '2', '0');
