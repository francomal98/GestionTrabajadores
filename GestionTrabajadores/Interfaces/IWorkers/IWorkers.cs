using GestionTrabajadores.Models.WorkersModel;
using Microsoft.AspNetCore.Mvc;

namespace GestionTrabajadores.Interfaces.IWorkers
{
    public interface IWorkers
    {
        IActionResult AddNewWorker([FromBody] WorkersModel workers);
        IActionResult GetWorkersByUser([FromHeader] string userId);
        IActionResult DeleteWorker([FromHeader] string idworker);
        IActionResult UpdateWorkerInfo([FromBody] WorkersUpdate workers);
    }
}
