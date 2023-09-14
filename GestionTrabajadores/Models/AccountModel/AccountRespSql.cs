namespace GestionTrabajadores.Models.AccountModel
{
    public class AccountRespSql
    {
        public int Id { get; set; }
        public string Usuario { get; set; }
        public string Contraseña { get; set; }
    }

    public class AccountToken
    {
        public string Token { get; set; }
    }
}
