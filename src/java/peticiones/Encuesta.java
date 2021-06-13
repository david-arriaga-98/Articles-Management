package peticiones;

import entidades.Articulos;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelos.OrdenDeCompra;

@WebServlet(name = "Encuesta", urlPatterns = {"/Encuesta"})
public class Encuesta extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String id = request.getParameter("factura");

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Encuesta</title>");
            out.println("</head>");
            out.println("<body>");

            // 1. Validamos que exista la factura
            Articulos articu = new Articulos();
            OrdenDeCompra orden = articu.obtenerOrdenDeCompraPor("codigo", id).get(0);

            if (orden.realizo_encuesta) {
                out.println("<h1>Ya ha realizado la encuesta</h1>");
            } else {
                
                for (int i = 1; i < 14; i++) {
                    String valor = "00" + i;
                    String valor2 = request.getParameter(valor);
                    String sql = String.format("INSERT INTO encuesta(id_orden, pregunta, respuesta_dada) values (%s, '%s', '%s')", id, valor, valor2);
                    articu.ejecutarActualizacion(sql);
                }
                String sql2 = String.format("UPDATE orden_de_compra SET realizo_encuesta=true WHERE codigo = %s", id);
                articu.ejecutarActualizacion(sql2);
                response.sendRedirect("/productos/ver_factura.jsp?id=" + id);
            }

            out.println("</body>");
            out.println("</html>");
        } catch (SQLException ex) {
            Logger.getLogger(Encuesta.class.getName()).log(Level.SEVERE, null, ex);
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
