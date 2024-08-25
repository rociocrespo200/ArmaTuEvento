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
                'servicio' =>  $this->model->buscarSalon($id),
                'esSalon' =>  true,  
            ];
            
            //print_r($datos['servicio']);
            $this->render->printView('servicioEsp', $datos);

        }else{ //sino me trae todos los servicios
            $filtro = isset($_GET['filtro']) ? $_GET['filtro'] : null;


            $datos = [
                'servicios' => $this->model->obtenerServiciosFiltrados(),
                'hayTipos' => true,
                'tipos' =>  $this->model->traerTipos(),
                'provincias' => $this->model->traerProvincias(),
                'localidades'=> $this->model->traerLocalidades(),
                'filtros'=>  isset($_SESSION['filtros']) ? $_SESSION['filtros'] : null,
            ];
    
           // print_r($datos['servicios']);
            $this->render->printView('servicios', $datos);
        }

    }

    public function filtrar() {

        $filtrosActuales = [
            'tipos' => $this->model->buscar("TipoDeServicio", isset($_POST['tipos']) ? $_POST['tipos'] : []),
            'provincias' => $this->model->buscar("Provincia", isset($_POST['provincias']) ? $_POST['provincias'] : []),
            'localidades' => $this->model->buscar("Localidad", isset($_POST['localidades']) ? $_POST['localidades'] : []),
            'busqueda' =>  isset($_POST['busqueda']) ? $_POST['busqueda'] : '',
            'orden' =>  isset($_POST['orden']) ? $_POST['orden'] : 'recomendados'
        ];

        $this->actualizarFiltros($filtrosActuales);

        $this->show();
    }

    public function actualizarFiltros($filtrosActuales) {
        // Inicializar $_SESSION['filtros'] si no existe
        if (!isset($_SESSION['filtros'])) {
            $_SESSION['filtros'] = $filtrosActuales;
        } else {
            // Actualizar los filtros existentes
            foreach ($filtrosActuales as $key => $value) {
                if (is_array($value)) {
                    // Si el filtro es un array, fusionar los elementos nuevos con los existentes
                    if (isset($_SESSION['filtros'][$key]) && is_array($_SESSION['filtros'][$key])) {

                        $_SESSION['filtros'][$key] = array_merge_recursive($_SESSION['filtros'][$key], $value);
                    } else {
                        // Si no existe, simplemente asignar el nuevo valor
                        $_SESSION['filtros'][$key] = $value;
                    }
                } else {
                    // Si el filtro no es un array, simplemente asignar el nuevo valor
                    $_SESSION['filtros'][$key] = $value;
                }
            }
        }
    }


    public function eliminarFiltro() {

        if (isset($_GET['tipo'])) $this->eliminarFiltroDeLaArray('tipos', $_GET['tipo']);

        if (isset($_GET['localidad'])) $this->eliminarFiltroDeLaArray('localidades', $_GET['localidad']);

        if (isset($_GET['provincia'])) $this->eliminarFiltroDeLaArray('provincias', $_GET['provincia']);

        if (isset($_GET['busqueda'])) $_SESSION['filtros']['busqueda'] = null; 

        $this->show();
    }
    
       //print_r($_SESSION['filtros']); // Descomenta para depuración

    public function traerSalones() {

        $filtro = isset($_GET['filtro']) ? $_GET['filtro'] : null;

        $datos = [
            'salones' => $this->model->traerSalones($filtro),
        ];
        //print_r($datos['salones']);
        $this->render->printView('servicios', $datos);
    }

    public function agregarAlCarrito() {

        if (isset($_GET['id_servicio'])) { // AGREGAR SERVICIO
            
            $id = $_GET['id_servicio'];
            $nuevoServicio = $this->model->buscarServicio($id);
            
            if (!isset($_SESSION['carrito'])) $_SESSION['carrito'] = []; // Inicializar el carrito si no existe
            
            $existe = false; 
            foreach ($_SESSION['carrito'] as $salon) { // Verificar si el servicio ya está en el carrito
                if ($salon['id'] == $id)  $existe = true; break;
            }

            if (!$existe) $_SESSION['carrito'][] = $nuevoServicio;// Si no existe, agregarlo al carrito
            

            Redirect::to('/service/show?id_servicio=' . $id);

        }else{ // AGREGAR SALON

            $id = $_GET['id_salon'];
            $nuevoSalon = $this->model->buscarSalon($id);
            
            if (!isset($_SESSION['carrito2'])) $_SESSION['carrito2'] = []; // Inicializar el carrito si no existe
            
            $existe = false; // Verificar si el servicio ya está en el carrito
            foreach ($_SESSION['carrito2'] as $salon) {
                if ($salon['id'] == $id)  $existe = true; break;
            }

            if (!$existe) $_SESSION['carrito2'][] = $nuevoSalon;// Si no existe, agregarlo al carrito
            

            Redirect::to('/service/show?id_salon=' . $id);
        }
    }

    public function vaciarCarrito() {
        unset($_SESSION['carrito']); // Esto eliminará la variable de la sesión
        // o bien, para asegurar que esté vacía pero siga existiendo:
        $_SESSION['carrito'] = [];
    }

    public function eliminarFiltroDeLaArray($param, $id) {
        $array = $_SESSION['filtros'][$param];

        for ($i=0; $i < sizeof($array); $i++) {
            if($array[$i]['id'] == $id) {
                unset($_SESSION['filtros'][$param][$i]); // Elimina el elemento en el índice 2 ('c')
                $_SESSION['filtros'][$param] = array_values($_SESSION['filtros'][$param]); // Reindexa el array
            }
        }
    }


}