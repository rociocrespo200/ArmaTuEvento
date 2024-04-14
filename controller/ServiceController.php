<?php

class ServiceController
{

    private $render;
    private $model;

    public function __construct($render, $model) {
        $this->render = $render;
        $this->model = $model;
    }

    public function show() {

        $filtro = isset($_GET['filtro']) ? $_GET['filtro'] : null;

        $datos = [
            'servicios' => $this->model->traerServicios($filtro)
        ];

//        print_r($datos['servicios']);
        $this->render->printView('servicios', $datos);//crea una vista, con el constructor de esta clase, llamada home
    }

}