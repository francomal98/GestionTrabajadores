using GestionTrabajadores.Interfaces.IWorkers;
using GestionTrabajadores.Models.WorkersModel;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Data;
using System.Data.SqlClient;

namespace GestionTrabajadores.Controllers.Worker
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class WorkersController : ControllerBase, IWorkers
    {
        private readonly IConfiguration _configuration;
        private readonly string connectionstring;
        public WorkersController(IConfiguration configuration)
        {
            connectionstring = configuration.GetConnectionString("SqlConnection");
        }


        [HttpPost]
        [Route("AddNewWorker")]
        public IActionResult AddNewWorker([FromBody] WorkersModel workers)
        {
            try
            {
                using(SqlConnection connection = new SqlConnection(connectionstring))
                {
                    if(connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    using(SqlCommand command = new SqlCommand())
                    {
                        command.CommandText = "STP_ADDNEWWORKER";
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@idusuario", workers.IdUser);
                        command.Parameters.AddWithValue("@nombre", workers.Nombre);
                        command.Parameters.AddWithValue("@apellidopat", workers.ApellidoPaterno);
                        command.Parameters.AddWithValue("@apellidomat", workers.ApellidoMaterno);
                        command.Parameters.AddWithValue("@cumpleanos", workers.FechaCumpleanos);
                        command.Parameters.AddWithValue("@contratacion", workers.FechaContratacion);
                        command.Parameters.AddWithValue("@telefono", workers.Telefono);
                        command.Parameters.AddWithValue("@email", workers.Email);
                        command.Parameters.AddWithValue("@municipio", workers.Municipio);
                        command.Parameters.AddWithValue("@estado", workers.Estado);
                        command.Parameters.AddWithValue("@tipotrabajador", workers.TipoTrabajador);

                        command.ExecuteNonQuery();

                        return StatusCode(StatusCodes.Status201Created, new { message = $"Trabajador {workers.Nombre} {workers.ApellidoPaterno} {workers.ApellidoMaterno} creado con éxito." });

                    }
                }
            } catch(Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { message = ex.Message });
            }
        }

        [HttpDelete]
        [Route("DeleteWorker")]
        public IActionResult DeleteWorker([FromHeader] string idworker)
        {
            try
            {
                using(SqlConnection conn = new SqlConnection(connectionstring))
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    using(SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "STP_DELETEWORKER";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = conn;
                        cmd.Parameters.AddWithValue("@idworker", idworker);

                        cmd.ExecuteNonQuery();

                        conn.Close();

                        return StatusCode(StatusCodes.Status200OK, new { message = "Trabajador eliminado correctamente." });
                    }
                }
            } catch(Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { message = ex.Message });
            }
        }

        [HttpGet]
        [Route("GetWorkersByUser")]
        public IActionResult GetWorkersByUser([FromHeader] string userId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionstring))
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    using (SqlCommand command = new SqlCommand())
                    {
                        command.CommandText = "STP_GETWORKERSBYIDUSER";
                        command.CommandType = CommandType.StoredProcedure;
                        command.Connection = conn;
                        command.Parameters.AddWithValue("@idusuario", userId);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                DataTable table = new DataTable();
                                table.Load(reader);
                                using (table)
                                {
                                    string jsonString = JsonConvert.SerializeObject(table);
                                    List<WorkersDbModel> workers = JsonConvert.DeserializeObject<List<WorkersDbModel>>(jsonString);
                                    conn.Close();
                                    return StatusCode(StatusCodes.Status200OK, new { workers });
                                }
                            } else
                            {
                                List<WorkersDbModel> workers = new List<WorkersDbModel>();
                                conn.Close();
                                return StatusCode(StatusCodes.Status200OK, new { workers });
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { message = ex.Message });
            }
        }

        [HttpPatch]
        [Route("UpdateWorkerInfo")]
        public IActionResult UpdateWorkerInfo([FromBody] WorkersUpdate workers)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionstring))
                {
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    using (SqlCommand command = new SqlCommand())
                    {
                        command.CommandText = "STP_UPDATEWORKERBYID";
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@idworker", workers.IdWorker);
                        if(workers.Nombre != "")
                        {
                            command.Parameters.AddWithValue("@nombre", workers.Nombre);
                        }

                        if (workers.ApellidoPaterno != "")
                        {
                            command.Parameters.AddWithValue("@apellidopat", workers.ApellidoPaterno);
                        }

                        if (workers.ApellidoMaterno != "")
                        {
                            command.Parameters.AddWithValue("@apellidomat", workers.ApellidoMaterno);
                        }

                        if (workers.FechaCumpleanos != "")
                        {
                            command.Parameters.AddWithValue("@cumpleanos", workers.FechaCumpleanos);
                        }

                        if (workers.FechaContratacion != "")
                        {
                            command.Parameters.AddWithValue("@contratacion", workers.FechaContratacion);
                        }

                        if (workers.Telefono != "")
                        {
                            command.Parameters.AddWithValue("@telefono", workers.Telefono);
                        }

                        if (workers.Email != "")
                        {
                            command.Parameters.AddWithValue("@email", workers.Email);
                        }

                        if (workers.Municipio != "")
                        {
                            command.Parameters.AddWithValue("@municipio", workers.Municipio);
                        }

                        if (workers.Estado != "")
                        {
                            command.Parameters.AddWithValue("@estado", workers.Estado);
                        }

                        if (workers.TipoTrabajador != "")
                        {
                            command.Parameters.AddWithValue("@tipotrabajador", workers.TipoTrabajador);
                        }

                        command.ExecuteNonQuery();

                        return StatusCode(StatusCodes.Status201Created, new { message = $"Trabajador {workers.Nombre} {workers.ApellidoPaterno} {workers.ApellidoMaterno} actualizado correctamente." });

                    }
                }
            } catch(Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { message = ex.Message });
            }
        }
    }
}
