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


        if (isset($_GET['id'])) { //Si selecciono un servicio especifico me envia al detalle de ese servicio
            $datos = [
                $id = $_GET['id']
            ];
            $this->render->printView('servicioEsp', $datos);

        }else{ //sino me trae todos los servicios
            $filtro = isset($_GET['filtro']) ? $_GET['filtro'] : null;

            $datos = [
                'servicios' => $this->model->traerServicios($filtro),
                'hayTipos' => true,
                'tipos' =>  $this->model->traerTipos(),
            ];
    
           // print_r($datos['servicios']);
            $this->render->printView('servicios', $datos);//crea una vista, con el constructor de esta clase, llamada home
        }

    }

    

    public function traerSalones() {

        $filtro = isset($_GET['filtro']) ? $_GET['filtro'] : null;

        $datos = [
            'salones' => $this->model->traerSalones($filtro),
        ];
        //print_r($datos['salones']);
        $this->render->printView('servicios', $datos);
    }

}