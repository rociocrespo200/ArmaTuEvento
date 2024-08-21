<?php

class CarritoModel {
    private $database;

    public function __construct($database) {
        $this->database = $database;
    }

    public function buscarServicio($id)
    { 
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

        return $servicio;
    }

    public function buscarSalon($id)
    { 

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

        return $salon;
    }

    public function buscar($tabla, $comparacion)
    { 
        return  $this->database->query("SELECT * FROM $tabla WHERE $tabla.id = $comparacion");
    }


    private function obtenerImagenes($servicioOSalon, $id)
    {
        $result = $this->database->query("SELECT * FROM Imagen WHERE Imagen.$servicioOSalon = $id");

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



}