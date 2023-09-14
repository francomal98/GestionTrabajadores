namespace GestionTrabajadores.Models.AccountModel
{
    public class AccountModels
    {
        public string Usuario { get; set; }
        public string Contraseña { get; set; }

    }

    public class CreateAccount
    {
        public string usuario { get; set; }
        public string password { get; set; }
        public string nombre { get; set; }
        public string apellidopaterno { get; set; }
        public string apellidomaterno { get; set; }
        public string correo { get; set; }
    }

    public class UpdateAccount
    {
        public string? username { get; set; }
        public string? nombre { get; set; }
        public string? apellidomat { get; set; }
        public string? apellidopat { get; set; }
    }
}
