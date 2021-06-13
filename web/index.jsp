<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bienvenido</title>
        <link rel="stylesheet" href="estilos.css"/>
    </head>
    <body>
        <jsp:include page="PaginasParciales/cabecera.jsp"/>
    <center>
        <h1>Bienvenido al sistema de haceb electrodomésticos</h1>
        <img src="./administracion/Logo-haceb.png" width="50%" alt="Haceb un hogar, mil historias felices"/> <br/><br/>
        <button id="irAMapa">
            Ver las direcciones de nuestras sucursales
        </button>
    </center>
    <script>
        let mapa = document.getElementById("irAMapa");
        mapa.addEventListener('click', () => {
           window.location.href = '/mapa.jsp'; 
        });
    </script>
</body>
</html>
