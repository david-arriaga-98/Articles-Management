package peticiones;

import entidades.Articulos;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import javax.servlet.*;
import modelos.ArticuloModelo;

@WebServlet(name = "AdministrarProducto", urlPatterns = {"/AdministrarProducto"})
public class AdministrarProducto extends HttpServlet {

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

            String opcion = request.getParameter("opcion");
            Articulos art = new Articulos();

            switch (opcion) {

                case "editarArticulo":
                    String cod = request.getParameter("codigo");
                    String noom = request.getParameter("nombre");
                    String desc = request.getParameter("desc");
                    String uril = request.getParameter("url");

                    try {
                        List<ArticuloModelo> articulo = art.obtenerArticulo(cod);
                        if (articulo.isEmpty()) {
                            response.sendError(404);
                        } else {
                            String sentenciaSql = String.format("UPDATE articulos SET nombre='%s', descripcion='%s', url_de_imagen='%s' WHERE codigo_de_articulo='%s';", noom, desc, uril, cod);
                            int resultado = art.ejecutarActualizacion(sentenciaSql);
                            if (resultado == 1) {
                                response.setStatus(200);
                                out.println("OK");
                            } else {
                                response.sendError(400);
                            }
                        }
                    } catch (SQLException ex) {
                        response.sendError(400);
                    }

                    break;

                case "obtenerArticulo":
                    String code = request.getParameter("codigo");

                    try {
                        // Buscamos el articulo
                        List<ArticuloModelo> articulo = art.obtenerArticulo(code);
                        if (articulo.isEmpty()) {
                            response.sendError(404);
                        } else {
                            response.addHeader("Content-Type", "application/json");
                            out.println("{\"respuesta\": \"" + String.format("%s::%s::%s::%s", articulo.get(0).codigo_de_articulo, articulo.get(0).nombre, articulo.get(0).descripcion, articulo.get(0).url_de_imagen) + "\"}");
                        }
                    } catch (SQLException ex) {
                        response.sendError(400);
                    }

                    break;

                case "guardarProducto":
                    String codig = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String descripcion = request.getParameter("descripcion");
                    String cantidad = request.getParameter("cantidad");
                    String precio = request.getParameter("precio");
                    String url = request.getParameter("url");

                    // Creamos el objeto
                    try {
                        List<ArticuloModelo> articulo = art.obtenerArticulo(codig);
                        if (!articulo.isEmpty()) {
                            codig = codig + "9";
                        }
                        String prec = precio.replace(',', '.');
                        String sql = String.format("INSERT INTO articulos VALUES ('%s', %s, '%s', '%s', %s, '%s');", codig, prec, nombre, descripcion, cantidad, url);
                        int resultado = art.ejecutarActualizacion(sql);
                        if (resultado == 1) {
                            response.setStatus(200);
                            out.println("<h1>OK</h1>");
                        } else {
                            response.sendError(400);
                        }

                    } catch (SQLException ex) {
                        response.sendError(400);
                    }

                    break;

                case "eliminar":

                    String codigo = request.getParameter("codigo");
                    try {
                        // Buscamos el articulo
                        List<ArticuloModelo> articulo = art.obtenerArticulo(codigo);
                        if (articulo.isEmpty()) {
                            response.sendError(400);
                        } else {
                            // Lo eliminamos
                            int resultado = art.ejecutarActualizacion("DELETE FROM articulos WHERE codigo_de_articulo='" + codigo + "'");
                            if (resultado == 1) {
                                response.setStatus(200);
                                out.println("<h1>OK</h1>");
                            } else {
                                response.sendError(400);
                            }
                        }

                    } catch (SQLException ex) {
                        response.sendError(400);
                    }

                    break;
            }

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
