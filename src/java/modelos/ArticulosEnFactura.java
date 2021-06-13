/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelos;

/**
 *
 * @author hugo
 */
public class ArticulosEnFactura {

    public int total;
    public double valor;
    public String nombre;
    public String url;
    public double precio;

    public ArticulosEnFactura(int total, double valor, String nombre, String url, double precio) {
        this.total = total;
        this.valor = valor;
        this.nombre = nombre;
        this.url = url;
        this.precio = precio;
    }

}
