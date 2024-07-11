function irAIngreso(){
    document.getElementById("div_registro").style.display = "none";
    document.getElementById("div_ingreso").style.display = "block";
}

function irARegistro(){
    document.getElementById("div_ingreso").style.display = "none";
    document.getElementById("div_registro").classList.remove("ocultar_div");
}