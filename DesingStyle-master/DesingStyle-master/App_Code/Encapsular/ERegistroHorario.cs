using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Class1
/// </summary>
public class ERegistroHorario
{
    public ERegistroHorario()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    private Int32 idestilista;
    private DateTime fechaini;
    private DateTime fechafin;
    private Boolean estado;
    private Int32 idReserva;
    private Int32 idCliente;
    private Int32 idServicio;
    private Int32 precio;
    private string session;
    private bool registro;
    private bool disponibleSerie;





    public int Idestilista { get => idestilista; set => idestilista = value; }
    public DateTime Fechaini { get => fechaini; set => fechaini = value; }
    public DateTime Fechafin { get => fechafin; set => fechafin = value; }
    public bool Estado { get => estado; set => estado = value; }
    public int IdReserva { get => idReserva; set => idReserva = value; }
    public int IdCliente { get => idCliente; set => idCliente = value; }
    public int IdServicio { get => idServicio; set => idServicio = value; }
    public string Session { get => session; set => session = value; }
    public int Precio { get => precio; set => precio = value; }
    public bool Registro { get => registro; set => registro = value; }
    public bool DisponibleSerie { get => disponibleSerie; set => disponibleSerie = value; }
}