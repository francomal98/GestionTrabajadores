namespace GestionTrabajadores.Models.WorkersModel
{
    public class WorkersDbModel
    {
        public string NombreCompleto { get; set; }
        public DateTime FechaCumpleanos { get; set; }
        public DateTime FechaContratacion { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public string Municipio { get; set; }
        public string Estado { get; set; }
        public string TipoTrabajador { get; set; }
        public DateTime FechaRegistro { get; set; }
    }
}
