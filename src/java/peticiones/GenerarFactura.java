/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package peticiones;

import entidades.Articulos;
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
import modelos.ArticulosEnFactura;
import modelos.OrdenDeCompra;
import modelos.UsuarioModelo;

/**
 *
 * @author hugo
 */
@WebServlet(name = "GenerarFactura", urlPatterns = {"/GenerarFactura"})
public class GenerarFactura extends HttpServlet {

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

            // 1. Obtenemos los valores
            String tipoDePago = request.getParameter("metodo_pago");
            int numeroDeOrden = Integer.parseInt(request.getParameter("orden"));
            String cedula = request.getParameter("cedula");
            String tarjeta = request.getParameter("tarjeta");

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GenerarFactura</title>");
            out.println("</head>");
            out.println("<body>");

            // 2. Obtenemos los articulos para hacer el calculo
            double precioTotal = 0;
            double descuento;
            double precioDefinitivo;

            try {
                Articulos articulo = new Articulos();
                OrdenDeCompra ordenDeCompra = articulo.obtenerOrdenDeCompra(numeroDeOrden, cedula).get(0);
                List<ArticulosEnFactura> articulosEnFactura = articulo.obtenerArticulosDeFactura(ordenDeCompra.codigo);
                for (ArticulosEnFactura arti : articulosEnFactura) {
                    precioTotal += arti.valor;
                }
                descuento = tipoDePago.equals("Efectivo") ? precioTotal * 0.10 : 0;
                precioDefinitivo = precioTotal - descuento;

                HttpSession session = request.getSession();
                UsuarioModelo usuario = (UsuarioModelo) session.getAttribute("datos");
                OrdenDeCompra ordenCompra = new OrdenDeCompra(0, true, tipoDePago, descuento, precioDefinitivo, articulosEnFactura.size(), "", usuario.direccion, tipoDePago.equals("Efectivo") ? "" : tarjeta, false);

                String sql = "UPDATE orden_de_compra SET estado=" + ordenCompra.estado + ", metodo_de_pago='" + ordenCompra.metodo_de_pago + "', descuento=" + ordenCompra.descuento + ", precio_total=" + ordenCompra.precio_total + ", numero_de_articulos=" + ordenCompra.numero_de_articulos + ", tarjeta='"+  ordenCompra.tarjeta+ "', direccion_a_facturar='" + ordenCompra.direccion_a_facturar+ "' where codigo=" + numeroDeOrden;

                if (articulo.ejecutarActualizacion(sql) == 1) {
                    response.sendRedirect("/productos/ver_factura.jsp?id=" + numeroDeOrden);
                } else {
                    out.println("<p>Ha ocurrido un error</p>");
                }

            } catch (SQLException ex) {
                out.println("<p>Ha ocurrido un error, referencia: " + ex.getMessage() + "</p>");
            }

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
