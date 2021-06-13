<%@page import="java.util.List"%>
<%@page import="entidades.Usuario"%>
<%@page import="modelos.UsuarioModelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrar usuarios</title>
        <link rel="stylesheet" href="../estilos.css"/>
        <%
            String rol = "";
            UsuarioModelo usuario = (UsuarioModelo) session.getAttribute("datos");

            if (usuario != null) {
                rol = usuario.tipoDeUsuario;
            } else {
                response.sendRedirect("/iniciar.jsp");
                return;
            }
            Usuario us = new Usuario();
            List<UsuarioModelo> usuarios = us.obtenerTodosLosUsuarios();

        %>
    </head>
    <body>
        <jsp:include page="../PaginasParciales/cabecera.jsp"/>
        <% if (rol.equals("ADMIN")) {%>

        <div class="centrar">
            <h1>Gestión de usuarios</h1>
            <a style="margin-bottom: 10px; text-decoration: none; color: #0D47A1" href="./reporte_de_usuario.jsp">Ver reporte de usuario</a>
            <table border cellpadding="10" cellspacing="0">
                <tr>
                    <th scope="col">CI</th>
                    <th scope="col">Nombres</th>
                    <th scope="col">Tipo De Usuario</th>
                    <th scope="col">Edad</th>
                    <th scope="col">Género</th>
                    <th scope="col">Acciones</th>
                </tr>

                <% for (UsuarioModelo usu : usuarios) {%>
                <tr>
                    <td><%=usu.cedula%></td>
                    <td><%=usu.nombres%></td>
                    <td><%=usu.tipoDeUsuario.equals("ADMIN") ? "Administrador" : "Usuario"%></td>
                    <td><%=usu.edad%></td>
                    <td><%=usu.sexo.equals("M") ? "Masculino" : "Femenino"%></td>
                    <td>
                        <button value="<%=usu.cedula%>" style="background-color: #B71C1C" class="btnEliminarUsuario">Eliminar</button>
                        <button value="<%=usu.cedula%>" class="btnAscenderUsuario"><%=!usu.tipoDeUsuario.equals("ADMIN") ? "Hacer Admin" : "Hacer Usuario"%></button>
                    </td>
                </tr>
                <%}%>

            </table>
        </div>
        <script>

            // Eliminar
            let btnEliminarUsuario = document.getElementsByClassName("btnEliminarUsuario");
            for (let i = 0; i < btnEliminarUsuario.length; i++) {
                btnEliminarUsuario[i].addEventListener('click', async (e) => {
                    if (confirm("¿Seguro que deseas eliminar este usuario?\n\nTodo registro será eliminado")) {
                        const response = await fetch('/AdministrarUsuario?opcion=eliminarUsuario&cedula=' + e.target.value);
                        if (response.status === 403) {
                            alert("Este usuario es un administrador, no puede ser eliminado");
                        } else if (response.status === 200) {
                            alert("Usuario eliminado correctamente");
                            location.reload();
                        } else {
                            alert("Ha ocurrido un error al eliminar este usuario");
                        }
                    }
                });
            }
            // Ascender
            let btnAscenderUsuario = document.getElementsByClassName("btnAscenderUsuario");
            for (let i = 0; i < btnAscenderUsuario.length; i++) {
                btnAscenderUsuario[i].addEventListener('click', async (e) => {
                    if (confirm("¿Seguro que deseas cambiar el rol de este usuario?")) {
                        const response = await fetch('/AdministrarUsuario?opcion=ascenderUsuario&cedula=' + e.target.value);
                        if (response.status === 200) {
                            alert("Se ha cambiado el rol del usuario correctamente");
                            location.reload();
                        } else {
                            alert("Ha ocurrido un error al cambiar el rol de este usuario");
                        }
                    }
                });
            }

        </script>

        <% } else { %>
        <h1 style="text-align: center; color: #c62828;">Tu Rol no te permite ingresar a esta página</h1>
        <% }%>
    </body>
</html>
