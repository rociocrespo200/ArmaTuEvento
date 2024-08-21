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
            'salones' => $_SESSION['carrito2'],
        ];

        // Recuperar la consulta de la sesión si existe
        if (isset($_SESSION['consulta'])) {
        $datos['consulta'] = $_SESSION['consulta'];
        // Limpiar los datos de la sesión después de usarlos
        unset($_SESSION['consulta']);
    }

        //print_r($datos['servicios']);
        $this->render->printView('carrito', $datos);//crea una vista, con el constructor de esta clase, llamada home
    }

    


    public function eliminarDelCarrito() {
        if (isset($_GET['id_servicio'])) { 
            $id = $_GET['id_servicio'];
    
            $carrito = $_SESSION['carrito'];
    

            for ($i = 0; $i < count($carrito); $i++) {
                if ($carrito[$i]['id'] == $id) {
                    unset($carrito[$i]);
                    // Opcional: Reindexa el array si es necesario
                    $_SESSION['carrito'] = array_values($carrito);
                    break; 
                }
            }

        }else{
            $id = $_GET['id_salon'];
    
            $carrito = $_SESSION['carrito2'];
    

            for ($i = 0; $i < count($carrito); $i++) {
                if ($carrito[$i]['id'] == $id) {
                    unset($carrito[$i]);
                    // Opcional: Reindexa el array si es necesario
                    $_SESSION['carrito2'] = array_values($carrito);
                    break; 
                }
            }

        }

        Redirect::to('/carrito/show');
    }
    
    public function enviarConsulta() {

        $servcios = $_SESSION['carrito'];
        $salones = $_SESSION['carrito2'];
        $consultasServicio = array();
        $consultasSalon = array();

        foreach ($servcios as $s) { 

            $cons = [
                'servicio' => $this->model-> buscarServicio($s['id']),
                'msj' =>  (!empty($_POST['msjServicio'. $s['id']])) ? $msj = $_POST['msjServicio'. $s['id']] : $msj = 'Hola me gustaria mas informacion de este servicio',
            ];
            $consultasServicio[] = $cons;
        }

        foreach ($salones as $s) { 
            $cons = [
                'salon' => $this->model-> buscarSalon($s['id']),
                'msj' =>  (!empty($_POST['msjSalon'. $s['id']])) ? $msj = $_POST['msjSalon'. $s['id']] : $msj = 'Hola me gustaria mas informacion de este salon',
            ];
            $consultasSalon[] = $cons;
        }

        $consulta = [
            'nombre' => $_POST['nombre'],
            'email' => $_POST['email'],
            'consultasServicio' => $consultasServicio,
            'consultasSalon' => $consultasSalon,
        ];
        $_SESSION['consulta'] = $consulta;

        //print_r($consulta);
        Redirect::to('/carrito/show');
    }
}