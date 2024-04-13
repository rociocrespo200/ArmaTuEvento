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
        $datos = [

        ];
        $this->render->printView('servicios');//crea una vista, con el constructor de esta clase, llamada home
    }

}