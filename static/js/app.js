document.addEventListener("DOMContentLoaded", function () {

    // 1. Cambiar imagen de perfil al hacer clic
    const userImg = document.querySelector(".user-img-container");
    const fileInput = document.getElementById("file-input");

    if (userImg && fileInput) {
        userImg.addEventListener("click", function () {
            fileInput.click();
        });
    }

    // 2. Fecha mínima: hoy
    const inputFecha = document.getElementById("miFecha");
    if (inputFecha) {
        const hoy = new Date();
        const fechaLocal = hoy.getFullYear() + '-' +
                           String(hoy.getMonth() + 1).padStart(2, '0') + '-' +
                           String(hoy.getDate()).padStart(2, '0');
        inputFecha.setAttribute("min", fechaLocal);
    }

    // 3. Botones de hora: cambia color al hacer clic
    const botones = document.querySelectorAll('.hour-date button');

    botones.forEach(boton => {
        boton.addEventListener('click', function (e) {
            e.preventDefault();

            // Eliminar la clase 'activo' de todos los botones
            botones.forEach(b => b.classList.remove('activo'));

            // Agregar 'activo' al botón clicado
            this.classList.add('activo');
        });
    });
});

// MENU DESPLEGABLE DEL NAVBAR
document.addEventListener("DOMContentLoaded", () => {
    const userIcon = document.getElementById("userIcon");
    const dropdownMenu = document.getElementById("dropdownMenu");

    userIcon.addEventListener("click", (e) => {
        e.preventDefault();
        dropdownMenu.style.display = (dropdownMenu.style.display === "block") ? "none" : "block";
    });

    // Ocultar el menú si se hace clic fuera
    window.addEventListener("click", (e) => {
        if (!userIcon.contains(e.target) && !dropdownMenu.contains(e.target)) {
            dropdownMenu.style.display = "none";
        }
    });
});



document.addEventListener('DOMContentLoaded', function() {
    const hourButtons = document.querySelectorAll('.btn-hour');
    const hiddenHourInput = document.getElementById('hora_cita');

    hourButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Limpia la selección en botones anteriores
            hourButtons.forEach(btn => btn.classList.remove('selected'));
            // Marca el botón seleccionado
            button.classList.add('selected');
            // Guarda el valor de la hora en el input oculto
            hiddenHourInput.value = button.getAttribute('data-hora');
        });
    });
});

