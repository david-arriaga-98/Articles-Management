/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package peticiones;

import entidades.Articulos;
import entidades.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelos.ArticuloModelo;
import modelos.OrdenDeCompra;
import modelos.UsuarioModelo;

/**
 *
 * @author hugo
 */
@WebServlet(name = "ElegirArticulo", urlPatterns = {"/ElegirArticulo"})
public class ElegirArticulo extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            response.setContentType("text/html;charset=UTF-8");
            // 1. Obtenemos los datos
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            String articulo = request.getParameter("articulo");
            String usuario = request.getParameter("usuario");

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Información</title>");
            out.println("<link rel=\"stylesheet\" href=\"estilos.css\"/>");
            out.println("</head>");
            out.println("<body>");
            out.println("<center>");

            try {
                // 2. Para evitar errores, validamos que el usuario exista
                List<UsuarioModelo> obtenerUsuario = new Usuario().obtenerUsuario(usuario);

                if (obtenerUsuario.isEmpty()) {
                    out.println("<h2>El usuario que elegiste, para guardar este registro, no existe</h2>");
                } else {
                    Articulos arti = new Articulos();
                    List<OrdenDeCompra> ordenesDeCompra = arti.obtenerOrdenesDeCompra(usuario);
                    ArticuloModelo articuloElegido = arti.obtenerArticulo(articulo).get(0);
                    // 3. Si no hay registros, entonces creamos una de 0
                    String SqlCrearOrden = String.format("insert into orden_de_compra(usuario_que_pertenece) values ('%s');", usuario);
                    if (ordenesDeCompra.isEmpty()) {
                        if (arti.ejecutarActualizacion(SqlCrearOrden) == 1) {
                            escogerArticulo(articuloElegido, cantidad, usuario, response);
                        } else {
                            out.println("<h2>Ha ocurrido un error al guardar una nueva orden</h2>");
                        }
                    } else {
                        OrdenDeCompra ordenDeCompra = ordenesDeCompra.get(0);
                        if (ordenDeCompra.estado) {
                            if (arti.ejecutarActualizacion(SqlCrearOrden) == 1) {
                                escogerArticulo(articuloElegido, cantidad, usuario, response);
                            } else {
                                out.println("<h2>Ha ocurrido un error al guardar una nueva orden</h2>");
                            }
                        } else {
                            // Aqui rellenamos con esta
                            escogerArticulo(articuloElegido, cantidad, usuario, response);
                        }
                    }
                }

            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }

            out.println("</center>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private void escogerArticulo(ArticuloModelo articulo, int cantidad, String cedula, HttpServletResponse response) throws SQLException, Exception {
        try {
            // 1. Obtenemos la ultima orden de compra, no habrá errores por los filtros
            Articulos arti = new Articulos();
            OrdenDeCompra ordenDeCompra = arti.obtenerOrdenesDeCompra(cedula).get(0);

            // 2. Validamos que las existencias sean correctas
            if (articulo.cantidad < cantidad) {
                throw new Exception("No hay unidades suficientes");
            } else {
                // 3. Guardamos el artículo elegido
                double total = articulo.precio_unitario * cantidad;
                int totalDeArticulos = articulo.cantidad - cantidad;
                String replace = Double.toString(total).replace(',', '.');
                String s = String.format("insert into articulo_elegido(numero_de_orden, usuario_que_elije, numero_de_articulos, valor_total, articulo_que_pertenece) values (%s, '%s', %s, %s, '%s')", Integer.toString(ordenDeCompra.codigo), cedula, Integer.toString(cantidad), replace, articulo.codigo_de_articulo);
                if (arti.ejecutarActualizacion(s) == 1) {
                    // 4. Actualizamos el articulo
                    String SqlActualizarArt = String.format("update articulos set cantidad=%s where codigo_de_articulo='%s';", Integer.toString(totalDeArticulos), articulo.codigo_de_articulo);
                    if (arti.ejecutarActualizacion(SqlActualizarArt) == 1) {
                        // 5 . Redirigimos
                        response.sendRedirect("/productos/comprar_electrodomesticos.jsp");
                    } else {
                        throw new Exception("Error");
                    }
                } else {
                    throw new Exception("Error");
                }
            }

        } catch (SQLException ex) {
            throw ex;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
