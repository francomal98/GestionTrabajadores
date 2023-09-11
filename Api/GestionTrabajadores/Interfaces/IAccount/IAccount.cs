using GestionTrabajadores.Models.AccountModel;
using Microsoft.AspNetCore.Mvc;

namespace GestionTrabajadores.Interfaces.IAccount
{
    public interface IAccount
    {
        IActionResult Login([FromBody] AccountModels account);
        IActionResult SignUp([FromBody] CreateAccount account);
        IActionResult RecoveryPassword([FromHeader] string usuario);
        IActionResult DeleteAccount();
        IActionResult UpdateInfoAccount([FromBody] UpdateAccount account);

    }
}
