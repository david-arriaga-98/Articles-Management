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

@WebServlet(name = "RegistrarUsuario", urlPatterns = {"/RegistrarUsuario"})
public class RegistrarUsuario extends HttpServlet {

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
            // 1. Recogemos los parametros
            String cedula = request.getParameter("cedula");
            String nombres = request.getParameter("nombres");
            int edad = Integer.parseInt(request.getParameter("edad"));
            String direccion = request.getParameter("direccion");
            String sexo = request.getParameter("sexo");
            String contrasena = request.getParameter("contrasena");

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Información</title>");
            out.println("<link rel=\"stylesheet\" href=\"estilos.css\"/>");
            out.println("</head>");
            out.println("<body>");
            out.println("<center>");
            // Validamos que el usuario no exista en la base de datos
            // 2. Buscamos al usuario en la base de datos
            try {
                Usuario usuario = new Usuario();
                List<UsuarioModelo> obtenerUsuario = usuario.obtenerUsuario(cedula);
                if (obtenerUsuario.isEmpty()) {
                    // 3. Guardamos al usuario en la base de datos
                    UsuarioModelo newUsuario = new UsuarioModelo(cedula, nombres, edad, sexo, contrasena, direccion, "USER");
                    int estado = usuario.ingresarUsuario(newUsuario);

                    if (estado == 1) {
                        response.sendRedirect("/iniciar.jsp");
                        out.println("<h2>Usuario registrado correctamente</h2>");
                        out.println("<a href=\"/iniciar.jsp\">Iniciar Sesión</a></br></br>");
                        out.println("<a href=\"/\">Ir a la página principal</a>");
                    }

                } else {
                    out.println("<h2>Esta cédula ya se encuentra registrada</h2>");
                    out.println("<a href=\"/registro.jsp\">Volver a intentarlo</a>");
                }

            } catch (SQLException e) {
                out.println("<h2>Ha ocurrido al registrar el usuario</h2>");
                out.println("<a href=\"/registro.jsp\">Volver a intentarlo</a>");
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
