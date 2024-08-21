<?php

class HomeController {
    private $render;
    private $model;

    public function __construct($render, $model) {
        $this->render = $render;
        $this->model = $model;
    }

    public function show() {
        $datos = [
            'tipos' => $this->model->traerTipos(),
            'provincias' => $this->model->traerProvincias(),
            //'servicios' => $this->model->traerServiciosRecomendados(),
            //'salones' => $this->model->traerSalonesRecomendados(),
        ];
        $this->render->printView('index', $datos);//crea una vista, con el constructor de esta clase, llamada home
    }


    public function mostrarCarrito() {
        $datos = [

        ];
        $this->render->printView('carrito');//crea una vista, con el constructor de esta clase, llamada home
    }

}