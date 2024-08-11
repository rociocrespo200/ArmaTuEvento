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


        if (isset($_GET['id_servicio'])) { //Si selecciono un servicio especifico me envia al detalle de ese servicio
            
            $id = $_GET['id_servicio'];

            $datos = [
                'servicio' =>  $this->model->buscarServicio($id)  
            ];
            
            //print_r($datos['servicio']);
            $this->render->printView('servicioEsp', $datos);

        }else if (isset($_GET['id_salon'])) { //Si selecciono un salon especifico me envia al detalle de ese salon
            
            $id = $_GET['id_salon'];

            $datos = [
                'servicio' =>  $this->model->buscarSalon($id)  
            ];
            
            //print_r($datos['servicio']);
            $this->render->printView('servicioEsp', $datos);

        }else{ //sino me trae todos los servicios
            $filtro = isset($_GET['filtro']) ? $_GET['filtro'] : null;

            $datos = [
                'servicios' => $this->model->traerServicios($filtro),
                'hayTipos' => true,
                'tipos' =>  $this->model->traerTipos(),
            ];
    
           // print_r($datos['servicios']);
            $this->render->printView('servicios', $datos);
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

    public function agregarAlCarrito() {

        if (isset($_GET['id'])) { //Si selecciono un servicio especifico me envia al detalle de ese servicio
            
            $id = $_GET['id'];
            $nuevoServicio = $this->model->buscarServicio($id);
            
        if (!isset($_SESSION['carrito'])) { // Inicializar el carrito si no existe
            $_SESSION['carrito'] = [];
        }

        
        $existe = false; // Verificar si el servicio ya está en el carrito
        foreach ($_SESSION['carrito'] as $servicio) {
            if ($servicio['id'] == $id) {
                $existe = true;
                break;
            }
        }

        // Si no existe, agregarlo al carrito
        if (!$existe) {
            $_SESSION['carrito'][] = $nuevoServicio;
        }
            
            
            Redirect::to('/service/show?id=' . $id);

        }
    }

    public function vaciarCarrito() {
        unset($_SESSION['carrito']); // Esto eliminará la variable de la sesión
        // o bien, para asegurar que esté vacía pero siga existiendo:
        $_SESSION['carrito'] = [];
    }

}