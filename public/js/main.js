function irAIngreso() {
    document.getElementById("div_registro").style.display = "none";
    document.getElementById("div_ingreso").style.display = "block";
}

function irARegistro() {
    document.getElementById("div_ingreso").style.display = "none";
    document.getElementById("div_registro").classList.remove("ocultar_div");
}

// ---------- Ver mas  ---------- 

document.addEventListener("DOMContentLoaded", function () {
    const divFiltros = document.querySelectorAll(".div_filtros_div");

    divFiltros.forEach((div) => {
        const filtros = div.querySelectorAll(".div_filtro");
        // Mostrar solo los primeros 5 al cargar la página
        filtros.forEach((filtro, index) => {
            if (index < 5) {
                filtro.classList.remove("hidden"); // Muestra los primeros 5
            } else {
                filtro.classList.add("hidden"); // Oculta los demás
            }
        });
    });
});

function verMas(id) {
    const container = document.getElementById(id);
    const hiddenDivs = container.querySelectorAll(".div_filtro.hidden");
    hiddenDivs.forEach((div) => div.classList.remove("hidden")); // Muestra todos los elementos ocultos

    // Alternar botones
    container.querySelector(".verMas").style.display = "none";
    container.querySelector("#verMenosBtn_" + id.split("_")[1]).style.display =
        "inline-block";
}

function verMenos(id) {
    const container = document.getElementById(id);
    const divFiltros = container.querySelectorAll(".div_filtro");

    // Mostrar solo los primeros 5 nuevamente
    divFiltros.forEach((div, index) => {
        if (index < 5) {
            div.classList.remove("hidden");
        } else {
            div.classList.add("hidden");
        }
    });

    // Alternar botones
    container.querySelector("#verMasBtn_" + id.split("_")[1]).style.display =
        "inline-block";
    container.querySelector("#verMenosBtn_" + id.split("_")[1]).style.display =
        "none";
}
