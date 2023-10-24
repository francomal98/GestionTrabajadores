namespace GestionTrabajadores.Models.WorkersModel
{
    public class WorkersModel
    {
        public int? IdUser { get; set; }
        public string Nombre { get; set; }
        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public string FechaCumpleanos { get; set; }
        public string FechaContratacion { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public string Municipio { get; set; }
        public string Estado { get; set; }
        public int TipoTrabajador { get; set; }
    }

    public class WorkersUpdate
    {
        public int? IdWorker { get; set; }
        public string? Nombre { get; set; }
        public string? ApellidoPaterno { get; set; }
        public string? ApellidoMaterno { get; set; }
        public string? FechaCumpleanos { get; set; }
        public string? FechaContratacion { get; set; }
        public string? Telefono { get; set; }
        public string? Email { get; set; }
        public string? Municipio { get; set; }
        public string? Estado { get; set; }
        public string? TipoTrabajador { get; set; }
    }
}
