using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Data.SqlClient;

namespace GestionTrabajadores.Controllers.Worker
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class WorkersController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly string connectionstring;
        public WorkersController(IConfiguration configuration)
        {
            connectionstring = configuration.GetConnectionString("SqlConnection");
        }

        //[HttpGet]
        //[Route("GetWorkersByUser")]
        //public IActionResult GetWorkersByUser([FromHeader] string userId)
        //{
        //    try
        //    {
        //        using (SqlConnection conn = new SqlConnection(connectionstring))
        //        {
        //            if (conn.State == ConnectionState.Closed)
        //            {
        //                conn.Open();
        //            }
        //            using (SqlCommand command = new SqlCommand())
        //            {
        //                command.CommandText = "STP_GETWORKERSBYUSER";
        //                command.CommandType = CommandType.StoredProcedure;
        //                command.Connection = conn;
        //                command.Parameters.AddWithValue("@userid", userId);
        //                using (SqlDataReader reader = command.ExecuteReader())
        //                {
        //                    if (reader.HasRows)
        //                    {
        //                        DataTable table = new DataTable();
        //                        table.Load(reader);
        //                        using (table)
        //                        {
        //                            return StatusCode(StatusCodes)
        //                        }
        //                    }
        //                }
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(StatusCodes.Status500InternalServerError, new { message = ex.Message });
        //    }
        //}
    }
}
