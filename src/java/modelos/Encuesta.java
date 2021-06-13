package modelos;

public class Encuesta {

    public int id_respuesta;
    public int id_orden;
    public String pregunta;
    public String respuesta_dada;

    public Encuesta(int id_respuesta, int id_orden, String pregunta, String respuesta_dada) {
        this.id_respuesta = id_respuesta;
        this.id_orden = id_orden;
        this.pregunta = pregunta;
        this.respuesta_dada = respuesta_dada;
    }

}
