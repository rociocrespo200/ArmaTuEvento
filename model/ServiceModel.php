<?php

class ServiceModel
{

    private $database;

    public function __construct($database) {
        $this->database = $database;
    }

    public function traerServicios($filtro){ //agregado

        if($filtro == null) $serviciosTemp =  $this->database->query("SELECT * FROM `servicio`");
        else $serviciosTemp =  $this->database->query("SELECT * FROM servicio s WHERE tipoDeServicio_id = $filtro" );



        $servicios = array();
        foreach ($serviciosTemp as $s) {
            $servicio = [
                'id' => $s['id'],
                'titulo' => $s['titulo'],
                'descripcion' => $s['descripcion'],
                'tipoDeServicio' => $this->buscar("tipodeservicio", $s['tipoDeServicio_id'])[0],
                'imagen' => $this->buscar("imagenes", $s['imagenes_id'])[0],
                'proveedor' => $this->buscar("proveedor", $s['proveedor_id'])[0],
            ];

            $servicios[] = $servicio;
        }

        //print_r($servicios);
        return $servicios;

    }

    public function buscar($tabla, $comparacion)
    { //agregado
        return  $this->database->query("SELECT * FROM $tabla WHERE $tabla.id = $comparacion");
    }
}