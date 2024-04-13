<?php
include('lib/full/qrlib.php');


use PHPMailer\PHPMailer\PHPMailer;

class UserController
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
        $this->render->printView('provedores');//crea una vista, con el constructor de esta clase, llamada home
    }

}
