<?php

class ServiceModel
{

    private $database;

    public function __construct($database) {
        $this->database = $database;
    }

    public function traerServicios($filtro){ //agregado

        if($filtro == null) $serviciosTemp =  $this->database->query("SELECT * FROM `servicio`");
        else $serviciosTemp =  $this->database->query("SELECT * FROM servicio s WHERE id_tipo = $filtro" );



        $servicios = array();
        foreach ($serviciosTemp as $s) {



            
            $servicio = [
                'id' => $s['id'],
                'titulo' => $s['titulo'],
                'descripcion' => $s['descripcion'],
                'tipoDeServicio' => $this->buscar("tipodeservicio", $s['id_tipo'])[0],
                'localidad' => $this->buscar("proveedor", $s['id_localidad'])[0],
                'proveedor' => $this->buscar("proveedor", $s['id_proveedor'])[0],
                'imagenes' =>  $this->obtenerImagenes($s['id']),
            ];

            $servicio['portada'] = $servicio['imagenes'][0];

            $servicios[] = $servicio;
        }

        //print_r($servicios);
        return $servicios;

    }

    public function buscar($tabla, $comparacion)
    { //agregado
        return  $this->database->query("SELECT * FROM $tabla WHERE $tabla.id = $comparacion");
    }

    // Nueva función para obtener imágenes con validación de imagen predeterminada
    private function obtenerImagenes($idServicio) {
        $result = $this->database->query("SELECT * FROM Imagen WHERE Imagen.id_servicio = $idServicio");


        // Si no se encontraron imágenes, obtener la imagen predeterminada
        if (empty($result)) {
            $result = $this->database->query("SELECT * FROM Imagen WHERE Imagen.id = 1");
;
        }

        return $result;
    }

    public function traerSalones($filtro){ //agregado

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
                'imagenes' =>  $this->obtenerImagenes($s['id']),
            ];

            $salon['portada'] = $salon['imagenes'][0];

            $salones[] = $salon;
        }

        //print_r($salones);
        return $salones;

    }

    
    public function traerTipos(){ //agregado
        return $this->database->query("SELECT * FROM `TipoDeServicio`");

    }

}