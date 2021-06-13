<%@page import="java.util.List"%>
<%@page import="modelos.ArticuloModelo"%>
<%@page import="entidades.Articulos"%>
<%@page import="modelos.UsuarioModelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrar productos</title>
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
            Articulos art = new Articulos();
            List<ArticuloModelo> articulos = art.obtenerArticulos();

        %>
    </head>
    <body>
        <jsp:include page="../PaginasParciales/cabecera.jsp"/>
        <% if (rol.equals("ADMIN")) {%>
        <div class="centrar" id="tabla">
            <h1>Gestión de artículos</h1>
            <button style="margin-bottom: 1.5rem" id="agregarArticulo" >+ Agregar un nuevo artículo</button>
            <table border cellpadding="10" cellspacing="0" style="margin-bottom: 20px">
                <tr>
                    <th scope="col">Código</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Cantidad</th>
                    <th scope="col">Precio Unitario</th>
                    <th scope="col">Imagen</th>
                    <th scope="col">Acciones</th>
                </tr>

                <% if (articulos.isEmpty()) { %>
                <tr>
                    <th colspan="6"><p style="color: #c62828">No hay artículos</p></th>
                </tr>
                <% } else { %>
                <% for (ArticuloModelo articulo : articulos) {%>
                <tr>
                    <td><%=articulo.codigo_de_articulo%></td>
                    <td><%=articulo.nombre%></td>
                    <td><%=articulo.cantidad%></td>
                    <td>$ <%=articulo.precio_unitario%></td>
                    <td><img src="<%=articulo.url_de_imagen%>" width="45px" /></td>
                    <td> <button style="background-color: #B71C1C" class="btnEliminarArticulo" value="<%=articulo.codigo_de_articulo%>">Eliminar</button> <button class="btnEditarArticulo" value="<%=articulo.codigo_de_articulo%>">Editar</button> </td>
                </tr>
                <% }%>
                <% }%>

            </table>
        </div>

        <div class="centrar" id="editarProducto">
            <h1>Edita este artículo</h1>
            <button style="margin-bottom: 1.5rem" id="btnQuitarEditarProducto" >× Cancelar</button>

            <form id="formularioEditarArticulo">
                <fieldset style="width: 210px">
                    <br/>
                    <label for="cod">Código:</label>
                    <input type="text" required id="cod" name="cod" readonly/> <br/><br/>
                    <label for="nomb">Nombre del artículo:</label>
                    <input type="text" required id="nomb" name="nomb" /> <br/><br/>
                    <label for="descr">Descripción del artículo:</label>
                    <input type="text" required id="descr" name="descr" /> <br/><br/>
                    <label for="uril">Url del artículo:</label>
                    <input type="text" required id="uril" name="uril" /> <br/><br/>

                    <div class="centrar">
                        <button type="submit">Guardar</button><br/>
                    </div>
                </fieldset>
            </form>

        </div>

        <div class="centrar" id="nuevoProducto">
            <h1>Agregar un nuevo artículo</h1>
            <button style="margin-bottom: 1.5rem" id="btnTabla" >× Cancelar</button>

            <form id="formularioAgregarArticulo">
                <fieldset style="width: 210px">
                    <br/>
                    <label for="codigo">Código:</label>
                    <input type="text" required id="codigo" name="codigo" readonly value="<%=Double.toString(Math.random()).substring(2, 7)%>"  /> <br/><br/>
                    <label for="nombres">Nombre del artículo:</label>
                    <input type="text" required id="nombres" name="nombres" /> <br/><br/>
                    <label for="descripcion">Descripción del artículo:</label>
                    <input type="text" required id="descripcion" name="descripcion" /> <br/><br/>
                    <label for="cantidad">Cantidad de artículos:</label>
                    <input type="number" required id="cantidad" name="cantidad" /> <br/><br/>
                    <label for="precio">Precio:</label>
                    <input type="number" required id="precio" name="precio" step=".01"/> <br/><br/>
                    <label for="url">Url del artículo:</label>
                    <input type="text" required id="url" name="url" /> <br/><br/>

                    <div class="centrar">
                        <button type="submit">Guardar</button><br/>
                    </div>
                </fieldset>
            </form>

        </div>

        <script>
            const main = () => {
                let btnAgregarArticulo = document.getElementById("agregarArticulo");
                let tabla = document.getElementById("tabla");
                let nuevoProducto = document.getElementById("nuevoProducto");
                let btnTabla = document.getElementById("btnTabla");
                let btnEliminarArticulo = document.getElementsByClassName("btnEliminarArticulo");
                let formularioAgregarArticulo = document.getElementById("formularioAgregarArticulo");
                let btnEditarArticulo = document.getElementsByClassName("btnEditarArticulo");

                let editarProducto = document.getElementById("editarProducto");
                let btnQuitarEditarProducto = document.getElementById("btnQuitarEditarProducto");
                let formularioEditarArticulo = document.getElementById("formularioEditarArticulo");

                nuevoProducto.style.display = 'none';
                editarProducto.style.display = 'none';

                // Agregar artículo
                formularioAgregarArticulo.addEventListener('submit', async (e) => {
                    e.preventDefault();
                    let codigo = document.getElementById("codigo").value;
                    let nombres = document.getElementById("nombres").value;
                    let descripcion = document.getElementById("descripcion").value;
                    let cantidad = document.getElementById("cantidad").value;
                    let precio = document.getElementById("precio").value;
                    let url = document.getElementById("url").value;
                    let mensajeDeError = '';
                    let regExUrl = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;

                    // Validamos el codigo
                    if (!isNaN(codigo)) {
                        if (!isNaN(cantidad)) {
                            if (!isNaN(cantidad)) {
                                if (regExUrl.test(url)) {
                                    const parametros = '/AdministrarProducto?opcion=guardarProducto&codigo=' + codigo + '&nombre=' + nombres + '&descripcion=' + descripcion + '&cantidad=' + cantidad + '&precio=' + precio + '&url=' + url;
                                    // enviamos una peticion al servidor
                                    const respuesta = await fetch(parametros);
                                    if (respuesta.status === 200) {
                                        alert('El artículo se creó satisfactoriamente');
                                        location.reload();
                                    } else {
                                        alert('Ha ocurrido un error al guardar su artículo');
                                    }

                                    return;
                                } else {
                                    mensajeDeError = 'La url de la imagen es inválida';
                                }
                            } else {
                                mensajeDeError = 'El precio es inválido';
                            }
                        } else {
                            mensajeDeError = 'La cantidad es inválida';
                        }
                    } else {
                        mensajeDeError = 'El código es inválido';
                    }
                    window.alert(mensajeDeError);

                });

                // Eliminar articulo
                for (let i = 0; i < btnEliminarArticulo.length; i++) {
                    btnEliminarArticulo[i].addEventListener('click', async (e) => {
                        let estado = window.confirm('¿Seguro que deseas eliminar este artículo?');
                        if (estado) {
                            const respuesta = await fetch('/AdministrarProducto?opcion=eliminar&codigo=' + e.target.value);
                            if (respuesta.status === 200) {
                                window.alert("Artículo eliminado correctamente");
                                location.reload();
                            } else {
                                window.alert("Este artículo está en el inventario de otros usuarios, asi que no se puede eliminar");
                            }
                        }
                    });
                }
                // END ELIMINAR
                // Editar
                for (let i = 0; i < btnEditarArticulo.length; i++) {
                    btnEditarArticulo[i].addEventListener('click', async (e) => {
                        tabla.style.display = 'none';
                        editarProducto.style.display = null;
                        let codigo = e.target.value;
                        const respuesta = await fetch('/AdministrarProducto?opcion=obtenerArticulo&codigo=' + codigo);
                        if (respuesta.status === 404) {
                            alert('El artículo no existe');
                        } else if (respuesta.status === 200) {
                            const resp2 = await respuesta.json();
                            const datosAPintar = resp2.respuesta.split('::');
                            document.getElementById("cod").setAttribute('value', datosAPintar[0]);
                            document.getElementById("nomb").setAttribute('value', datosAPintar[1]);
                            document.getElementById("descr").setAttribute('value', datosAPintar[2]);
                            document.getElementById("uril").setAttribute('value', datosAPintar[3]);

                        } else {
                            alert('Ha ocurrido un error al obtener su registro');
                        }
                    });
                }
                formularioEditarArticulo.addEventListener('submit', async (e) => {

                    e.preventDefault();
                    const codigoo = document.getElementById("cod").value;
                    const nombree = document.getElementById("nomb").value;
                    const descc = document.getElementById("descr").value;
                    const urli = document.getElementById("uril").value;
                    
                    const respuesta = await fetch('/AdministrarProducto?opcion=editarArticulo&codigo=' + codigoo + '&nombre=' + nombree + '&desc=' + descc + '&url=' + urli);

                    if(respuesta.status === 200) {
                        alert("Su artículo ha sido actualizado con exito");
                        location.reload();
                    } else {
                        alert("Ha ocurrido un error al guardar su información");
                    }

                });
                btnQuitarEditarProducto.addEventListener('click', () => {
                    tabla.style.display = null;
                    editarProducto.style.display = 'none';
                });
                // END EDITAR


                btnAgregarArticulo.addEventListener('click', () => {
                    tabla.style.display = 'none';
                    nuevoProducto.style.display = null;
                });

                btnTabla.addEventListener('click', () => {
                    tabla.style.display = null;
                    nuevoProducto.style.display = 'none';
                });
            };

            main();

            const esNumero = (numero) => {
                return isNaN(numero);
            };

        </script>

        <% } else { %>
        <h1 style="text-align: center; color: #c62828;">Tu Rol no te permite ingresar a esta página</h1>
        <% }%>
    </body>
</html>
