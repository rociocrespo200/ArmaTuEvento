<?php

class HomeModel {
    private $database;

    public function __construct($database) {
        $this->database = $database;
    }

    public function traerTipos(){
        return $this->database->query("SELECT * FROM `tipoDeServicio`");
    }

    public function traerProvincias(){
        return $this->database->query("SELECT * FROM `provincia`");
    }

}