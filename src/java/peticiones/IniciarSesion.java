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
import javax.servlet.http.HttpSession;
import modelos.UsuarioModelo;

@WebServlet(name = "IniciarSesion", urlPatterns = {"/IniciarSesion"})
public class IniciarSesion extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            response.setContentType("text/html;charset=UTF-8");

            String cedula = request.getParameter("cedula");
            String contrasena = request.getParameter("contrasena");

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Información</title>");
            out.println("<link rel=\"stylesheet\" href=\"estilos.css\"/>");
            out.println("</head>");
            out.println("<body>");
            out.println("<center>");

            try {
                List<UsuarioModelo> obtenerUsuario = new Usuario().obtenerUsuario(cedula);
                if (obtenerUsuario.isEmpty()) {
                    out.println("<h2>Usuario y/o Contraseña incorrectos</h2>");
                    out.println("<a href=\"/iniciar.jsp\">Volver a intentarlo</a>");
                } else {
                    UsuarioModelo usuario = obtenerUsuario.get(0);
                    // Validamos que las claves sean iguales
                    if (usuario.contrasena.equals(contrasena)) {
                        // Borramos datos sencibles de la sesion
                        usuario.contrasena = "";
                        // Creamos una sesión para este usuario
                        HttpSession session = request.getSession(true);
                        session.setAttribute("datos", usuario);
                        System.out.println(usuario.tipoDeUsuario);
                        if (usuario.tipoDeUsuario.equals("ADMIN")) {
                            response.sendRedirect("/administracion");
                        } else {
                            response.sendRedirect("/productos");
                        }
                    } else {
                        out.println("<h2>Usuario y/o Contraseña incorrectos</h2>");
                        out.println("<a href=\"/iniciar.jsp\">Volver a intentarlo</a>");
                    }
                }

            } catch (SQLException e) {
                out.println("<h2>Ha ocurrido un error</h2>");
                out.println("<a href=\"/iniciar.jsp\">Volver a intentarlo</a>");
            }
            out.println("</center>");
            out.println("</body>");
            out.println("</html>");
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
