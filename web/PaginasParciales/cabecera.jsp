<%@page import="modelos.UsuarioModelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="cabecera">

    <%
        boolean estaConSession = false;
        String rol = "";
        UsuarioModelo usuario = (UsuarioModelo) session.getAttribute("datos");

        if (usuario != null) {
            estaConSession = true;
            rol = usuario.tipoDeUsuario;
        }

    %>

    <a href="<%=estaConSession ? rol.equals("ADMIN") ? "/administracion" : "/productos" : "/"%>" style="text-decoration: none; color: white;" class="imagen-texto">
        <img src="https://image.flaticon.com/icons/svg/1753/1753752.svg" width="55px" />
        <p>Haceb Electrodomésticos</p>
    </a>

        <img id="menu" src="https://image.flaticon.com/icons/svg/3388/3388823.svg" width="25px" />
        
    <div id="listado">
        <ul class="lista-cabecera" >

            <%if (estaConSession) {%>
            <li>
                <a href="/CerrarSesion" style="text-decoration: none; color: white;">Cerrar Sesión</a>
            </li>
            <%} else {%>
            <li>
                <a href="/productos/ver_articulos.jsp" style="text-decoration: none; color: white;">Ver Artículos</a>
            </li>
            <li>
                <a href="/iniciar.jsp" style="text-decoration: none; color: white;">Iniciar</a>
            </li>
            <li>
                <a href="/registro.jsp" style="text-decoration: none; color: white;">Registrarse</a>
            </li>
            <%}%>

        </ul>
    </div>

</div>
<script>

    let listado = document.getElementById("listado");
    let menu = document.getElementById("menu");
    
    menu.addEventListener('click', () => {
        listado.style.display = null
        menu.style.display = "none"
    })

    const validarTamano = () => {

        let anchoTotal = window.innerWidth;
        if (anchoTotal <= 768) {
            listado.style.display = "none"
            menu.style.display = null
        } else {
            listado.style.display = null
            menu.style.display = "none"
        }   
    };

    validarTamano();

    window.addEventListener('resize', () => {
        validarTamano();
    });



</script>