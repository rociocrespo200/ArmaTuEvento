<?php

class CarritoController {
    private $render;
    private $model;

    public function __construct($render, $model) {
        $this->render = $render;
        $this->model = $model;
    }

    public function show() {
        $datos = [
            'servicios' => $_SESSION['carrito'],
        ];

        //print_r($datos['servicios']);
        $this->render->printView('carrito', $datos);//crea una vista, con el constructor de esta clase, llamada home
    }

    


    public function eliminarDelCarrito() {
        if (isset($_GET['id'])) { 
            $id = $_GET['id'];
    
            $carrito = $_SESSION['carrito'];
    

            for ($i = 0; $i < count($carrito); $i++) {
                if ($carrito[$i]['id'] == $id) {
                    unset($carrito[$i]);
                    // Opcional: Reindexa el array si es necesario
                    $_SESSION['carrito'] = array_values($carrito);
                    break; 
                }
            }
    
            Redirect::to('/carrito/show');
        }
    }
    
}