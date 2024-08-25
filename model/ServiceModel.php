<?php

class ServiceModel
{

    private $database;

    public function __construct($database)
    {
        $this->database = $database;
    }

    public function traerServicios($filtro)
    { //agregado

        if ($filtro == null) $serviciosTemp =  $this->database->query("SELECT * FROM `servicio`");
        else $serviciosTemp =  $this->database->query("SELECT * FROM servicio s WHERE id_tipo = $filtro");



        $servicios = array();
        foreach ($serviciosTemp as $s) {

            $servicio = [
                'id' => $s['id'],
                'titulo' => $s['titulo'],
                'descripcion' => $s['descripcion'],
                'tipoDeServicio' => $this->buscar("tipodeservicio", $s['id_tipo'])[0],
                'localidad' => $this->buscar("localidad", $s['id_localidad'])[0],
                'proveedor' => $this->buscar("proveedor", $s['id_proveedor'])[0],
                'imagenes' =>  $this->obtenerImagenes("id_servicio", $s['id']),
            ];

            $servicios[] = $servicio;
        }

        //print_r($servicios);
        return $servicios;
    }

    public function buscar($tabla, $comparacion)
    { //agregado
        if( is_array($comparacion)){
            if(empty($comparacion)) return [];

            $ids = implode(', ', $comparacion);
            return $this->database->query("SELECT * FROM $tabla WHERE $tabla.id IN ($ids)");
        }
        return  $this->database->query("SELECT * FROM $tabla WHERE $tabla.id = $comparacion");
    }

    // Nueva función para obtener imágenes con validación de imagen predeterminada
    private function obtenerImagenes($servicioOSalon, $id)
    {
        $result = $this->database->query("SELECT * FROM Imagen WHERE Imagen.$servicioOSalon = $id");


        // Si no se encontraron imágenes, obtener la imagen predeterminada
        if (empty($result)) {
            $result = $this->database->query("SELECT * FROM Imagen WHERE Imagen.id = 1");;
        }

        $portada = null;
        $otrasImagenes = array();

        for ($i = 0; $i < count($result); $i++) {
            $s = $result[$i];

            if ($s['es_portada'] == 1) {
                $portada = $s;
            } else {
                $otrasImagenes[] = $s;
            }
        }

        $result = [
            'portada' => $portada,
            'imagenes' => $otrasImagenes,
        ];

        return $result;
    }

    public function traerSalones($filtro)
    { //agregado

        $salonesTemp =  $this->database->query("SELECT * FROM `Salon`");

        $salones = array();
        foreach ($salonesTemp as $s) {




            $salon = [
                'id' => $s['id'],
                'titulo' => $s['titulo'],
                'descripcion' => $s['descripcion'],
                'direccion' => $s['calle'],
                'capacidad' => $this->buscar("capacidad", $s['id_capacidad'])[0],
                'localidad' => $this->buscar("localidad", $s['id_localidad'])[0],
                'proveedor' => $this->buscar("proveedor", $s['id_proveedor'])[0],
                'imagenes' =>  $this->obtenerImagenes("id_salon", $s['id']),
            ];


            $salones[] = $salon;
        }

        //print_r($salones);
        return $salones;
    }


    public function traerTipos()
    { //agregado
        return $this->database->query("SELECT * FROM `TipoDeServicio`");
    }


    public function buscarServicio($id)
    { //agregado

        $s =  $this->database->query("SELECT * FROM servicio s WHERE id = $id")[0];


        $servicio = [
            'id' => $s['id'],
            'titulo' => $s['titulo'],
            'descripcion' => $s['descripcion'],
            'tipoDeServicio' => $this->buscar("tipodeservicio", $s['id_tipo'])[0],
            'localidad' => $this->buscar("localidad", $s['id_localidad'])[0],
            'proveedor' => $this->buscar("proveedor", $s['id_proveedor'])[0],
            'imagenes' =>  $this->obtenerImagenes("id_servicio", $s['id']),
        ];




        //print_r($servicios);
        return $servicio;
    }

    public function buscarSalon($id)
    { //agregado

        $s =  $this->database->query("SELECT * FROM salon s WHERE id = $id")[0];


        $salon = [
            'id' => $s['id'],
            'titulo' => $s['titulo'],
            'descripcion' => $s['descripcion'],
            'direccion' => $s['calle'],
            'capacidad' => $this->buscar("capacidad", $s['id_capacidad'])[0],
            'localidad' => $this->buscar("localidad", $s['id_localidad'])[0],
            'proveedor' => $this->buscar("proveedor", $s['id_proveedor'])[0],
            'imagenes' =>  $this->obtenerImagenes("id_salon", $s['id']),
        ];




        //print_r($salon);
        return $salon;
    }

    public function obtenerServiciosFiltrados() {

        $tipos =  $_SESSION['filtros']['tipos'];
        $provincias =  $_SESSION['filtros']['provincias'];
        $localidades =  $_SESSION['filtros']['localidades'];
        $busqueda =  $_SESSION['filtros']['busqueda'];
        $orden =  $_SESSION['filtros']['orden'];

        // Construir la consulta base
        $sql = "SELECT Servicio.* FROM Servicio";

        // Inicializa las uniones si se requieren más filtros
        $joins = "";

        // Filtros de tipo
        $conditions = []; // Array para almacenar las condiciones del WHERE

        if (!empty($tipos)) {
            $tiposPlaceholder = implode(',', array_map('intval', $tipos)); // Asegúrate de que los IDs sean enteros
            $conditions[] = "Servicio.id_tipo IN ($tiposPlaceholder)";
        }

        // Filtros de localidades
        if (!empty($localidades)) {
            $localidadesPlaceholder = implode(',', array_map('intval', $localidades)); // Asegúrate de que los IDs sean enteros
            $conditions[] = "Servicio.id_localidad IN ($localidadesPlaceholder)";
        }

        // Filtros por provincia
        if (!empty($provincias)) {
            $provinciasPlaceholder = implode(',', array_map('intval', $provincias)); // Asegúrate de que los IDs sean enteros
            $joins .= " INNER JOIN Proveedor ON Servicio.id_proveedor = Proveedor.id";
            $joins .= " INNER JOIN Localidad ON Servicio.id_localidad = Localidad.id";
            $joins .= " INNER JOIN Provincia ON Localidad.id_provincia = Provincia.id";
            $conditions[] = "Provincia.id IN ($provinciasPlaceholder)";
        }

        // Añadir las uniones a la consulta si es necesario
        $sql .= $joins;

        // Construir la cláusula WHERE si hay condiciones
        if (!empty($conditions)) {
            $sql .= " WHERE " . implode(' AND ', $conditions);
        }

        // Búsqueda
        if (!empty($busqueda)) {
            $busqueda = "%$busqueda%";
            $sql .= !empty($conditions) ? " AND" : " WHERE";
            $sql .= " Servicio.titulo LIKE '$busqueda' OR Servicio.descripcion LIKE '$busqueda'";
        }


        $result = $this->database->query($sql);

        $serviciosFiltrados = [];
        if ($result) {
            foreach ($result as $servicio) {
                $servicioDetallado = $this->buscarServicio($servicio['id']);
                $serviciosFiltrados[] = $servicioDetallado;
            }
        }

        return $serviciosFiltrados;
    }

    public function traerLocalidadesPorProvincia($provincias){              
        $provinciasPlaceholder = implode(',', array_map('intval', $provincias)); 
        $sql = "SELECT * FROM localidad WHERE 1 AND id_provincia IN ($provinciasPlaceholder)";
        print_r($sql);
        return  $sql;
    }

    public function traerProvincias(){ return  $this->database->query("SELECT * FROM provincia");
    }

    public function traerLocalidades(){ return  $this->database->query("SELECT * FROM localidad");
    }

}
