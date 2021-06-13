package peticiones;

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
import modelos.UsuarioModelo;

@WebServlet(name = "AdministrarUsuario", urlPatterns = {"/AdministrarUsuario"})
public class AdministrarUsuario extends HttpServlet {

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
            String cedula = request.getParameter("cedula");
            Usuario us = new Usuario();

            switch (opcion) {
                case "ascenderUsuario":

                    try {
                        List<UsuarioModelo> usuario = us.obtenerUsuario(cedula);
                        if (!usuario.isEmpty()) {
                            if (!usuario.get(0).tipoDeUsuario.equals("ADMIN")) {
                                String s = String.format("UPDATE usuario SET tipo_de_usuario='%s' WHERE cedula='%s'", "ADMIN", cedula);
                                if (us.ejecutarActualizacion(s) == 1) {
                                    out.println("OK");
                                    response.setStatus(200);
                                }
                            } else {
                                String s = String.format("UPDATE usuario SET tipo_de_usuario='%s' WHERE cedula='%s'", "USER", cedula);
                                if (us.ejecutarActualizacion(s) == 1) {
                                    out.println("OK");
                                    response.setStatus(200);
                                }
                            }
                        } else {
                            response.sendError(400);
                        }
                    } catch (SQLException ex) {
                        response.sendError(400);
                    }

                    break;
                case "eliminarUsuario": {
                    try {
                        List<UsuarioModelo> usuario = us.obtenerUsuario(cedula);
                        if (!usuario.isEmpty()) {
                            if (!usuario.get(0).tipoDeUsuario.equals("ADMIN")) {
                                String sentencia1 = String.format("delete from articulo_elegido where usuario_que_elije = '%s';", cedula);
                                String sentencia2 = String.format("delete from orden_de_compra where usuario_que_pertenece = '%s';", cedula);
                                String sentencia3 = String.format("delete from usuario where cedula = '%s';", cedula);
                                us.ejecutarActualizacion(sentencia1);
                                us.ejecutarActualizacion(sentencia2);
                                us.ejecutarActualizacion(sentencia3);
                                out.println("Eliminado");
                                response.setStatus(200);
                            } else {
                                response.sendError(403);
                            }
                        } else {
                            response.sendError(400);
                        }
                    } catch (SQLException ex) {
                        response.sendError(400);
                    }
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
