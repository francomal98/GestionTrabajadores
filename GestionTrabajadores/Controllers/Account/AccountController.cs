using GestionTrabajadores.Interfaces.IAccount;
using GestionTrabajadores.Models.AccountModel;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using GestionTrabajadores.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using System.Security.Claims;

namespace GestionTrabajadores.Controllers.Account
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase, IAccount
    {
        private readonly IConfiguration configuration;
        private readonly string connectinstring;
        private readonly JwtService jwt = new JwtService();
        private readonly GeneratorIdService generator = new GeneratorIdService();
        private readonly EmailService mail = new EmailService();
        public AccountController(IConfiguration _configuration)
        {
            connectinstring = _configuration.GetConnectionString("SqlConnection");
            configuration = _configuration;
        }

        [HttpPost]
        [Route("Login")]
        public IActionResult Login([FromBody] AccountModels account)
        {
            try
            {
                using(SqlConnection conn = new SqlConnection(connectinstring))
                {
                    if(conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    using(SqlCommand command = new SqlCommand())
                    {
                        command.CommandText = "STP_GETLOGININFO";
                        command.Connection = conn;
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@usuario", account.Usuario);
                        using(SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                DataTable items = new DataTable();
                                items.Load(reader);
                                using (items)
                                {
                                    string responseText = JsonConvert.SerializeObject(items);
                                    List<AccountRespSql> userInfo = JsonConvert.DeserializeObject<List<AccountRespSql>>(responseText);

                                    bool result = BCrypt.Net.BCrypt.Verify(account.Contraseña, userInfo[0].Contraseña);

                                    if (result)
                                    {
                                        object response = jwt.GenerateJwt(configuration["SecreatKey"], userInfo[0].Id, userInfo[0].Usuario);
                                        return StatusCode(StatusCodes.Status200OK, new { response });
                                    } else
                                    {
                                        return StatusCode(StatusCodes.Status401Unauthorized, new { message = "Credenciales Invalidas" });
                                    }

                                }
                            } else
                            {
                                return StatusCode(StatusCodes.Status400BadRequest, new { message = "No existe registro de las credenciales proporcionadas"});
                            }
                        }
                    }
                }
            } catch(Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { error = ex.Message });
            }
        }

        [HttpPost]
        [Route("SignUp")]
        public IActionResult SignUp([FromBody] CreateAccount account)
        {
            try
            {
                using(SqlConnection connection = new SqlConnection(connectinstring))
                {
                    string identificador = generator.GenerateIdentifier();
                    string token = jwt.GenerateJwtActiveAccount(configuration["SecreatKeyActivate"], account.usuario);
                    if(connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    using(SqlCommand command = new SqlCommand())
                    {
                        command.CommandText = "STP_ACCOUNTSIGNUP";
                        command.Connection = connection;
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@usuario", account.usuario);
                        command.Parameters.AddWithValue("@nombre", account.nombre);
                        command.Parameters.AddWithValue("@apellidoP", account.apellidopaterno);
                        command.Parameters.AddWithValue("@apellidoM", account.apellidomaterno);
                        command.Parameters.AddWithValue("@correo", account.correo);
                        command.Parameters.AddWithValue("@contrasena", BCrypt.Net.BCrypt.HashPassword(account.password));
                        command.Parameters.AddWithValue("@token", token);
                        command.Parameters.AddWithValue("@identificador", identificador);

                        command.ExecuteNonQuery();
                        string nombreCompleto = $"{account.nombre} {account.apellidopaterno} {account.apellidomaterno}";
                        bool mailSend = mail.SendRecoveryActiveAccount(account.correo, nombreCompleto, "https://www.youtube.com/");
                        if (!mailSend)
                            return StatusCode(StatusCodes.Status400BadRequest, new { error = "Error al mandar el correo para la activación de cuenta" });

                        connection.Close();

                        return StatusCode(StatusCodes.Status201Created, new { message = "Usuario creado con éxto" });
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status200OK, new { error = ex.Message });
            }
        }

        [HttpPost]
        [Route("RecoveryPassword")]
        public IActionResult RecoveryPassword([FromHeader] string email)
        {
            try
            {
                string token = jwt.GenerateJwtRecoverPass(configuration["SecreatKeyRecovery"], 1);
                string identificador = generator.GenerateIdentifier();

                using(SqlConnection conn = new SqlConnection(connectinstring))
                {
                    if(conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    using(SqlCommand command = new SqlCommand())
                    {
                        command.CommandText = "STP_INSERTTOKENDB";
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@token", token);
                        command.Parameters.AddWithValue("@identificador", identificador);
                        command.Parameters.AddWithValue("@toketype", 1);
                        command.Connection = conn;
                        command.ExecuteNonQuery();
                        bool sendMail = mail.SendRecoveryPassMail(email, identificador);
                        if (!sendMail)
                            return StatusCode(StatusCodes.Status400BadRequest, new { error = "Error al mandar el correo para el cambio de contraseña" });

                        return StatusCode(StatusCodes.Status200OK, new { message = $"Se ha mandado el correo para el cambio de contraseña correctamente. {identificador}" });
                    }
                }

            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status200OK, new { error = ex.Message });
            }
        }

        [HttpDelete]
        [Route("DeleteAccount")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        public IActionResult DeleteAccount()
        {
            try
            {
                ClaimsPrincipal claims = HttpContext.User;
                int userId = Convert.ToInt32(claims.FindFirst("UserId")?.Value);
                using (SqlConnection conn = new SqlConnection(connectinstring))
                {
                    if(conn.State != ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    using(SqlCommand command = new SqlCommand())
                    {
                        command.CommandText = "STP_DELETEACCOUNT";
                        command.Connection = conn;
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@Userid", userId);
                        command.ExecuteNonQuery();

                        return StatusCode(StatusCodes.Status201Created, new { message = "La cuenta se ha eliminado correctamente." });
                    }
                }
                }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status200OK, new { error = ex.Message });
            }
        }

        [HttpPut]
        [Route("UpdateInfoAccount")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        public IActionResult UpdateInfoAccount([FromBody] UpdateAccount account)
        {
            try
            {
                ClaimsPrincipal claims = HttpContext.User;
                int userId = Convert.ToInt32(claims.FindFirst("UserId")?.Value);
                
                using(SqlConnection conn = new SqlConnection(connectinstring))
                {
                    if(conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    using(SqlCommand command = new SqlCommand())
                    {
                        command.CommandText = "STP_UPDATEACCOUNTINFO";
                        command.Connection = conn;
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@userid", userId);
                        if(account.username != "")
                        {
                            command.Parameters.AddWithValue("@username", account.username);
                        }
                        if (account.nombre != "")
                        {
                            command.Parameters.AddWithValue("@nombre", account.nombre);
                        }
                        if(account.apellidomat != "")
                        {
                            command.Parameters.AddWithValue("@apellidomat", account.apellidomat);
                        }
                        if (account.apellidopat != "")
                        {
                            command.Parameters.AddWithValue("@apellidopat", account.apellidopat);
                        }
                        
                        command.ExecuteNonQuery();

                        return StatusCode(StatusCodes.Status200OK, new { response = "Actualización correcta" });
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status200OK, new { error = ex.Message });
            }
        }

        [HttpPatch]
        [Route("PasswordChange")]
        public IActionResult PasswordChange([FromHeader] string identifier, [FromHeader] string password)
        {
            try
            {
                string _token = String.Empty;
                using (SqlConnection conn = new SqlConnection(connectinstring))
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    using (SqlCommand cmd = new SqlCommand()) 
                    {
                        cmd.CommandText = "STP_GETTOKENBYIDENTIFIER";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = conn;
                        cmd.Parameters.AddWithValue("@identificador", identifier);
                        cmd.Parameters.AddWithValue("@toketype", 1);
                        using(SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                DataTable table = new DataTable();
                                table.Load(reader);
                                using (table)
                                {
                                    var sqlResponse = JsonConvert.SerializeObject(table);
                                    List<AccountToken> token = JsonConvert.DeserializeObject<List<AccountToken>>(sqlResponse);
                                    _token = token[0].Token;
                                }
                            } 
                            else
                            {
                                return StatusCode(StatusCodes.Status400BadRequest, new { message = "No existe petición para el cambio de contraseña" });
                            }
                        }
                    }
                }

                string tokenExpire = jwt.ValidateToken(_token, configuration["SecreatKeyRecovery"], 1);

                if (tokenExpire == null)
                    return StatusCode(StatusCodes.Status400BadRequest, new { message = "Se ha terminado el tiempo para el cambio de contraseña. Favor de solicitar de nuevo." });

                using (SqlConnection conn = new SqlConnection(connectinstring))
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "STP_UPDATEACCOUNTPASSWORD";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = conn;
                        cmd.Parameters.AddWithValue("@userid", tokenExpire);
                        cmd.Parameters.AddWithValue("@password", BCrypt.Net.BCrypt.HashPassword(password));
                        cmd.ExecuteNonQuery();

                        return StatusCode(StatusCodes.Status202Accepted, new { message = "La contraseña ha sido cambiada con éxito" });
                    }
                }


            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { message = ex.Message });
            }
        }

        [HttpPatch]
        [Route("ActivateAccount")]
        public IActionResult ActivateAccount([FromHeader] string identifier)
        {
            try
            {
                string _token = String.Empty;
                using (SqlConnection conn = new SqlConnection(connectinstring))
                {
                    if(conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    using(SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "STP_GETTOKENBYIDENTIFIER";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = conn;
                        cmd.Parameters.AddWithValue("@identificador", identifier);
                        cmd.Parameters.AddWithValue("@toketype", 2);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                DataTable table = new DataTable();
                                table.Load(reader);
                                using (table)
                                {
                                    var sqlResponse = JsonConvert.SerializeObject(table);
                                    List<AccountToken> token = JsonConvert.DeserializeObject<List<AccountToken>>(sqlResponse);
                                    _token = token[0].Token;
                                }
                            }
                            else
                            {
                                return StatusCode(StatusCodes.Status400BadRequest, new { message = "No existe petición para el cambio de contraseña" });
                            }
                        }
                    }
                }

                string tokenValidation = jwt.ValidateToken(_token, configuration["SecreatKeyActivate"], 2);

                if(tokenValidation == null)
                    return StatusCode(StatusCodes.Status400BadRequest, new { message = "No existe petición para el cambio de contraseña" });

                using(SqlConnection conn = new SqlConnection(connectinstring))
                {
                    if(conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    using(SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "STP_ACTIVATEUSERACCOUNT";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = conn;
                        cmd.Parameters.AddWithValue("@username", tokenValidation);
                        cmd.ExecuteNonQuery();

                        return StatusCode(StatusCodes.Status200OK, new { message = "Activación de cuenta confirmada." });
                    }
                }


            } catch(Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { ex.Message });
            }
        }
    }
}
